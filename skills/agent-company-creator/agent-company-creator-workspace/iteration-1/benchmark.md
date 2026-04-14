# agent-company-creator — iteration-1 benchmark

**Date:** 2026-04-14 · **Cases:** 3 · **Runs per config:** 1

## Headline

| Configuration | Pass rate | Passed | Wall time (mean) | Tokens (mean) |
|---------------|----------:|-------:|-----------------:|--------------:|
| **with_skill** | **98.3%** | 59/60 | 9.0 min | 62 K |
| without_skill | 15.0% | 9/60 | 3.4 min | 39 K |
| **Δ** | **+83.3 pp** | +50 | +5.6 min | +23 K |

The skill costs ~2.7× wall time and ~1.6× tokens. It buys +83 pp of pass rate.

## Per-case breakdown

| Eval | With-skill | Baseline | Δ | Notes |
|------|-----------:|---------:|---:|-------|
| 1 — brewery (greenfield) | 19/20 (95%) | 5/20 (25%) | +70 pp | One failure (pre-fix); skill patched after |
| 2 — music studio (non-technical) | **20/20 (100%)** | 2/20 (10%) | +90 pp | Clean post-fix |
| 3 — SaaS restaurant (existing codebase) | **20/20 (100%)** | 2/20 (10%) | +90 pp | Clean post-fix; agents cite real paths |

## What the skill delivers consistently

- **Schema discipline** — every with-skill run produces the 6-section body (Identity, Voice, Analytical Frameworks, Boundaries, Failure Modes, Standing Instructions) with correct frontmatter (`name`, `description`, `tools`, `model`, `memory: project`).
- **Domain-grounded frameworks** — not generic advice. Brewery: Portman Group, CAP code, BJCP, WCAG 2.2 AA, Baymard, LCP 2.5s. Music studio: Fit-Budget-Urgency, Hook-Hold-Payoff, Deposit-Milestone-Balance, Green/Amber/Red. SaaS: named PRD/roadmap, `src/app/(dashboard)/`, `supabase/migrations/`, multi-tenant RLS.
- **Calibration actually runs** — 24/24, 24/24, 36/36 explicit pass-with-evidence across the three cases. No narrated proof.
- **Challenges the user** — brewery user's 3-agent proposal became 4 with justification; SaaS user's 6-agent proposal was evaluated (landed at 6 with two adjacent specialists justified).
- **Ownership hygiene** — no duplicate concerns; conflict resolution tables carve real boundary edges.

## What the baseline produces

Baselines are not useless. Across all three cases they produced:
- Sensible agent rosters with non-overlapping ownership.
- Strong domain coverage (UK alcohol regs, finance chasing rhythms, Supabase RLS).
- Reasonable handoff rules.

But they fail **every** v2.1 structural assertion — no 6-section body, no `memory: project`, no v2.1 Standing Instructions, COMPANY.md uses ad-hoc table columns instead of Concern/Owner/Notes, no conflict-resolution table. The skill's contribution is structural conformity + calibration discipline on top of generally competent domain thinking.

## Bug surfaced and fixed

**Eval-1 failure** (the only one): `Phase 2.2 — Test each subagent` in the v2 skill instructed the executor to save calibration transcripts under `agent-company/{name}/calibration-responses.md`. That directly contradicted Phase 3.5 (no `agent-company/` folder should exist).

Fixed in `SKILL.md`: calibration records now go to `.claude/agent-calibration/{name}.md` or stay ephemeral. Post-fix runs (eval-2, eval-3) hit 20/20.

## Sandbox observations

- All six runs hit `.claude/` write denials and fell back to `agents/` and `agent-calibration/`. Harness constraint, not a skill defect. Graders applied path-substitution equivalence and evaluated structure on content.
- One of six runs (eval-3 with-skill) failed on a Write-denial at the sandbox itself and had to be retried. Retry succeeded with the same prompt. Intermittent.

## Grader feedback (suggestions for iteration 2)

Every grader raised variations of these four:

1. **Replace transcript-dependent assertions with output artefacts** — "transcript shows evidence of quality gate" is fragile when transcripts aren't persisted to outputs_dir. Require a named on-disk artefact instead (e.g., the final summary naming which checklist items passed).
2. **Split `memory: project` into two assertions** — presence of frontmatter key AND Standing Instructions that describe how to use it. Currently the frontmatter flag is trivially satisfied; pair with behavioural check.
3. **Add a cross-agent routing-coherence assertion** — do any two agents' `description` fields overlap such that Claude Code would route ambiguously? The skill doesn't currently test for this.
4. **Add a team-sizing rationale artefact** — "evaluates whether N agents is right" passes indistinguishably from blind acceptance. Require an explicit rationale sentence in COMPANY.md.

## Cost-benefit read

Single-run data, so variance is unknown. But the signal is stark:

- With the skill, the output conforms to a strict machine-readable contract that makes the team immediately useful (Claude Code auto-delegates via descriptions, subagents auto-load memory, ownership is checkable).
- Without the skill, the output looks useful but lacks the structural affordances the framework depends on. It won't plug into the rest of the framework without rewrite.
- The token/time premium (~2.7× / 1.6×) is modest relative to the pass-rate gain (+83 pp) and one-shot nature of the task — an agent company is set up once and then reused across thousands of sessions.

## Recommended next actions

1. **Iteration 2 (optional)**: apply the four grader suggestions to the eval assertions and re-run. Expected: tightens discrimination without changing headline result.
2. **Multi-run variance pass (optional)**: run each with-skill case 3× to establish variance bounds on pass rate and wall time.
3. **Regression guard**: run `./evals/run.sh` before any future skill edit — the automated harness plugs into these eval cases directly.
