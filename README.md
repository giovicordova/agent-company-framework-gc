# Agent Company Framework

Two skills for building and running project-specific agent teams as native Claude Code subagents with persistent memory.

- **`/agent-company-creator`** — Design, generate, and validate a team. Interactive design → autonomous build → tested delivery.
- **`/board-meeting`** — Sequential round-table across all agents, unified recommendation.

Structured handoff to a single agent uses Claude Code's native subagent dispatch — no dedicated skill needed.

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

No mailbox, no knowledge folders, no hand-written `mistakes.md` — replaced by Claude Code's native subagent primitives.

## Design principles

- Native subagents — `description` frontmatter auto-routes.
- `memory: project` — each agent curates `.claude/agent-memory/{name}/` itself.
- Project-specific personas. No generic roles.
- Explicit ownership, defined handoffs, zero overlap.
- Personas validated via real dispatch before delivery.
- Durable cross-agent facts live in `CLAUDE.md`, auto-loaded everywhere.

## Install

**Project-local** (recommended for per-project teams):

```bash
git clone <this repo> my-project-agents
cd my-project-agents
mkdir -p .claude/skills
ln -sfn "$PWD/skills/agent-company-creator" .claude/skills/agent-company-creator
ln -sfn "$PWD/skills/board-meeting"         .claude/skills/board-meeting
```

**User-global** (skills across every project):

```bash
ln -sfn "$PWD/skills/agent-company-creator" ~/.claude/skills/agent-company-creator
ln -sfn "$PWD/skills/board-meeting"         ~/.claude/skills/board-meeting
```

Requires [Claude Code](https://docs.anthropic.com/en/docs/claude-code) 2.1.59+ (`memory:` frontmatter) and `jq` (evals).

## Quick start

```bash
# 1. Open your project in Claude Code
# 2. Create the team
/agent-company-creator

# 3. Work with an agent directly — Claude auto-routes via frontmatter description
# "Editor, scan-test this paragraph: ..."
# "Strategist, what's the moat on this?"

# 4. Get the whole board on a decision
/board-meeting
```

## Evals

```bash
./evals/run.sh
```

Runs every skill's cases through `claude -p`, judge-grades, writes `evals/last-run.md`, diffs against `evals/baseline.json`. Regressions beyond ±1 expectation per case exit non-zero. See `evals/README.md` for details.

## Maintenance

- `./evals/run.sh` before every skill edit. No commit on regression.
- Recurring misbehaviour → fix `.claude/agents/{name}.md`, not a wrapper skill.
- Review each agent's `MEMORY.md` periodically. Drift signals a persona or description problem.
- Cross-agent facts in `CLAUDE.md`. Past ~150 lines, split into `.claude/rules/*.md`.

MIT
