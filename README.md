# Agent Company Framework

Two skills for designing and running project-specific teams of Claude Code subagents.

- **`/agent-company-creator`** — Designs the team. Interviews you, proposes a roster with a sizing argument, and writes `COMPANY.md` with paste-ready descriptions for Claude Code's built-in `/agents` command.
- **`/board-meeting`** — Sequential round-table across every agent in `.claude/agents/`. Prior turns thread into each next prompt; the main session synthesises the recommendation.

Single-agent handoff uses Claude Code's native subagent dispatch — no dedicated skill needed.

## What the creator skill does (and doesn't)

It designs the team. It does **not** scaffold agent files.

1. `/agent-company-creator` interviews you and writes `COMPANY.md`.
2. Each entry contains a self-contained "Description for `/agents`" block.
3. You create each agent via `/agents`, pasting that block.

The hard part is the design — which roles exist, where boundaries fall, what happens when territory overlaps. File creation is what `/agents` already handles.

## Install

**Project-local** (per-project team):

```bash
git clone <this repo> my-project-agents
cd my-project-agents
mkdir -p .claude/skills
ln -sfn "$PWD/skills/agent-company-creator" .claude/skills/agent-company-creator
ln -sfn "$PWD/skills/board-meeting"         .claude/skills/board-meeting
```

**User-global** (skills everywhere):

```bash
ln -sfn "$PWD/skills/agent-company-creator" ~/.claude/skills/agent-company-creator
ln -sfn "$PWD/skills/board-meeting"         ~/.claude/skills/board-meeting
```

Requires [Claude Code](https://docs.anthropic.com/en/docs/claude-code).

## Quick start

```bash
# 1. Open your project in Claude Code.
# 2. Design the team.
/agent-company-creator
#    → writes COMPANY.md.

# 3. Create each agent.
/agents
#    → for each entry in COMPANY.md, give it the name and paste the
#      "Description for /agents" block.

# 4. Work with an agent — Claude routes by frontmatter description.
#    "Editor, scan-test this paragraph: ..."

# 5. Convene the whole board on a decision.
/board-meeting
```

## Maintenance

- Routing or boundaries drifting → rerun `/agent-company-creator`, recreate agents via `/agents`.
- Recurring misbehaviour in one agent → edit `.claude/agents/{name}.md`, not the skill.

MIT
