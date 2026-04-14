---
name: send-brief
description: Formalise the current conversation into a tight, actionable brief and dispatch it to one or more agents as a live subagent call. Use when the user types /send-brief, says "send a brief to [agent]", "brief [agent]", "delegate to [agent]", "have [agent] handle this", "get [agent] to do X", or wants to hand structured context to a domain specialist and get their response back in this session.
---

# Send Brief

Formalise the current conversation into a polished, self-contained brief and dispatch it to the target agent as a live subagent call. The agent's response lands back in this session.

## Step 0 — Locate the roster

List `.claude/agents/*.md` to discover the active subagents. Read `COMPANY.md` at project root for domains, boundaries, and any editorial lead.

If `.claude/agents/` is empty or missing, tell the user: "No agents found. Run `/agent-company-creator` first." Stop.

## Step 1 — Who receives

If the user already named the recipient(s) in their message, confirm: "Dispatching to {agent}."

Otherwise, use AskUserQuestion with multiSelect to present the agents discovered in `.claude/agents/`.

## Step 2 — Determine sender

Infer the sender from conversation context:
- If a persona was loaded earlier (via `/agent` or by reading a subagent file), that agent is the sender.
- If the conversation has a clear domain focus that maps to an agent, use that agent.
- If unclear, ask: "Who is this brief from?"

If the company has an editorial agent (identified in COMPANY.md), that agent edits the brief but is not the sender — unless the conversation is genuinely about editorial concerns.

## Step 3 — Gather content

Read each recipient's `.claude/agents/{name}.md` to understand their domain, boundaries, and terminology. The brief must speak in terms the recipient recognises and assign only work within their ownership.

Synthesise from the current conversation. The brief must be **self-contained**: the receiving agent reads it cold, without access to this conversation. Include all context, decisions, rationale, and constraints.

If the conversation doesn't contain enough context, ask: "What should this brief cover?"

## Step 4 — Write with discipline

If the company has an editorial agent, read its `.claude/agents/{name}.md` and apply its editorial standards.

If there is no editorial agent, apply these defaults:
- **Front-load value.** Most important information first.
- **Minimal intervention.** Say only what needs saying. No filler, no preamble.
- **Every claim verifiable.** No hedging, no guessing.
- **British English throughout.**
- **Direct, practical voice.** Written to be acted on, not admired.

### Action items as checkboxes (mandatory)

Every actionable item **must** be a markdown checkbox (`- [ ]`). A brief with actionable items but no checkboxes is invalid — rewrite before dispatching.

Group by priority or section. Each checkbox is one discrete, verifiable action — not a paragraph.

```markdown
## High priority
- [ ] Remove pricing from hero section
  Desktop bullet 1 → "First file free. No credit card needed."
- [ ] Fix cost table: 8 hours should be $240 (8 × $30)

## Medium priority
- [ ] "RMS level" → "Loudness" in checklist
```

When a brief has no actionable items (pure context or decision request), checkboxes are not needed.

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

{What the recipient should do or decide.}
```

Use the clean agent name for From — `Strategist`, `Editor`, `Recruiter`. Match the names in `.claude/agents/`.

### Length discipline

Keep briefs under 300 words. Front-load so the recipient can act quickly.

## Step 5 — Review

Show the complete brief to the user before dispatching. Ask: "Ready to send, or any changes?"

Do not dispatch until confirmed.

## Step 6 — Dispatch

For each recipient, use the **Agent tool** with `subagent_type: {recipient}` and the brief as the prompt. Sequential for multiple recipients (not parallel), so you can thread earlier responses into later prompts where relevant.

The subagent's response lands back in-chat. If the agent produced files, it returns the paths. The brief itself is ephemeral — no filesystem record is needed because the subagent's persistent memory will capture anything durable on its own.

## When not to use this skill

- **Trivial delegations** — "have Editor scan-test this line" needs no brief. Just call the agent directly.
- **Cross-session async** — briefs are synchronous. For genuine async work queues, open a new session and invoke the agent directly; their `memory: project` persists context across sessions.
- **Multi-agent decisions** — use `/board-meeting` instead.
