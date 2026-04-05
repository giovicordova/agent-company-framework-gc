# Agent Company Framework

A reusable system for assembling teams of specialised AI agents that work together as a company on any project. Each agent owns a domain, has deep knowledge, communicates through structured briefs, and produces work that is coherent across the team.

---

## How It Works

One skill does the whole job: `/agent-company-creator`. You describe your project, the skill designs the company, creates every agent, tests them, and delivers a ready-to-use `agent-company/` folder.

### Pipeline Overview

```
┌─────────────────────────────────────────────────────────────┐
│  1. COMPANY DESIGN                                          │
│     Interactive phase. You describe the project — either     │
│     through conversation or a written brief.                │
│     The skill proposes a company: agents, roles,            │
│     boundaries, ownership map.                              │
│                                                             │
│     You can suggest agents — the skill will adversarially   │
│     evaluate and challenge them before accepting.           │
│                                                             │
│     Quality gate: the skill runs a dedicated checklist      │
│     against the proposed company (coverage gaps, redundant  │
│     roles, missing handoffs, team size vs project scope).   │
│     It loops until the company design passes all checks.    │
│                                                             │
│     → You review and approve the design before step 2.      │
│     → Output: COMPANY.md                                    │
├─────────────────────────────────────────────────────────────┤
│  2. AGENT CREATION                                          │
│     For each agent in COMPANY.md:                           │
│     → Spawns an independent subagent (isolated context)     │
│     → Generates PERSONA.md (voice, frameworks, guardrails,  │
│       source-of-truth file links, boundaries)               │
│     → Tests the persona using the skill-creator eval        │
│       pattern: calibration questions, graded assertions,    │
│       iterative refinement                                  │
│     → Caps at 5 iterations — if it can't pass, surfaces     │
│       the issue to you rather than grinding                 │
│     → All agents created in parallel, each in independent   │
│       context so they don't bleed into each other           │
│                                                             │
│     → Output: one PERSONA.md per agent                      │
├─────────────────────────────────────────────────────────────┤
│  3. COMPANY ACTIVATION                                      │
│     → Cross-checks the full team: no boundary overlaps,     │
│       no contradictions, handoffs are clean                 │
│     → Runs a dry-run exercise to verify agents stay in      │
│       their lanes                                           │
│     → Organises the agent-company/ folder structure         │
│     → Company is ready to work                              │
│                                                             │
│     → Output: complete agent-company/ folder                │
└─────────────────────────────────────────────────────────────┘
```

---

## Folder Structure

Every project using this framework gets this layout:

```
agent-company/
├── COMPANY.md                    # Blueprint: roles, ownership map, boundaries
├── {domain}/                     # e.g. marketing/, design/, editorial/
│   ├── PERSONA.md                # Everything: voice, frameworks, source-of-truth
│   │                             #   links, boundaries, standing instructions
│   ├── knowledge/                # On-demand research, cached across sessions
│   │   ├── {topic-1}.md          # One file per topic, sourced claims
│   │   ├── {topic-2}.md          # Deduplicated and restructured automatically
│   │   └── ...
│   └── mailbox/                  # Incoming briefs from other agents
│       ├── {brief-name}.md
│       └── ...
└── ...
```

One folder per agent. Three concerns: who they are, what they've learned, what they've been asked to do.

---

## Core Concepts

### Agents

Each agent is a domain expert with a single file that defines everything about them:

**PERSONA.md** contains:

- **Identity and voice** — Who they are. Their perspective, analytical frameworks, decision-making style, and explicit failure modes to avoid.
- **Source of Truth** — Links directly to actual project files, config, and code that define the constraints. A design agent's source of truth points to the real design tokens file, the actual Tailwind config, the live component library — not copies. This keeps specs always in sync with the project.
- **Boundaries** — What they own, what they don't, and who they hand off to.
- **Standing instructions** — Check `knowledge/` before web searching. Check `mailbox/` when starting a session.

Source of Truth format (inside PERSONA.md):

```markdown
## Source of Truth

| What | File | Notes |
|------|------|-------|
| Design tokens | `src/styles/tokens.css` | Colours, spacing, typography |
| Tailwind config | `tailwind.config.ts` | Extended theme values |
| Component library | `src/components/ui/` | Existing primitives — use before creating |
| Brand guidelines | `docs/brand/` | Logo usage, voice, colour rules |

### Hard Constraints

- Never invent colours outside the token file
- All spacing uses the project's scale — read it from the source
```

### Boundaries

Every agent has a clear scope defined during Company Design:

