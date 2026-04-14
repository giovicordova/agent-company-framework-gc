#!/usr/bin/env bash
# evals/run.sh — run every skill's evals via headless claude, grade via a judge pass,
# aggregate into evals/last-run.md, and compare against evals/baseline.json.
#
# Exits non-zero if any case regresses by more than 1 expectation vs baseline.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"
RESULTS="$ROOT/evals/results/$STAMP"
BASELINE="$ROOT/evals/baseline.json"
RUBRIC="$ROOT/evals/grade.md"
REPORT="$ROOT/evals/last-run.md"
TOLERANCE="${EVAL_TOLERANCE:-1}"   # max allowed drop per case

mkdir -p "$RESULTS"

command -v claude >/dev/null || { echo "claude CLI not on PATH"; exit 1; }
command -v jq >/dev/null || { echo "jq not on PATH"; exit 1; }

SKILLS=(agent-company-creator board-meeting)

# Build the baseline accumulator; we rewrite baseline.json if missing at the end.
CURRENT_JSON='{}'

echo "Eval run: $STAMP"
echo "Results: $RESULTS"
echo

for skill in "${SKILLS[@]}"; do
  EVALS="$ROOT/skills/$skill/evals/evals.json"
  if [[ ! -f "$EVALS" ]]; then
    echo "[$skill] skipped — no evals/evals.json (not tracked in this repo)"
    continue
  fi
  NUM=$(jq '.evals | length' "$EVALS")
  echo "[$skill] $NUM cases"

  for i in $(seq 0 $((NUM - 1))); do
    CID=$(jq -r ".evals[$i].id" "$EVALS")
    PROMPT=$(jq -r ".evals[$i].prompt" "$EVALS")
    EXPECT_JSON=$(jq -c ".evals[$i].expectations" "$EVALS")

    printf "  case %s … " "$CID"

    TRANSCRIPT="$RESULTS/$skill-$CID-transcript.md"
    GRADING="$RESULTS/$skill-$CID-grading.json"

    # 1. Execute the skill headlessly.
    if ! claude -p "$PROMPT" > "$TRANSCRIPT" 2>&1; then
      echo "(execution failed; graded as empty transcript)"
    fi

    # 2. Judge the transcript.
    JUDGE_PROMPT=$(cat <<EOF
$(cat "$RUBRIC")

---

## Skill
$skill

## Case ID
$CID

## Expectations (JSON array)
$EXPECT_JSON

## Transcript
$(cat "$TRANSCRIPT")
EOF
)

    RAW="$(claude -p "$JUDGE_PROMPT" 2>/dev/null || true)"
    # Strip code fences if the judge wrapped the JSON.
    echo "$RAW" | sed -n '/^{/,/^}/p' > "$GRADING" || true
    if [[ ! -s "$GRADING" ]]; then
      # Fall back to raw; jq will fail downstream if malformed.
      echo "$RAW" > "$GRADING"
    fi

    P=$(jq -r '.summary.passed // 0' "$GRADING" 2>/dev/null || echo 0)
    T=$(jq -r '.summary.total  // 0' "$GRADING" 2>/dev/null || echo 0)
    printf "%s/%s\n" "$P" "$T"

    CURRENT_JSON=$(jq \
      --arg s "$skill" --arg c "$CID" \
      --argjson p "$P" --argjson t "$T" \
      '.[$s][$c] = {passed: $p, total: $t}' <<<"$CURRENT_JSON")
  done
done

# --- Aggregate ---

{
  echo "# Eval Run — $(date -u +'%Y-%m-%d %H:%M UTC')"
  echo
  echo "| Skill | Passed | Total | Rate |"
  echo "|-------|-------:|------:|-----:|"
} > "$REPORT"

TP=0; TT=0
for skill in "${SKILLS[@]}"; do
  SP=$(jq -r --arg s "$skill" '.[$s] | to_entries | map(.value.passed) | add // 0' <<<"$CURRENT_JSON")
  ST=$(jq -r --arg s "$skill" '.[$s] | to_entries | map(.value.total)  | add // 0' <<<"$CURRENT_JSON")
  TP=$((TP + SP)); TT=$((TT + ST))
  RATE="N/A"
  [[ "$ST" -gt 0 ]] && RATE=$(awk "BEGIN { printf \"%.0f%%\", $SP / $ST * 100 }")
  echo "| $skill | $SP | $ST | $RATE |" >> "$REPORT"
done
OVERALL="N/A"
[[ "$TT" -gt 0 ]] && OVERALL=$(awk "BEGIN { printf \"%.0f%%\", $TP / $TT * 100 }")
echo "| **total** | **$TP** | **$TT** | **$OVERALL** |" >> "$REPORT"

echo >> "$REPORT"
echo "Artefacts: \`evals/results/$STAMP/\`" >> "$REPORT"

# --- Baseline compare or init ---

REGRESSIONS=0
if [[ -f "$BASELINE" ]]; then
  echo >> "$REPORT"
  echo "## Baseline comparison (tolerance: ±$TOLERANCE per case)" >> "$REPORT"
  echo >> "$REPORT"
  echo "| Skill | Case | Baseline | Current | Δ |" >> "$REPORT"
  echo "|-------|-----:|---------:|--------:|--:|" >> "$REPORT"

  for skill in "${SKILLS[@]}"; do
    EVALS="$ROOT/skills/$skill/evals/evals.json"
    for CID in $(jq -r '.evals[].id' "$EVALS"); do
      BP=$(jq -r --arg s "$skill" --arg c "$CID" '.[$s][$c].passed // "-"' "$BASELINE")
      CP=$(jq -r --arg s "$skill" --arg c "$CID" '.[$s][$c].passed // 0' <<<"$CURRENT_JSON")
      if [[ "$BP" == "-" ]]; then
        DELTA="(new)"
      else
        D=$((CP - BP))
        if   (( D < -TOLERANCE )); then DELTA="$D ⚠️"; REGRESSIONS=$((REGRESSIONS + 1))
        elif (( D > 0 ));          then DELTA="+$D"
        else                            DELTA="$D"
        fi
      fi
      echo "| $skill | $CID | $BP | $CP | $DELTA |" >> "$REPORT"
    done
  done

  if (( REGRESSIONS > 0 )); then
    echo >> "$REPORT"
    echo "**$REGRESSIONS regression(s) beyond tolerance.** Do not commit." >> "$REPORT"
  fi
else
  echo >> "$REPORT"
  echo "No baseline found. Writing current run as \`evals/baseline.json\`." >> "$REPORT"
  echo "$CURRENT_JSON" | jq '.' > "$BASELINE"
fi

echo
echo "See $REPORT"
(( REGRESSIONS == 0 ))
