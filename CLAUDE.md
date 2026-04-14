# CLAUDE.md

## What this is

See [README.md](README.md).

## Project structure

```
.claude/agents/           # Native subagents — Claude Code auto-delegates via frontmatter
  strategist.md
  editor.md
  recruiter.md

skills/
  agent-company-creator/   # Main skill — creates the agent team
  send-brief/              # Formalises context and dispatches a live subagent
  board-meeting/           # Round-table with sequential subagent dispatch

evals/                     # Eval harness (run ./evals/run.sh)
COMPANY.md                 # Roster + ownership map + conflict-resolution rules
```

Each skill has a `SKILL.md` and an `evals/evals.json`.

## Conventions

- Agents are native Claude Code subagents (`.claude/agents/*.md`), discovered via frontmatter.
- Each agent has `memory: project` frontmatter → persistent memory at `.claude/agent-memory/{name}/` (auto-managed).
- Handoffs between agents happen via the `Agent` tool (`subagent_type: {name}`), not filesystem mailboxes.
- Evals test adversarial cases, not just happy paths.

## When editing skills

- Read the full `SKILL.md` before making changes.
- Run `./evals/run.sh` after any modification. Don't commit on regression.
- Keep skills self-contained — no cross-skill imports or shared state.

@COMPANY.md
