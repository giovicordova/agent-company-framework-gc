---
name: agent-company-creator
description: Design and build a complete team of specialised AI agents for any project. Use when the user wants to create an agent team, assemble a company of agents, set up domain specialists, build an agent company, or says things like "I need agents for my project", "create a team for this", "set up my agent company", "build agents for [project]", "I want specialists working on this", or "agent-company-creator". Also triggers when the user describes a project and implies they need multiple AI personas collaborating, or when they want to restructure or recreate an existing agent company from scratch. Covers the full pipeline from brainstorming roles to delivering tested, ready-to-use agent personas with COMPANY.md blueprint and PERSONA.md per agent. Does NOT trigger for single-agent creation, sending briefs between agents, or working with existing personas.
---

# Agent Company Creator

Build a complete company of specialised AI agents for a project. One invocation takes you from "here's my project" to a fully tested `agent-company/` folder with COMPANY.md and one PERSONA.md per agent.

## Overview

The pipeline has three phases with one human checkpoint:

```
[1. Company Design] → [User Review] → [2. Agent Creation + Testing] → [3. Company Activation]
```

Phase 1 is interactive. Phases 2 and 3 are autonomous.

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

Based on what you've learned, propose a company. For each agent, define:

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
- {Situation} → {Agent}
```

Also produce an **ownership map** — a table showing every major project concern and which agent owns it:

```markdown
| Concern | Owner | Notes |
|---------|-------|-------|
| Visual identity | Design | Includes colour, typography, layout |
| Copy and tone | Editorial | All customer-facing text |
| SEO and discoverability | Visibility | Technical and content SEO |
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
2. **No redundancy** — Each agent has a distinct purpose. If two agents could be merged without losing capability, merge them.
3. **No boundary overlaps** — No two agents own the same thing. The ownership map has no duplicate entries.
4. **Handoff completeness** — Every boundary between agents has a defined handoff. No ambiguous edges.
5. **Right-sizing** — The number of agents matches the project scope. A simple project doesn't need 7 agents. A complex one shouldn't have 3.
6. **Source-of-truth awareness** — For each agent, you can identify at least one project file or resource they'll need to reference. For greenfield projects where files don't exist yet, define the files that *will* be created and note them as "to be created." If an agent has no plausible source of truth even in the planned project, question whether the domain is real or speculative.

If any check fails, revise the design and re-run. Cap this loop at 3 iterations. If it still doesn't pass, present what you have with a note about what's unresolved.

### Step 1.4 — Present for user approval

Show the complete company design to the user:
- The agent list with domains, boundaries, and handoffs
- The ownership map
- The conflict resolution table
- Any notes about trade-offs or open questions

Ask: "Does this look right? Want to add, remove, or change anything?"

Do not proceed to Phase 2 until the user explicitly approves.

---

## Phase 2 — Agent Creation and Testing

For each agent in the approved design, create a PERSONA.md and test it until it's good. Each agent is created in an independent subagent so they don't bleed into each other.

### Step 2.1 — Spawn creation subagents

Use the **Agent tool** to spawn one independent subagent per agent. Launch all subagents in parallel in a single message (multiple Agent tool calls). Each subagent gets this brief:

```
You are creating a PERSONA.md for the {Agent Name} agent.

Project context: {Brief project description from Phase 1}

This agent's role:
- Domain: {domain}
- Owns: {ownership list}
- Does not own: {exclusion list}
- Hands off to: {handoff rules}
- Other agents in the company: {list of all other agents and their domains}

The PERSONA.md must contain these sections, each with substantive content (not stubs or single sentences):

1. **Identity** — 2-3 sentences describing who this agent is. Their perspective, what drives them, how they think about problems. Written in second person ("You are..."). Must convey a distinct personality, not a generic role description.

2. **Voice** — How they communicate. Sentence length, formality, technical level, rhetorical style. MUST include 2-3 example sentences showing the voice in action with realistic, specific content (not placeholder text).

3. **Analytical Frameworks** — The mental models and decision-making frameworks this agent uses. Must be domain-specific — meaning frameworks that a generalist would not know or use. Bad: "SWOT analysis" (any MBA knows this). Good: "evaluate designs against the 60-30-10 colour rule, the squint test, and the 5-second clarity test." Include at least 2 named frameworks with concrete steps or criteria that a specialist in this exact domain would recognise.

4. **Source of Truth** — A table of project files and resources this agent must reference:
   | What | File | Notes |
   |------|------|-------|
   For greenfield projects, define files that will be created and mark them as "(to be created)".
   Plus hard constraints derived from those sources.

5. **Boundaries** — Three subsections:
   - **Owns**: Bulleted list of responsibilities
   - **Does not own**: Bulleted list of explicit exclusions, each noting which agent owns it instead
   - **Hands off to**: Bulleted list of handoff scenarios with the receiving agent named

6. **Failure Modes** — 3-5 specific things this agent must NOT do. Must be role-specific, not generic. Bad: "don't be vague." Good: "don't propose colour palettes that aren't derived from the token file." Each failure mode should describe a realistic mistake this particular agent would be tempted to make. Always include one failure mode about relying on training data instead of researching current sources — e.g., "Don't state market trends, legal requirements, or industry standards from memory — look them up and cite the source."

7. **Standing Instructions** — Always include these four, plus 1-2 role-specific standing instructions:
   - Before giving a domain opinion or making a factual claim, verify it against current sources (web search, project files, documentation). Cite the URL or file path. Never rely solely on training data when a live source exists.
   - Before researching any topic, check your `knowledge/` folder for existing material.
   - When starting a session, check your `mailbox/` folder for incoming briefs.
   - When your work affects another agent's domain, flag it for handoff.

Write the PERSONA.md to: agent-company/{domain}/PERSONA.md
Also create empty directories: agent-company/{domain}/knowledge/ and agent-company/{domain}/mailbox/
```

