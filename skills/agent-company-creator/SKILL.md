---
name: agent-company-creator
description: Designs the right team of AI agents for a project and writes a COMPANY.md blueprint with paste-ready descriptions for Claude Code's /agents command. Use when the user wants to create, assemble or redesign an agent team ("I need agents for my project", "set up my agent company"). Designs only; does not create agent files.
---

# Agent Company Creator

The hard part of an agent company is the design (which roles exist, where boundaries fall, what happens at overlaps), not the files; `/agents` creates those. Output: one `COMPANY.md` at the project root, nothing else.

1. **Understand the project** in one focused round of questions: what it produces and for whom, what exists already, hard constraints, where the user is stretched thin, and one recent task the team should have handled. Propose nothing until these are answered.
2. **Propose the roster.** Per role: a name, a one-line identity, a one-line boundary (what it does not own). Defend the number: overlap risk, orphan risk (a real concern nobody owns), and what fewer or more agents would lose. Every agent must catch a failure the others can't. Push back on suggestions that create overlap or gaps; revise once. Write nothing until the shape is agreed.
3. **Write `COMPANY.md`:**
   - **Mission**: 1-2 sentences.
   - **Roster**: per agent, identity, owns, does not own, hands off to, and a **Description for `/agents`**: a self-contained second-person paragraph (role, expertise, tool scope, ownership, what it defers, working style) in the project's own terminology. It must not reference COMPANY.md, which the agent never sees.
   - **Sizing rationale**: why this number and split, the failure modes of fewer or more, orphan concerns and who should own them if the team grows.
   - **Ownership map**: `Concern | Owner | Notes`. Every concern from step 1 appears exactly once; a concern with two owners is a bug to fix.
   - **Handoff rules**: `agent-a → agent-b` when <condition>, and what each says.
   - **Conflict resolution**: `Boundary | Agent A | Agent B | Resolution`, one row per real edge, brief for small teams. Default: the owner of the decision wins.
4. **Summarise**: the file written, agent names, how to create each (`/agents`, give the name, paste the description), and any orphan concerns.

No generic personas: an agent that would fit any company is a failure.
