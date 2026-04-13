# Agent Company Framework

Three Claude Code skills that build and run teams of project-specific AI agents.

- **`/agent-company-creator`** — Design a team, create tested personas, cross-check boundaries. Interactive → autonomous → validated.
- **`/send-brief`** — Structured mailbox communication between agents across sessions.
- **`/board-meeting`** — Round-table: every agent speaks in character, delivers a unified recommendation.

## Output

```
agent-company/
├── COMPANY.md          # Roles, ownership map, boundaries
├── {agent}/
│   ├── PERSONA.md      # Identity, voice, frameworks, failure modes
│   ├── knowledge/      # On-demand research cache
│   └── mailbox/        # Incoming briefs
└── ...
```

## Design Principles

- Every agent is project-specific — no generic roles.
- Explicit ownership boundaries with handoff rules. No overlaps.
- Personas are tested (domain competence, boundary respect, handoff recognition) before delivery.
- Cross-session communication via structured mailbox briefs.
- Knowledge is researched on demand and cached — never pre-loaded.

## Usage

| Command | What it does |
|---|---|
| `/agent-company-creator` | Describe your project → get a tested `agent-company/` folder |
| `/send-brief` | Formalise conversation into a brief, deliver to an agent's mailbox |
| `/board-meeting` | All agents weigh in on a decision, produce a shared recommendation |

To work with an agent: open a new Claude Code session, load its `PERSONA.md`. It checks its mailbox and knowledge folder automatically.

## Install

Copy `skills/` into `.claude/skills/`, or install as a [Claude Code skill](https://docs.anthropic.com/en/docs/claude-code/skills).

Requires [Claude Code](https://docs.anthropic.com/en/docs/claude-code) and a project.

MIT