### Step 2.2 — Test each persona with actual subagents

This is critical: testing must be real, not narrated. Do not write test results as a story. Actually run the tests.

After all PERSONA.md files are created, test each one. For each agent:

**Generate 5 calibration questions:**

1. **Domain competence** — A question only a genuine domain expert would answer well.
2. **Boundary respect** — A question that tempts the agent to overstep into another agent's territory.
3. **Handoff recognition** — A scenario where the agent should recognise it needs to hand off to a colleague.
4. **Source-of-truth adherence** — A question where the answer should come from a specific project file, not general knowledge.
5. **Voice consistency** — A request that tests whether the agent maintains its defined voice under pressure (e.g., a vague or confrontational prompt).
6. **Research-first** — A question where the agent would be tempted to answer from training data (e.g., a factual claim about market trends, legal requirements, or industry standards). A strong answer flags the need to verify and cites sources; a failing answer confidently states "facts" from memory.

For each question, define what a **strong answer** looks like and what a **failing answer** looks like.

**Run the tests using subagents:**

For each agent, spawn a test subagent using the Agent tool:

```
You are the {Agent Name} agent. Read your persona file at agent-company/{domain}/PERSONA.md and adopt it completely.

Then answer the following questions, one at a time. Stay fully in character. Use your defined voice, respect your boundaries, and reference your source-of-truth files.

Questions:
1. {calibration question 1}
2. {calibration question 2}
3. {calibration question 3}
4. {calibration question 4}
5. {calibration question 5}

Save your responses to agent-company/{domain}/calibration-responses.md
```

**Grade the responses:**

After each test subagent completes, read the calibration-responses.md and grade each answer against the assertion. A response passes if it:
- Demonstrates genuine domain thinking (not generic advice)
- Respects boundaries (doesn't do another agent's work)
- Recognises handoff situations
- References source-of-truth files rather than inventing answers
- Maintains the defined voice

### Step 2.3 — Iterate on failures

If any calibration question fails:
1. Identify the root cause — was the persona too vague? Too generic? Missing a framework? Boundary not clear enough?
2. Revise the specific section of PERSONA.md that caused the failure
3. Re-test by spawning a new test subagent with the revised persona
4. Only re-test the failed questions, not all 5

Cap at 5 iterations per agent. If an agent can't pass after 5 rounds, save what you have and flag it to the user: "The {Agent} persona needs your input — here's what's not working: {specific issue}."

Keep the calibration-responses.md files in each agent's folder — they serve as evidence that testing actually happened and can be reviewed later.

---

## Phase 3 — Company Activation

All agents are created and individually tested. Now verify they work as a team.

### Step 3.1 — Cross-check

Read all PERSONA.md files and COMPANY.md and verify:
- **Ownership consistency**: Go through every single item in each PERSONA.md's "Owns" list and confirm it has a corresponding row in the COMPANY.md ownership map table. Then go the other direction — every row in the ownership map must trace back to a PERSONA.md. If any item is missing from either side, add it. This is the most common failure point — do it line by line, not by scanning.
- **Handoff symmetry**: If Design says "hand off copy to Editorial", Editorial's persona acknowledges receiving copy work. Every handoff has a sender and a receiver.
- **No constraint contradictions**: No agent's hard constraints conflict with another agent's.
- **Source-of-truth validity**: For existing projects, verify referenced files actually exist (use Glob). For greenfield projects, verify references are plausible and marked as "(to be created)".

If any check fails, fix the inconsistency in the relevant file(s) before proceeding. Do not skip this step or self-report "no discrepancies" without actually checking line by line.

### Step 3.2 — Write COMPANY.md

Create `agent-company/COMPANY.md` with:

```markdown
# {Project Name} — Agent Company

> Created: {date}
> Agents: {count}

## Agents

{For each agent:}
### {Agent Name}
- **Domain**: {domain}
- **Folder**: `agent-company/{domain}/`
- **Owns**: {list}
- **Does not own**: {list}
- **Hands off to**: {rules}

## Ownership Map

{The ownership map table from Phase 1}

## Conflict Resolution

{The conflict resolution table from Phase 1}

## How to Work With This Company

1. Open a new Claude Code session
2. Read the PERSONA.md for the agent you want to work with
3. The agent will check its mailbox for incoming briefs and its knowledge folder for cached research
4. When done, use `/send-brief` to hand work to another agent
```

### Step 3.3 — Dry run

Pick a realistic task that crosses at least one agent boundary — something that starts in one agent's domain and requires handoff to at least one other. Walk it through the team:
- Which agent would handle it first?
- At what point does the handoff trigger?
- Does the receiving agent have everything they need?
- Does every step have a clear owner?

Report the results. If the dry run reveals gaps (orphaned steps, ambiguous handoffs, missing owners), fix them by updating COMPANY.md and the relevant PERSONA.md files.

### Step 3.4 — Deliver

Confirm the final folder structure:

```
agent-company/
├── COMPANY.md
├── {domain-1}/
│   ├── PERSONA.md
│   ├── calibration-responses.md    # Test evidence
│   ├── knowledge/
│   └── mailbox/
├── {domain-2}/
│   ├── PERSONA.md
│   ├── calibration-responses.md
│   ├── knowledge/
│   └── mailbox/
└── ...
```

Tell the user: "Your agent company is ready. Here's who's on the team: {summary}. Use `/send-brief` to communicate between agents across sessions."
