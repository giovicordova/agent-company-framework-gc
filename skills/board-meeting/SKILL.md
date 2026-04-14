---
name: board-meeting
description: Convene every persona in the agent-company as a real round-table. Use whenever the user says "board meeting", "convene the board", "ask the agents", "get the team's view", "what does the company think", or wants multiple agent-company personas to sequentially weigh in on a decision, proposal, plan, or problem and reach a shared recommendation. Auto-discovers whatever subagents exist in .claude/agents/.
---

# Board Meeting

Convene every agent in `.claude/agents/` as a real round-table: the main session dispatches each agent as an independent subagent in sequence, threading prior speakers' turns into each next prompt, and synthesises the Board Recommendation at the end.

## Why this exists

The agent-company is growing. The user wants one place to get the whole team's combined view on a single input — a plan, a strategic question, a draft — without spawning separate sessions or dispatching agents one by one manually.

Unlike the previous single-Claude simulation, each agent speaks in its own voice — genuinely, not role-played — because each is a real subagent dispatched from `.claude/agents/`. Threading prior turns into each next prompt keeps the round-table discipline: every agent engages with what came before.

## How to run a meeting

### 1. Discover the board

List the current roster:

```bash
ls .claude/agents/
```

Each `.md` file is a board member. Read `COMPANY.md` for ownership boundaries and conflict-resolution rules.

If `.claude/agents/` is empty or missing, tell Gio there's no board to convene and stop.

### 2. Open the meeting

State:
- The roster (agent names, lowercase, matching file stems)
- The input under discussion (quote or summarise Gio's input)
- The question on the table (what decision or recommendation is sought)

If the input or question is ambiguous, ask Gio **one** clarifying question before proceeding. Don't stall the meeting with interviews.

### 3. Order the speakers

Order by domain relevance: whoever owns the primary domain speaks first, adjacent domains next, tangential domains last. Use `COMPANY.md`'s ownership map. If no COMPANY.md, read each agent's frontmatter `description` and sequence by best match.

### 4. Dispatch agents sequentially

For each agent in order, use the **Agent tool** with `subagent_type: {agent_name}`. The prompt must include:

- **The input**: Gio's question or brief, verbatim.
- **Prior speakers**: the exact turns that came before, in order. (Empty for the first speaker.)
- **Length budget**: "Respond in ≤60 words. Count before sending. A 45-word turn that lands is better than a 65-word turn that rambles."
- **Required moves**: "Apply your domain frameworks by name. Engage with prior speakers — agree, build, or push back. Surface one realistic risk from your domain. End with a concrete position: recommend / object / abstain."
- **Format**: "One tight paragraph. No bullets. No preamble. No 'great points everyone'."
- **Research guardrail**: "If you'd need to verify a fact to answer well, flag it rather than stating from memory."

After each dispatch returns, transcribe under a header:

```
## <Agent Name>
<verbatim subagent response>
```

Then move to the next agent, including this turn in the "Prior speakers" block of the next prompt.

### 5. Length budget (hard limits)

Gio reads these meetings on a phone between tasks.

- **Each agent turn: ≤ 60 words.** Enforced via the per-agent prompt. If a returned turn exceeds 60 words, re-dispatch that agent with "Your previous response was X words. Tighten to ≤60 and return the full turn."
- **Whole meeting: ≤ 400 words total** before the Board Recommendation. If the roster is large, turns get shorter — not the meeting longer.
- **Board Recommendation: ≤ 80 words.** Written by the main session, not a subagent.

### 6. Handle disagreement

If two agents conflict:
- Surface the conflict explicitly in the transcript ("Editor and Recruiter disagree on X").
- Check `COMPANY.md` conflict-resolution table — if documented, apply it.
- Otherwise, re-dispatch the disagreeing agents for one more turn each (with the conflict framed in the prompt), then synthesise. Don't let the board loop.

### 7. Synthesis and recommendation

After all turns, the main session writes a **Board Recommendation** section:
- Single consolidated recommendation (≤80 words)
- Who supported it, who dissented, who abstained
- Any conditions or follow-ups
- The concrete next action Gio can take or reject

Do not dispatch a subagent for synthesis — this is the main session's job.

### 8. Approval and save prompt

End with both prompts in one block:

> *Approve, amend, or reject?*
>
> *Keep this in the chat only, or save as a board meeting document?*

Wait for Gio. Do not execute the recommendation.

If Gio amends, re-dispatch only the affected agents, not the full board.

### 9. Save to file (if requested)

If Gio chooses to save, write to `.claude/board-meetings/YYYYMMDD-HHMM-NNN-bm.md`. Create the directory if missing. `NNN` is zero-padded sequential starting at `001` for the day (check the folder for existing files from the same day to determine the next number).

Document structure (summary leads, discussion follows):

```markdown
# Board Meeting — <one-line topic>
**Date:** YYYY-MM-DD HH:MM
**Roster:** <comma-separated agent names>

## Summary
<2–4 sentences: what was discussed, what the board recommended, key risks surfaced, and the decision Gio made (approve/amend/reject). Readable in under 10 seconds.>

## Board Recommendation
<the recommendation>

## Discussion
<full agent turns in order, verbatim>
```

If Gio says keep in chat only, do nothing — the meeting output is already visible.

## Voice discipline

Subagents dispatched from `.claude/agents/` arrive in their own voice — you don't simulate. The per-agent prompt reinforces it:

- Instruct the agent to reference frameworks by name. If Recruiter has a "calibration protocol", invoke it. If Editor has a "Scan Test", use it.
- Instruct the agent to respect its `Does not own` list. If a topic is outside their domain, they should say "not my call" and defer.
- Instruct the agent never to state facts from memory when the topic demands verification (market data, legal, salary ranges).

## Scaling to any roster

Works with 2 agents or 20. Two rules:

1. **Discover, don't hardcode.** Re-list `.claude/agents/*.md` at the start of each meeting.
2. **Domain drives order, not filesystem.** Use `COMPANY.md` ownership map or agent descriptions to sequence turns.

## What this skill is not

- Not a replacement for single-agent dispatch — for one-on-one handoff, use Claude Code's native subagent call directly. Board meeting is a multi-agent synchronous discussion.
- Not a place to execute the recommendation. The meeting ends at approval; execution happens afterwards.
- Not a place for deep research mid-meeting. If an agent needs info they don't have, they flag it as a follow-up — they don't stall the room.
