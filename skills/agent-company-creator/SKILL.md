---
name: agent-company-creator
description: Design the optimal team of AI agents for any project and produce a COMPANY.md blueprint. Use when the user wants to create an agent team, assemble a company of agents, set up domain specialists, build an agent company, or says things like "I need agents for my project", "create a team for this", "set up my agent company", "design agents for [project]", "I want specialists working on this", or "agent-company-creator". Also triggers when the user describes a project and implies they need multiple AI personas collaborating, or when they want to redesign an existing agent company. Produces a COMPANY.md with agent descriptions ready to paste directly into Claude Code's built-in `/agent` command. Does NOT create agent files — the user creates each agent via `/agent` using the descriptions from COMPANY.md.
---

# Agent Company Creator

Design the right team of AI agents for a project. Output: a single `COMPANY.md` at the project root — a blueprint the user walks through with `/agent` to create each agent.

## Why design matters more than scaffolding

Claude Code's `/agent` command handles agent creation well. What it can't do is think about the whole team at once — which roles actually need to exist, where the boundaries fall, what happens when two agents' territory overlaps. That's what this skill does. The hard part of an agent company is the design, not the files.

## Pipeline

### 1. Understand the project

Before proposing any team, get clear answers on:

- What does the project produce? (outputs, audience, stakes)
- What exists already? (codebase, brand, content, infrastructure)
- Hard constraints? (deadlines, budgets, regulations, non-negotiables)
- Where does the user feel stuck or stretched thin?
- One concrete recent task or decision they'd want the team to handle.

One focused round of questions. Don't propose anything until these are answered.

### 2. Propose the team with a sizing argument

Draft a roster. For each role: a name, a one-line identity, and a one-line boundary (what it explicitly does NOT own).

Then defend the number. Why this many and not more or fewer? Where is the overlap risk? Where is the orphan risk — a real project concern that no agent covers?

Share the proposal. Steel-man the user's instinct if they push back, but also push back yourself if their suggestion would create overlap or gaps. Revise once if needed. Don't write COMPANY.md until the team shape is agreed.

### 3. Write COMPANY.md

Write `COMPANY.md` at the project root with these sections:

#### Mission
One to two sentences. What is this team for?

#### Roster
For each agent, write an entry like this:

```
### `agent-name`

**Identity:** One sentence — who this agent is and what domain it operates in.

**Owns:** Bullet list of specific concerns this agent is responsible for.

**Does not own:** Bullet list of things that are adjacent but belong to another agent or to the user.

**Hands off to:** Which agent(s) and under what conditions.

**Description for `/agent`:**
> [A complete, self-contained description paragraph that can be pasted directly into `/agent` when creating this agent. This should include: the agent's role, what it's an expert in, what tools it should have access to, what it owns, what it defers, and its working style. Written in second person ("You are..."). Should work as a standalone agent prompt without needing the rest of COMPANY.md for context.]
```

The "Description for `/agent`" block is the most important part. It needs to be good enough that someone can copy it verbatim into `/agent` and get a well-scoped, well-behaved agent. That means:
- Self-contained — doesn't reference COMPANY.md sections the agent won't see
- Specific to the project domain — not generic "business analyst" language
- Includes tool scoping guidance (e.g., "You read and advise but do not edit files directly")
- States boundaries clearly so the agent knows when to hand off
- Uses the project's actual terminology, not abstract placeholders

#### Sizing rationale
One to three paragraphs defending why this number of agents, why this particular split, and what the alternative configurations would lose. Name the failure modes of having fewer or more.

Flag any orphan concerns — real project responsibilities that sit between agents and aren't cleanly owned by any of them. Say who should own them if the team grows.

#### Ownership map
A table with columns: `Concern | Owner | Notes`. Every concern from Step 1 must appear. No concern should be owned by two agents — if it is, that's a design bug to fix before shipping.

#### Handoff rules
When agent X should hand to agent Y. Use the format:
- **`agent-a` → `agent-b`** when [specific condition]. Agent A says "[what it communicates]"; Agent B says "[what it responds with]".

#### Conflict resolution
A table with columns: `Boundary | Agent A | Agent B | Resolution`. One row per real boundary edge between agents. Default tie-breaker: the agent whose ownership column covers the decision wins.

This section only matters for teams of 2+ agents with adjacent territory. For very small teams with clean splits, this can be brief.

### 4. Summary

Tell the user:
- What was written and where
- How many agents, with names
- How to create each agent: run `/agent`, give it the name, paste the "Description for `/agent`" block
- Any orphan concerns they should be aware of

## Hard constraints

- **One output file: `COMPANY.md` at project root.** No agent files, no calibration files, no activation summaries.
- **No generic personas.** "Content writer" that would fit any company is a failure. Every agent must reference the project's actual domain, tools, terminology, and workflows.
- **No overlapping ownership.** If two agents could plausibly claim the same concern, the ownership map has a bug. Fix it.
- **The `/agent` description must stand alone.** It will be pasted into a prompt field with no surrounding context. It cannot depend on COMPANY.md being loaded.
- **Defend the team size.** "We have four agents" without argument is not a design — it's a guess.

## Failure modes to guard against

- **Too many agents.** More agents means more handoff friction, more routing ambiguity, more maintenance. The default instinct is to add roles; push against it. Every agent must catch a failure mode that the others can't.
- **Too few agents.** Cramming distinct modes of attention into one agent produces a generalist that does nothing well. If two concerns have different sources of truth or different working styles, they probably need different agents.
- **Vague boundaries.** "Handles marketing" is not a boundary. "Owns social copy and scheduling; does not own brand strategy or paid ads" is a boundary.
- **Descriptions that reference COMPANY.md.** The `/agent` description field is the agent's entire world. If it says "see ownership map" or "per COMPANY.md", that reference will be invisible to the agent.
- **Skipped sizing rationale.** The sizing argument is what turns a list of roles into a team design. Without it, there's no way to evaluate whether the team is right-sized.