- **Owns**: What this agent is responsible for. No other agent touches this.
- **Does not own**: Explicit exclusions to prevent overlap.
- **Hands off to**: When a task crosses into another agent's territory, who gets it.

This prevents the single biggest problem in multi-agent teams: two agents giving contradictory guidance on the same topic.

### Mailbox System

Agents communicate through structured briefs in each other's `mailbox/` folder. This is the cross-session communication layer — when you finish working with one agent and need to hand work to another, the sending agent writes a brief to the receiving agent's mailbox.

Within a single Claude Code session, agents use native `SendMessage` for real-time communication. The mailbox is for handoffs between separate sessions.

Brief format:

```markdown
# Brief: {title}

**From**: {sending-agent}
**To**: {receiving-agent}
**Date**: {date}
**Priority**: {high | medium | low}

## Context
Why this brief exists and what triggered it.

## Request
What the receiving agent needs to do.

## Constraints
Any hard requirements or boundaries.

## Deliverable
What the sending agent expects back.
```

### Knowledge System

Each agent's `knowledge/` folder is empty at creation. Agents research on-demand during their work sessions and cache findings here so they never research the same concept twice.

**Rules:**

1. **Check before searching** — Before researching any topic, the agent checks `knowledge/` for existing material. Baked into every PERSONA.md as a standing instruction.
2. **Modular** — One file per topic. No mega-documents. Smaller, focused documents organised logically.
3. **Sourced** — Every factual claim has a URL. No unsourced assertions.
4. **Current** — Documents include the date they were last verified.
5. **Deduplicated** — When new research comes in, the agent automatically consolidates the knowledge folder: merges overlapping content, removes duplications, updates outdated claims, and restructures files to maintain the best possible organisation by topic. The folder is always clean and current.
6. **Coherent** — No contradictions within an agent's knowledge base or between agents.

Knowledge document format:

```markdown
# {Topic Title}

> Last verified: {date}
> Sources: {count}

## {Section}

{Content with inline citations.}

**Source**: {URL}

## {Section}

...
```

---

## Quality Gates

### Company Design Quality (during Company Design)

The skill runs a dedicated checklist against the proposed company before presenting it for review:

- No coverage gaps — every aspect of the project has an owner
- No redundant roles — each agent has a distinct, necessary purpose
- No boundary overlaps — no two agents own the same thing
- Handoff completeness — every boundary has a clear handoff defined
- Team size vs project scope — not too many, not too few agents
- The skill loops through this checklist, refining the design until all checks pass
- Only then is the design presented for your review

### Agent Quality (during Agent Creation)

Each agent persona is tested using the skill-creator evaluation pattern:

1. Draft the PERSONA.md
2. Run calibration questions: domain-specific scenarios, boundary edge cases, handoff situations
3. Grade responses against assertions (domain accuracy, voice consistency, boundary respect)
4. Iterate and refine until pass rate meets the threshold
5. Cap at 5 iterations — if it can't pass, surface the issue for human review rather than grinding indefinitely

### Team Coherence (during Company Activation)

- Cross-check: no boundary overlaps or contradictions across agents
- Dry-run exercise: give the team a realistic task and verify agents stay in their lanes
- Handoff clarity: verify edge cases at agent boundaries are handled

---

## Skills

| Skill | Purpose |
|-------|---------|
| `agent-company-creator` | The main skill. Designs the company, creates and tests all agents, delivers the finished `agent-company/` folder. |
| `send-brief` | Cross-session communication. Formalises conversation context into a structured brief and delivers it to an agent's mailbox. Reads COMPANY.md dynamically for agent list. If an editorial agent exists, it edits the brief before delivery. |

---

## Design Principles

1. **Separation of concerns** — Each agent owns one domain. No overlap.
2. **Explicit boundaries** — What an agent does NOT do is as important as what it does.
3. **Verifiable knowledge** — No claims without sources. No "I think" — only "according to {source}."
4. **Structured communication** — Agents talk through briefs with clear requests and deliverables. Within sessions via SendMessage, across sessions via mailbox.
5. **Iterative quality** — Every persona is tested and refined, not shipped on first draft. Every company design is stress-tested before creation begins.
6. **Reusable across projects** — The framework works for any domain. The agents change; the structure doesn't.
7. **No infinite loops** — Every iterative process has a cap. When the cap is hit, the system surfaces the issue to you rather than grinding.
8. **Self-maintaining knowledge** — Research is cached, deduplicated, and restructured automatically. The knowledge folder is always clean and current.
9. **Minimal footprint** — One file per agent. No separate SPECS.md, no eval artifacts, no pre-loaded knowledge bases. The folder structure stays lean.
