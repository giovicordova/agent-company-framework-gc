# Agent Company Framework

Two skills for designing and running project-specific teams of Claude Code subagents.

- **`/agent-company-creator`** — Designs the team. Interviews you about the project, proposes a roster with a sizing argument, and writes a single `COMPANY.md` with paste-ready descriptions for Claude Code's built-in `/agents` command.
- **`/board-meeting`** — Convenes every agent in `.claude/agents/` as a sequential round-table, threading prior turns into each next prompt, and synthesises a board recommendation.

Structured handoff to a single agent uses Claude Code's native subagent dispatch — no dedicated skill needed.

## What the creator skill does (and doesn't)

It designs the team and writes the blueprint. It does **not** scaffold agent files.

1. `/agent-company-creator` interviews you and writes `COMPANY.md` at the project root.
2. `COMPANY.md` contains, for each agent, a self-contained "Description for `/agents`" block.
3. You create each agent with Claude Code's built-in `/agents` command, pasting the description.

The hard part of an agent company is the design — which roles need to exist, where the boundaries fall, what happens when territory overlaps. File creation is already handled well by `/agents`.

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

Requires [Claude Code](https://docs.anthropic.com/en/docs/claude-code) and `jq` (for evals).

## Quick start

```bash
# 1. Open your project in Claude Code.
# 2. Design the team.
/agent-company-creator
#    → produces COMPANY.md at the project root.

# 3. Create each agent with Claude Code's built-in command.
/agents
#    → for each entry in COMPANY.md, give the agent its name and paste the
#      "Description for /agents" block. Repeat per agent.

# 4. Work with an agent directly — Claude auto-routes via frontmatter description.
#    "Editor, scan-test this paragraph: ..."
#    "Strategist, what's the moat on this?"

# 5. Get the whole board on a decision.
/board-meeting
```

## Evals

```bash
./evals/run.sh
```

Runs every skill's cases through `claude -p`, judge-grades, writes `evals/last-run.md`, diffs against `evals/baseline.json`. Regressions beyond ±1 expectation per case exit non-zero. See `evals/README.md` for details.

## Maintenance

- `./evals/run.sh` before every skill edit. No commit on regression.
- If a team's routing or boundaries drift, rerun `/agent-company-creator` to redesign, then recreate agents with `/agents`.
- Recurring misbehaviour in a single agent → edit its file in `.claude/agents/{name}.md`, not the skill.

MIT
