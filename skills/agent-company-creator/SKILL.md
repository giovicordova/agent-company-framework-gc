---
name: agent-company-creator
description: Design and build a complete team of specialised AI agents for any project as native Claude Code subagents with persistent memory. Use when the user wants to create an agent team, assemble a company of agents, set up domain specialists, build an agent company, or says things like "I need agents for my project", "create a team for this", "set up my agent company", "build agents for [project]", "I want specialists working on this", or "agent-company-creator". Also triggers when the user describes a project and implies they need multiple AI personas collaborating, or when they want to restructure or recreate an existing agent company from scratch. Covers the full pipeline from brainstorming roles to delivering tested, ready-to-use subagents in `.claude/agents/` with a `COMPANY.md` blueprint at the project root. Does NOT trigger for single-agent creation, sending briefs between agents, or working with existing personas.
---

# Agent Company Creator

Build a complete company of specialised AI agents for a project, as native Claude Code subagents. One invocation takes you from "here's my project" to a fully tested `.claude/agents/` directory plus a `COMPANY.md` blueprint at the project root.

## Overview

Three phases with one human checkpoint:

```
[1. Company Design] → [User Review] → [2. Agent Creation + Testing] → [3. Company Activation]
```

Phase 1 is interactive. Phases 2 and 3 are autonomous.

**Output locations:**
- `.claude/agents/{name}.md` — the subagent file with YAML frontmatter (Claude Code reads this for auto-delegation and persona).
- `.claude/agent-memory/{name}/` — auto-created by Claude Code when the subagent's `memory: project` frontmatter is active. The agent writes and curates these files itself; you don't manage them by hand.
- `COMPANY.md` — at the project root. Ownership map and conflict-resolution rules. Imported by the project `CLAUDE.md` so every session sees it.

**What this skill does not create** (by design):
- No `agent-company/` folder. Persistent memory is native in Claude Code.
- No `mailbox/` — handoffs happen via native subagent dispatch (the main session calls the `Agent` tool, or Claude Code auto-routes via `description` frontmatter).
- No per-agent `knowledge/`, `mistakes.md`, or `shared.md` files. Native subagent memory covers knowledge and self-correction. Durable cross-agent facts go into project `CLAUDE.md`.

---

## Phase 1 — Company Design

The goal is to design the right set of agents for this project. Not too many, not too few. Each one with a clear domain, clear boundaries, and no overlaps.

### Step 1.1 — Understand the project

Start a conversation to understand what the user is building. They might give you:
- A verbal description
- A written brief or document
- A vague idea that needs shaping

Ask questions to fill gaps. You need to understand:
- What the project is and who it serves
- What domains of expertise it requires (design, marketing, engineering, editorial, etc.)
- What the current state is (greenfield? existing codebase? existing brand?)
- What files, configs, or code already exist that agents will need to reference

If the user suggests specific agents, take them seriously but challenge them. Ask: "Why this agent and not that one? What would happen if we merged these two? Is there a gap no one covers?" The user's instincts about their project are valuable, but the skill's job is to stress-test those instincts and justify or reshape them.

### Step 1.2 — Propose the company

For each agent, define:

```markdown
### {Agent Name}

**Domain**: {What they specialise in}

**Owns**:
- {Responsibility 1}
- {Responsibility 2}

**Does not own**:
- {Explicit exclusion 1}
- {Explicit exclusion 2}

**Hands off to**:
- {Situation} → {Agent}
```

Also produce an **ownership map** — a table showing every major project concern and which agent owns it:

```markdown
| Concern | Owner | Notes |
|---------|-------|-------|
| Visual identity | Design | Includes colour, typography, layout |
| Copy and tone | Editorial | All customer-facing text |
| ... | ... | ... |
```

And a **conflict resolution table** for boundary edges:

```markdown
| Boundary | Agent A | Agent B | Resolution |
|----------|---------|---------|------------|
| Landing page copy | Editorial | Marketing | Editorial owns the words, Marketing owns the strategy |
| ... | ... | ... | ... |
```

### Step 1.3 — Quality gate

Before showing the proposal to the user, run it through this checklist. Loop until every item passes:

1. **Coverage** — Every aspect of the project has an owner. No orphaned concerns.
2. **No redundancy** — Each agent has a distinct purpose. If two could be merged without losing capability, merge them.
3. **No boundary overlaps** — No two agents own the same thing. The ownership map has no duplicate entries.
4. **Handoff completeness** — Every boundary between agents has a defined handoff.
5. **Right-sizing** — The number of agents matches project scope. A simple project doesn't need 7 agents. A complex one shouldn't have 3.
6. **Source-of-truth awareness** — For each agent, you can identify at least one project file or resource they'll need to reference. For greenfield projects, define files that *will* be created and mark them as "(to be created)".

