---
name: agent-company-creator
description: Design and build a complete team of specialised AI agents for any project as native Claude Code subagents with persistent memory. Use when the user wants to create an agent team, assemble a company of agents, set up domain specialists, build an agent company, or says things like "I need agents for my project", "create a team for this", "set up my agent company", "build agents for [project]", "I want specialists working on this", or "agent-company-creator". Also triggers when the user describes a project and implies they need multiple AI personas collaborating, or when they want to restructure or recreate an existing agent company from scratch. Covers the full pipeline from brainstorming roles to delivering tested, ready-to-use subagents in `.claude/agents/` with a `COMPANY.md` blueprint at the project root. Does NOT trigger for single-agent creation, sending briefs between agents, or working with existing personas.
---

# Agent Company Creator

Turn a project description into a calibrated team of specialised Claude Code subagents in one session. Output: `.claude/agents/*.md` (one per role), `COMPANY.md` at project root, and an activation summary.

## Why this exists

An agent company is set up once and reused across thousands of sessions. The difference between a team that holds up under real work and a set of files that never get opened is specificity — distinct voices, real domain frameworks, precise boundaries, disciplined sourcing. This skill forces those choices and tests them before the user commits.

## The session boundary, handled

Claude Code registers subagents at session start, so agents written mid-session cannot be dispatched via `subagent_type` in the same session. Calibration and routing checks therefore use a general-purpose agent with the persona's `.md` content injected as its system prompt. Same text Claude Code's router would see; just dispatched differently. Trade-off: skips live routing-registration verification in favour of completing the pipeline in one session.

## Pipeline

### 1. Probe the project

Before proposing a team, get these answers from the user:

- What does the project actually produce? (outputs, audience, stakes)
- What exists already? (codebase, brand, content, stakeholders, infrastructure)
- Hard constraints? (deadlines, budgets, regulations, non-negotiables)
- Where does the user currently feel stuck or understaffed?
- One concrete example of a recent decision or task they'd want the team to handle.

One focused round, not an interview ladder. Don't write files until these are answered.

### 2. Propose team + sizing rationale

Draft a roster. For each role: one-line identity, one-line boundary. Then defend the number — why four and not six, why this split and not another, where the overlap risk is, where the orphan risk is.

Share with the user. Steel-man their instinct, then stress-test it. If they proposed three agents and the project actually needs four, argue for four with reasoning. Revise once if they push back. Don't write any agent files until the team shape is agreed.

### 2.5 Verify against current docs (preflight)

Before writing any agent files, fetch `https://code.claude.com/docs/llms.txt` and open the `sub-agents` and `skills` pages. Confirm:

- The frontmatter fields in `references/agent-schema.md` (`name`, `description`, `tools`, `model`, `memory`) are all still valid and named the same.
- The `memory:` field still accepts `user | project | local` and still stores to `.claude/agent-memory/<name>/` for the project scope.
- No new required field has been added.

If anything has shifted, note the drift in the activation summary and prefer the docs over `references/agent-schema.md`. Do not silently rewrite the reference file — flag it for Giovanni to update by hand.

### 3. Write the agents (parallel)

Dispatch one general-purpose subagent per role in a single turn. Each receives:

- Project context from Step 1
- Role definition and boundaries from Step 2
- The schema in `references/agent-schema.md`
- Instruction to write the file to `.claude/agents/{lowercase-name}.md` and follow the schema exactly

Parallelise. Don't narrate each agent being written.

### 4. Calibrate each agent

For every agent, dispatch one general-purpose subagent with the agent's full `.md` as system prompt and run the six-category probe in `references/calibration.md`:

1. Domain competence
2. Boundary respect
3. Handoff recognition
4. Source-of-truth adherence
5. Voice consistency
6. Research-first discipline

Grade each probe pass/fail with one-sentence evidence anchored to the actual response. If a category fails, revise the `.md` once and retry that category. If the second attempt fails, flag the defect in the final summary — don't loop, don't hand-wave.

Persist transcripts to `.claude/agent-calibration/{name}.md` only if useful for debugging; otherwise keep ephemeral.

### 5. Routing sanity check

Generate 8–12 realistic user prompts a real user in this project would send (mix of core-domain, edge-case, and ambiguous phrasings). Dispatch one general-purpose subagent with all N agent descriptions and ask it to pick the best match for each prompt or mark "ambiguous" if two fit equally well.

Run it twice. Flag any prompt that:

- Returns a tie or "ambiguous"
- Gets a different answer on the second run
- Returns "none" — coverage gap

If anything flags, revise the offending `description` fields once to sharpen triggers or exclusions, and re-run. Report the final result in the activation summary.

### 6. Write COMPANY.md at project root

Required sections:

- **Roster** — name, role, one-line description per agent.
- **Sizing rationale** — one paragraph defending team size and composition. Why this number, why this split.
- **Ownership map** — table with columns `Concern | Owner | Notes`. Every concern from Step 1 covered. No concern owned by two agents.
- **Handoff rules** — when agent X hands to agent Y. Match each agent's `Hands off to` section.
- **Conflict resolution** — a **markdown table** with columns `Boundary | Agent A | Agent B | Resolution`, one row per real boundary edge between agents. Default tie-breaker: the agent whose ownership the decision falls under wins. The table makes the edges scannable and checkable against each agent's `Hands off to` section; prose or bullet lists here are a schema defect.

Cross-check: ownership map must align with each agent's `Owns` section. Any drift is a schema bug — fix it before moving on.

### 7. Activation summary

One short message to the user. Include:

- File paths written, agent count.
- Calibration results per agent (pass / flagged with defect).
- Routing check result (clean / flags with which descriptions were revised).
- How to dispatch an agent directly, and a pointer to the `board-meeting` skill for round-tables.

Don't narrate the pipeline. Report what was built and what's worth the user's attention.

## Hard constraints

- **Write to `.claude/agents/`**, never `./agents/` at project root. Some sandboxes silently strip the `.claude/` prefix — verify the path after writing and warn the user if it was stripped.
- **No `agent-company/` directory.** That pattern is obsolete.
- **Every frontmatter includes `memory: project`** — activates persistent memory at `.claude/agent-memory/{name}/`.
- **Tools are scoped** per agent. A research agent doesn't need `Edit`; a writer doesn't need `Bash`. Padding the tools list is a schema defect.
- **Calibration transcripts, if persisted, go to `.claude/agent-calibration/`** — never elsewhere.

## Failure modes to guard against

- **Generic personas.** "Business analyst" that would fit any company is useless. Force domain-specific frameworks and voice examples in Step 3, and let the calibration Domain Competence probe catch any that slipped through.
- **Overlapping descriptions.** Two agents competing for the same triggers fragments routing. Step 5 catches this.
- **Orphan concerns.** A responsibility in the ownership map that no agent's description would trigger. Step 6's cross-check catches this.
- **Tool bloat.** Every agent given every tool, just in case. Scope per role; reject grants.
- **Skipped sizing rationale.** "We picked five agents" without argument produces an arbitrary company. Step 2 and COMPANY.md both require the defence.
- **Narration over work.** The pipeline is the work, not a ceremony to describe. Do each step; report only what the user needs.

## References

- `references/agent-schema.md` — full frontmatter + six-section body contract, with one complete example.
- `references/calibration.md` — the six probe templates and grading rubric.
