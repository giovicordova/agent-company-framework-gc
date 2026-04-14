# Agent Company Framework

Three Claude Code skills that build and run teams of project-specific AI agents as **native Claude Code subagents with persistent memory**.

- **`/agent-company-creator`** — Design a team, generate tested subagents, cross-check boundaries. Interactive → autonomous → validated.
- **`/send-brief`** — Formalise conversation context into a polished brief and dispatch a live subagent in-session.
- **`/board-meeting`** — Round-table: each agent speaks as a real subagent, sequential threaded dispatch, unified recommendation.

## Architecture

```
.claude/
  agents/
    {agent}.md               # YAML frontmatter (name/description/tools/model/memory) + 6 body sections
  agent-memory/
    {agent}/                 # Claude Code manages this automatically (memory: project)
      MEMORY.md              # Auto-curated index, loaded into every dispatch

COMPANY.md                   # Roster + ownership map + conflict-resolution rules
CLAUDE.md                    # Project instructions; imports COMPANY.md
```

No `agent-company/` folder, no mailbox, no knowledge folders, no hand-written `mistakes.md`. All of it is replaced by Claude Code's native subagent primitives introduced in 2026.

## Design principles

- Agents are native Claude Code subagents — Claude Code's `description` frontmatter auto-routes requests.
- `memory: project` gives each subagent a persistent directory at `.claude/agent-memory/{name}/` that it curates itself.
- Every agent is project-specific — no generic roles.
- Explicit ownership boundaries with handoff rules. No overlaps.
- Personas are tested with real subagent dispatch before delivery (domain competence, boundary respect, handoff recognition).
- Cross-agent durable facts live in `CLAUDE.md` (auto-loaded by every session and every subagent).

## Install

**Project-local** (recommended for per-project teams):

```bash
git clone <this repo> my-project-agents
cd my-project-agents
mkdir -p .claude/skills
ln -sfn "$PWD/skills/agent-company-creator" .claude/skills/agent-company-creator
ln -sfn "$PWD/skills/send-brief"            .claude/skills/send-brief
ln -sfn "$PWD/skills/board-meeting"         .claude/skills/board-meeting
```

**User-global** (skills across every project):

```bash
ln -sfn "$PWD/skills/agent-company-creator" ~/.claude/skills/agent-company-creator
ln -sfn "$PWD/skills/send-brief"            ~/.claude/skills/send-brief
ln -sfn "$PWD/skills/board-meeting"         ~/.claude/skills/board-meeting
```

Requires [Claude Code](https://docs.anthropic.com/en/docs/claude-code) 2.1.59+ (for `memory:` frontmatter) and `jq` (for the eval harness).

## Quick start

```bash
# 1. Open your project in Claude Code
# 2. Create the team
/agent-company-creator

# 3. Work with an agent directly — Claude auto-routes via frontmatter description
# "Editor, scan-test this paragraph: ..."
# "Strategist, what's the moat on this?"

# 4. Hand work with formal context
/send-brief

# 5. Get the whole board on a decision
/board-meeting
```

## Evals

```bash
./evals/run.sh
```

Runs all three skills' eval cases through `claude -p`, grades via a judge pass, writes `evals/last-run.md`, compares against `evals/baseline.json`. Regressions beyond tolerance (default ±1 expectation per case) exit non-zero.

See `evals/README.md` for details and known limitations.

## Maintenance

- Run `./evals/run.sh` before committing any skill edit. Don't commit on regression.
- When a subagent misbehaves twice on the same thing, fix it in `.claude/agents/{name}.md` — not in a wrapper skill.
- Each agent's `MEMORY.md` is auto-curated by the agent. Review it periodically — if an agent's memory drifts off-topic, that's a signal the persona or description needs revising.
- Durable cross-agent facts go in `CLAUDE.md`. If it grows past ~150 lines, split into `.claude/rules/*.md`.

MIT
