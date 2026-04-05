# Agent Company Framework

A framework for assembling teams of specialised AI agents that work together on any project. Each agent owns a domain, has clear boundaries, communicates through structured briefs, and produces coherent work across the team.

Built for [Claude Code](https://docs.anthropic.com/en/docs/claude-code). Works with any project type — SaaS, creative, business operations, research.

## What It Does

One skill (`/agent-company-creator`) takes you from "here's my project" to a fully tested `agent-company/` folder:

1. **Company Design** — Interactive phase. Describe your project, get a proposed team of domain specialists with ownership maps, boundaries, and conflict resolution. Quality-gated before you review it.
2. **Agent Creation** — Autonomous. Each agent gets a PERSONA.md built and tested in parallel using calibration questions and iterative refinement.
3. **Company Activation** — Cross-checks the full team for boundary overlaps, handoff symmetry, and constraint contradictions. Runs a dry-run exercise.

A second skill (`/send-brief`) handles cross-session communication between agents via structured mailbox briefs.

## Output Structure

```
agent-company/
├── COMPANY.md              # Blueprint: roles, ownership map, boundaries
├── marketing/
│   ├── PERSONA.md          # Identity, voice, frameworks, boundaries, failure modes
│   ├── knowledge/          # On-demand research cache
│   └── mailbox/            # Incoming briefs from other agents
├── design/
│   ├── PERSONA.md
│   ├── knowledge/
│   └── mailbox/
└── ...
```

## Key Design Decisions

- **No generic roles.** Every agent is tailored to the specific project — a brewery gets different specialists than a SaaS platform.
- **Explicit boundaries.** Each agent defines what it owns, what it doesn't, and who it hands off to. No two agents own the same thing.
- **Tested personas.** Every agent is calibrated through domain competence, boundary respect, and handoff recognition tests before delivery.
- **Cross-session communication.** Agents work in separate Claude Code sessions. The mailbox system bridges them with structured briefs.
- **On-demand knowledge.** No pre-loaded knowledge bases. Agents research when needed and cache findings to avoid duplicate work.

## Usage

### Create an agent company

```
/agent-company-creator
```

Describe your project. The skill handles the rest — designing the team, creating agents, testing them, and delivering the folder.

### Send a brief between agents

```
/send-brief
```

Formalises the current conversation into an actionable brief and delivers it to another agent's mailbox.

### Work with an agent

Open a new Claude Code session and load the agent's PERSONA.md. The agent checks its mailbox for incoming briefs and its knowledge folder for cached research.

## Installation

Copy the `skills/` folder into your Claude Code project's `.claude/skills/` directory, or install as a [Claude Code skill](https://docs.anthropic.com/en/docs/claude-code/skills).

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code)
- A project to build agents for

## License

MIT
