---
name: send-brief
description: Write and deliver a polished brief to one or more agent mailboxes. Use when the user types /send-brief, says "send a brief to [agent]", "write a brief for [agent]", "mail [agent]", "brief [agent]", or wants to formalise conversation context into an actionable handoff for another domain agent. Also triggers when the user mentions sending something to a mailbox or delivering work to another persona.
---

# Send Brief

Formalise the current conversation into a polished, actionable brief and deliver it to one or more agent mailboxes.

## Step 0 — Locate the company

Find `agent-company/COMPANY.md` in the project. If it doesn't exist, tell the user: "No agent company found in this project. Run `/agent-company-creator` first."

Read COMPANY.md to get:
- The list of active agents (folder names)
- Their domains and boundaries
- Any agent designated as editorial lead (if one exists)

## Step 1 — Who receives

Use AskUserQuestion with multiSelect to present the agents found in COMPANY.md:

```
{list agent names dynamically from COMPANY.md}
```

If the user already named the recipient(s) in their message, skip the question and confirm: "Sending to {agent}."

## Step 2 — Determine sender

Infer the sender from conversation context:

- If a persona was loaded earlier in the conversation (via `/agent` or by reading a PERSONA.md), that agent is the sender.
- If the conversation has a clear domain focus that maps to an agent in COMPANY.md, use that agent.
- If unclear, ask: "Who is this brief from?"

If the company has an editorial agent, that agent edits the brief but is not the sender — unless the conversation is genuinely about editorial concerns.

## Step 3 — Gather content

Synthesise from the current conversation. The brief must be **self-contained**: the receiving agent reads it cold, without access to this conversation. Include all context, decisions, rationale, and constraints they need.

If the conversation doesn't contain enough context for a complete brief, ask: "What should this brief cover?"

## Step 4 — Write with discipline

If the company has an editorial agent, read its PERSONA.md and apply its editorial standards.

If there is no editorial agent, apply these defaults:

- **Front-load value.** The most important information goes first. If the recipient reads only the first paragraph, they should know what's needed.
- **Minimal intervention.** Say only what needs saying. No filler, no preamble.
- **Every claim verifiable.** No hedging, no guessing.
- **British English throughout.**
- **Direct, practical voice.** Written for someone who needs to act on it, not admire it.

### Brief format

```markdown
# {Descriptive Title}

From: {Sender}
{Edited by: {Editorial Agent} — only if editorial agent exists}
Date: {YYYY-MM-DD}

## Context

{Why this brief exists. 2-3 sentences max.}

## {Sections as needed}

{The substance. Structured for the recipient's domain.
Self-contained: all context the recipient needs to act.}

## Expected outcome

{What the recipient should do or decide.}
```

Use the clean agent name for From — `Marketing`, `Design`, `Editorial`, etc. No titles like "Specialist" or "Analyst". Match the names as they appear in COMPANY.md.

Adapt the section structure to fit the content. The template is a guide, not a cage. Some briefs need tables, some need lists, some need a single narrative section. Match the structure to the message.

## Step 5 — Review

Show the complete brief to the user before saving. Ask if it's ready to deliver or needs changes. Do not save until confirmed.

## Step 6 — Deliver

Save to each recipient's mailbox:

```
agent-company/{recipient}/mailbox/{topic}.md
```

Filename: kebab-case, descriptive (e.g. `homepage-layout-brief.md`). If a file with the same name already exists, ask whether to replace or rename.

When sending to multiple recipients, the brief content stays the same — but the **Expected outcome** section is tailored per recipient. Each agent needs different actions, even when the context is identical.

Confirm delivery with the file path(s).
