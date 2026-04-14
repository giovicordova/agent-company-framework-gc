# Evals

Run: `./evals/run.sh`

What it does:
1. For each skill (`agent-company-creator`, `board-meeting`), iterates over `skills/{skill}/evals/evals.json` cases.
2. For each case, runs `claude -p "<prompt>"` to execute the skill headlessly.
3. Pipes the transcript into a second `claude -p` pass with `evals/grade.md` as the rubric, which returns JSON scoring each expectation.
4. Aggregates results into `evals/last-run.md` and per-case artefacts into `evals/results/{timestamp}/`.
5. If `evals/baseline.json` exists, compares current run against it. Fails (exit 1) if any case regresses by more than `EVAL_TOLERANCE` expectations (default: 1).
6. If no baseline exists, writes the current run as the baseline.

## Known limitations

- **Interactive skills don't fully execute headlessly.** `agent-company-creator` asks for approval between Phase 1 and Phase 2. In headless mode, the transcript captures Phase 1 output only. Grading accepts partial output — expectations that require Phase 2/3 artefacts will fail until the harness adds scripted multi-turn.
- **Judge non-determinism.** LLM-as-judge can return slightly different scores on re-runs. Use `EVAL_TOLERANCE` to absorb normal variance; investigate only regressions beyond it.
- **Token cost.** A full run is ~24 `claude -p` calls. Run before committing a skill edit, not on every save.

## Commit discipline

- Run `./evals/run.sh` before committing skill edits. Don't commit on a non-zero exit.
- Commit `evals/baseline.json` alongside the skill edit if the new behaviour is intended (e.g., added expectations).
- Do not commit `evals/results/` — artefacts are per-run and noisy. The repo's `.gitignore` should cover this.