Cap this loop at 3 iterations. If it still doesn't pass, present what you have with a note about what's unresolved.

### Step 1.4 — Present for user approval

Show the complete company design:
- Agent list with domains, boundaries, handoffs
- Ownership map
- Conflict resolution table
- Any trade-offs or open questions

Ask: "Does this look right? Want to add, remove, or change anything?"

Do not proceed to Phase 2 until the user explicitly approves.

---

## Phase 2 — Agent Creation and Testing

### Step 2.1 — Spawn creation subagents

Use the **Agent tool** (general-purpose subagents) to create each agent file in parallel. Launch all creation subagents in a single message. Each gets this brief:

```
You are creating a native Claude Code subagent file for the {Agent Name} agent.

Project context: {Brief project description from Phase 1}

This agent's role:
- Domain: {domain}
- Owns: {ownership list}
- Does not own: {exclusion list}
- Hands off to: {handoff rules}
- Other agents in the company: {list with domains}

Write the file at `.claude/agents/{lowercase_name}.md` with this exact structure:

---
YAML FRONTMATTER — REQUIRED:

  ---
  name: {lowercase name, matches filename stem}
  description: {2-4 sentences. This is the routing rule Claude Code uses for auto-delegation. Describe when to invoke this agent AND when NOT to. Specific. Bad: "Handles content." Good: "Use for copy review, tone calibration, brand messaging. Invoke when the user asks whether something reads well or wants prose tightened. Not for business strategy or hiring."}
  tools: {comma-separated, scoped to what the agent actually needs. All agents need Read, Write, Edit (for curating their own memory). Add WebSearch/WebFetch only if research is in the role. Add Bash only if file-system operations are genuinely needed. Do NOT grant tools the agent won't use.}
  model: sonnet
  memory: project
  ---

The `memory: project` line is critical — it activates Claude Code's native persistent memory at `.claude/agent-memory/{lowercase_name}/`. Do not omit it.

BODY — 6 SECTIONS:

1. **Identity** — 2-3 sentences. Who this agent is, their perspective, how they think. Second person ("You are..."). Distinct personality, not a generic role description.

2. **Voice** — How they communicate. Sentence length, formality, technical level, rhetorical style. Include 2-3 example sentences with realistic, specific content (not placeholder text).

3. **Analytical Frameworks** — Domain-specific mental models. Must be frameworks a generalist would not know or use. Bad: "SWOT analysis". Good: "evaluate designs against the 60-30-10 colour rule, the squint test, and the 5-second clarity test." At least 2 named frameworks with concrete steps or criteria.

4. **Boundaries** — Three subsections:
   - **Owns**: Bulleted list of responsibilities
   - **Does not own**: Bulleted list with the agent who does own each
   - **Hands off to**: Bulleted list of handoff scenarios with the receiving agent named

5. **Failure Modes** — 3-5 specific things this agent must NOT do. Role-specific, not generic. Bad: "don't be vague." Good: "don't propose colour palettes that aren't derived from the token file." Always include one failure mode about relying on training data instead of researching current sources.

6. **Standing Instructions** — Bulleted list. Always include these four, plus 1-2 role-specific ones:
   - Consult your persistent memory at session start (`MEMORY.md` is auto-loaded). After significant tasks, save learnings — recurring patterns, domain reference points, frameworks that worked. Curate the file; trim outdated notes.
   - Before giving a domain opinion or making a factual claim, verify it against current sources (web search, project files). Cite the URL or file path. Never rely solely on training data when a live source exists.
   - When your work produces a durable cross-agent fact (a decision others need to know), flag it for inclusion in project `CLAUDE.md`.
   - Conflict resolution follows `COMPANY.md` at the project root.

Do NOT include a "Source of Truth" section — the Standing Instructions and native memory replace it.
Do NOT create any directories under `agent-company/` — that pattern is obsolete.
```

### Step 2.2 — Test each subagent with real dispatch

Testing must be real, not narrated. You now have native subagents — dispatch them via the Agent tool with `subagent_type: {lowercase_name}` and grade their responses.

For each agent, generate 6 calibration questions:

1. **Domain competence** — A question only a genuine domain expert would answer well.
2. **Boundary respect** — A question that tempts the agent to overstep into another agent's territory.
3. **Handoff recognition** — A scenario where the agent should recognise it needs to hand off to a colleague.
4. **Source-of-truth adherence** — A question where the answer should come from a project file or live source, not general knowledge.
5. **Voice consistency** — A request that tests whether the agent maintains its defined voice under pressure (vague or confrontational prompt).
6. **Research-first** — A question where the agent would be tempted to answer from training data (market trends, salary ranges, legal requirements). A strong answer flags the need to verify and cites sources.

For each question, define what a **strong answer** looks like and what a **failing answer** looks like.

**Run the tests using the Agent tool:**

For each agent, dispatch once with all 6 questions in a single prompt:

