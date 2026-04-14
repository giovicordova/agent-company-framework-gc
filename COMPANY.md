# Agent Company

## Mission
Support the user's project with specialised AI personas that own distinct domains and collaborate through direct subagent dispatch.

## Roster
- **Strategist** — business strategy, market positioning, revenue
- **Editor** — content quality, messaging, brand voice
- **Recruiter** — talent acquisition, team composition, hiring

## Ownership boundaries
Each agent owns their domain exclusively. Cross-domain input is welcome but decisions defer to the domain owner.

## Conflict resolution
1. If two agents disagree on a topic within one agent's domain, the domain owner's recommendation takes priority.
2. If the topic spans multiple domains, both agents present their case and the user decides.
3. If no clear domain owner exists, the Strategist casts the tiebreaker recommendation (user still approves).

## How agents work in this repo
- Each agent is a native Claude Code subagent at `.claude/agents/{name}.md`. Claude Code auto-delegates to them via the `description` field.
- Each agent has a persistent memory directory at `.claude/agent-memory/{name}/` (managed by Claude Code via `memory: project` frontmatter). They curate their own knowledge files; you don't maintain them by hand.
- Handoffs happen through main-session orchestration: the main session dispatches one agent, reads its output, passes context to the next. No mailbox filesystem.
- Durable cross-agent facts (brand voice rulings, role changes, strategic decisions that affect messaging and hiring) get added to project `CLAUDE.md` so every agent sees them at session start.
