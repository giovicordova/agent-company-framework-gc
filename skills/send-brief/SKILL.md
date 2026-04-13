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

Read each recipient's PERSONA.md to understand their domain, boundaries, and terminology. This ensures the brief speaks in terms the recipient recognises and assigns only work within their ownership.

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

### Action items as checkboxes (mandatory)

Every actionable item in the brief **must** be a markdown checkbox (`- [ ]`). A brief with actionable items but no checkboxes is invalid — rewrite it before delivering. This lets the receiving agent mark items done as they work, and makes it trivial to find remaining work (`grep "- \[ \]" agent-company/*/mailbox/*`) and to detect when a brief is fully complete (no `- [ ]` left).

Group checkboxes by priority or section. Each checkbox is one discrete, verifiable action — not a paragraph. Keep the explanation on the same line or immediately below, indented.

```markdown
## High priority
- [ ] Remove pricing from hero section
  Desktop bullet 1 → "First file free. No credit card needed."
- [ ] Fix cost table: 8 hours should be $240 (8 × $30)

## Medium priority
- [ ] "RMS level" → "Loudness" in checklist
```

When a brief has no actionable items (pure context or decision request), checkboxes are not needed. But if the expected outcome involves the recipient changing anything, use checkboxes.

### Brief format

```markdown
# {Descriptive Title}

From: {Sender}
{Edited by: {Editorial Agent} — only if editorial agent exists}
Date: {YYYY-MM-DD}

## Context

{Why this brief exists. 2-3 sentences max.}

## {Sections with checkbox items}

- [ ] {Action item}
  {Supporting detail if needed.}

## Expected outcome

{What the recipient should do or decide. Reference the checkboxes above.}

**When you check off the final item, move this file to `agent-company/{recipient}/mailbox/archive/{filename}`.** This is the last step of the brief — do not skip it. If the archive folder does not exist, create it.
```

Use the clean agent name for From — `Marketing`, `Design`, `Editorial`, etc. No titles like "Specialist" or "Analyst". Match the names as they appear in COMPANY.md.

### Length discipline

Keep briefs under 300 words. If the content genuinely requires more, it's fine — but most briefs are tighter than people think. A brief that takes longer to read than to act on is too long. Front-load the most important information so the recipient can skim and act.

Adapt the section structure to fit the content. The template is a guide, not a cage. Some briefs need tables, some need lists, some need a single narrative section. Match the structure to the message.

## Step 5 — Review

Show the complete brief to the user before saving. Ask if it's ready to deliver or needs changes. Do not save until confirmed.

## Step 6 — Deliver

Save to each recipient's mailbox:

```
agent-company/{recipient}/mailbox/{topic}.md
```

Filename: kebab-case, descriptive (e.g. `homepage-layout-brief.md`). If a file with the same name already exists, ask whether to replace or rename.

Ensure `agent-company/{recipient}/mailbox/archive/` exists — create it if missing — so the recipient has somewhere to move the brief once every checkbox is ticked. The literal archive instruction is already embedded in the brief's **Expected outcome** section, so the recipient knows what to do; this step just guarantees the destination is ready.

When sending to multiple recipients, the brief content stays the same — but the **Expected outcome** section is tailored per recipient. Each agent needs different actions, even when the context is identical.

Confirm delivery with the file path(s).