```
Agent tool call:
  subagent_type: {lowercase_name}
  prompt: |
    Answer these 6 calibration questions, one at a time. Stay in character — use your defined voice, respect your boundaries, cite sources rather than inventing answers.

    1. {calibration question 1}
    2. {calibration question 2}
    ...
    6. {calibration question 6}

    Return your 6 answers in one response with clear numbering.
```

Keep calibration transcripts as ephemeral session artefacts. If you need a durable record, write them under `.claude/agent-calibration/{lowercase_name}.md` — do NOT create `agent-company/` for this. The `agent-company/` pattern is obsolete in v2.1; reviving it here would contradict the skill's own output contract.

**Grade the responses:**

After each dispatch completes, grade each answer. A response passes if it:
- Demonstrates genuine domain thinking (not generic advice)
- Respects boundaries (doesn't do another agent's work)
- Recognises handoff situations
- Cites sources on factual claims rather than inventing
- Maintains the defined voice
- Flags the need to verify on research-first questions

### Step 2.3 — Iterate on failures

If any calibration question fails:
1. Identify the root cause — persona too vague? Missing framework? Boundary not clear? Description too loose for auto-routing?
2. Revise the specific section of `.claude/agents/{name}.md` (body or frontmatter).
3. Re-dispatch the subagent with the revised persona.
4. Only re-test the failed questions.

Cap at 5 iterations per agent. If an agent can't pass after 5 rounds, save what you have and flag to the user: "The {Agent} persona needs your input — here's what's not working: {specific issue}."

Calibration records (if written to disk) belong in `.claude/agent-calibration/` — never in `agent-company/`.

---

## Phase 3 — Company Activation

### Step 3.1 — Cross-check

Read all `.claude/agents/*.md` files and the project root `COMPANY.md` (if one already exists) and verify:

- **Frontmatter consistency**: Each agent's frontmatter `name` matches its filename stem. Each `description` starts with a clear routing trigger. `tools` is scoped and not empty. `model: sonnet`. `memory: project` present.
- **Ownership consistency**: Every item in each subagent's "Owns" list has a row in the ownership map. Every row in the ownership map traces to a `.claude/agents/{name}.md`. Line by line, not by scanning.
- **Handoff symmetry**: If Design says "hand off copy to Editor", Editor's subagent acknowledges receiving copy work.
- **No constraint contradictions**: No agent's hard constraints conflict with another's.
- **Source-of-truth validity**: For existing projects, verify referenced files exist (use Glob). For greenfield, verify references are plausible and marked "(to be created)".

Fix any inconsistency before proceeding.

### Step 3.2 — Write COMPANY.md at project root

Create or overwrite `COMPANY.md` at the project root with:

```markdown
# {Project Name} — Agent Company

> Created: {date}
> Agents: {count}

## Agents

{For each agent:}
### {Agent Name}
- **Subagent file**: `.claude/agents/{lowercase_name}.md`
- **Domain**: {domain}
- **Owns**: {list}
- **Does not own**: {list}
- **Hands off to**: {rules}

## Ownership Map
{table from Phase 1}

## Conflict Resolution
{table from Phase 1}

## How to work with this company

1. Ask questions that match an agent's `description` — Claude Code auto-routes. Or run `/agents` to see the roster.
2. For multi-agent decisions, use `/board-meeting` — sequential subagent round-table.
3. Durable cross-agent facts (voice rulings, strategic pivots, new roles) go into project `CLAUDE.md` so every subagent sees them.
4. Agents manage their own persistent memory under `.claude/agent-memory/{name}/` — no manual maintenance required.
```

### Step 3.3 — Wire CLAUDE.md

Check if the project has a root `CLAUDE.md`. If yes, append `@COMPANY.md` at the bottom so the ownership map loads with every session. If no, create a minimal CLAUDE.md with a link to the README and the `@COMPANY.md` import.

### Step 3.4 — Dry run

Pick a realistic task that crosses at least one agent boundary. Walk it through the team mentally:
- Which agent would handle it first?
- At what point does the handoff trigger?
- Does the receiving agent have everything they need?
- Does every step have a clear owner?

Report results. If the dry run reveals gaps (orphaned steps, ambiguous handoffs), fix them before declaring done.

### Step 3.5 — Deliver

Confirm the final structure:

```
.claude/
└── agents/
    ├── {agent-1}.md     # frontmatter: memory: project
    ├── {agent-2}.md
    └── ...

COMPANY.md               # Ownership map + conflict rules (imported by CLAUDE.md)
CLAUDE.md                # Project instructions; imports COMPANY.md at the bottom
```

Tell the user: "Your agent company is ready. Here's who's on the team: {summary}. Ask them questions directly — Claude auto-routes via their descriptions — or use `/board-meeting` for multi-agent decisions. Their persistent memory will populate as they work."
