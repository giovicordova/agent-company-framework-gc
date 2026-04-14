---
name: board-meeting
description: Convene every persona in the agent-company as a board meeting inside the current Claude Code session. Use whenever the user says "board meeting", "convene the board", "ask the agents", "get the team's view", "what does the company think", or wants multiple agent-company personas to sequentially weigh in on a decision, proposal, plan, or problem and reach a shared recommendation. Works with any number of agents — auto-discovers whatever personas currently exist.
---

# Board Meeting

Simulate a round-table discussion among every persona in `agent-company/`, in the current session. One Claude, many voices — each speaking in character, sequentially, until the board reaches a recommendation Gio can approve.

## Why this exists

The agent-company is growing (3 personas now, more coming). Gio wants one place to get the whole team's combined view on a single input — a job, a plan, a strategic question, a draft — without spawning separate sessions or copying briefs between mailboxes. This skill is the boardroom.

## How to run a meeting

### 1. Discover the board

Dynamically list the current roster — do not hardcode names:

```
ls agent-company/*/PERSONA.md
```

Every folder under `agent-company/` containing a `PERSONA.md` is a board member. Read each `PERSONA.md` in full before the meeting starts so every voice is grounded in its actual domain, ownership, and style — not a guess.

If `agent-company/COMPANY.md` exists, read it too: it defines ownership boundaries and conflict-resolution rules that should govern the meeting.

### 2. Open the meeting

State:
- The roster (who's at the table today)
- The input under discussion (quote or summarise what Gio brought)
- The question on the table (what decision or recommendation is being sought)

If the input or question is ambiguous, ask Gio **one** clarifying question before proceeding. Don't stall the meeting with interviews.

### 3. Go around the table — sequentially

Each agent speaks in turn, in its own voice, with a clear header:

```
## <Agent Name> (<one-line domain>)
```

Each turn must:
- Engage with what previous speakers said — agree, build, push back, or flag a conflict. A board meeting is not a stack of monologues.
- Apply that agent's **actual** expertise from its PERSONA.md. If the topic is outside their domain, they should say so briefly and defer rather than invent an opinion.
- **Surface one realistic risk or counterpoint** from their domain. Not extreme, not hypothetical — something that could actually go wrong or that the group might be overlooking. This is not a separate step; weave it into the turn naturally. If the agent genuinely sees no risk, they say so and move on — don't invent problems.
- End with that agent's concrete position: recommend / object / abstain, plus the reason in one or two sentences.

Order matters. Sequence the agents so the conversation builds: whoever owns the primary domain of the input speaks first, adjacent domains next, and any agent whose domain is tangential speaks last (or passes). Use `COMPANY.md` ownership map to decide.

Keep each turn tight — a few sentences to a short paragraph. Density over length.

### Length budget (hard limits)

Gio reads these meetings on a phone between tasks. Long transcripts kill the skill. Enforce:

- **Each agent turn: ≤ 60 words.** One idea, one position, done. If an agent needs more, they're doing research, not speaking at a board.
- **Whole meeting: ≤ 400 words total** before the Board Recommendation, regardless of roster size. If the roster is large, turns get shorter — not the meeting longer.
- **Board Recommendation: ≤ 80 words.** Must fit on one phone screen.
- **No preamble, no recap, no "great points everyone".** Start at the first agent's header. End at "Approve, amend, or reject?".
- **No bullet lists inside agent turns** unless the agent is literally enumerating options. Prose is tighter.

If you catch yourself writing a long turn, cut it in half before moving on. Err on the side of too short.

### 4. Handle disagreement

If two agents conflict:
- Surface the conflict explicitly ("Editor and Recruiter disagree on X").
- Check `COMPANY.md` conflict-resolution table — if there's a documented resolution, apply it.
- Otherwise, let the disagreeing agents exchange one more turn each, then move to synthesis. Don't let the board loop.

### 5. Synthesis and recommendation

After everyone has spoken, write a **Board Recommendation** section:
- The single consolidated recommendation
- Who supported it, who dissented, who abstained
- Any conditions or follow-ups attached
- The concrete next action Gio can take or reject

### 6. Approval

End with: *"Approve, amend, or reject?"* — and stop. Wait for Gio. Do not execute the recommendation until he signs off.

If Gio amends, re-run only the affected turns (not the whole meeting) and re-synthesise.

### 7. Save or discard

After Gio approves (or after any amend cycle), ask using AskUserQuestion:

> *"Keep this in the chat only, or save as a board meeting document?"*

If Gio chooses to save, generate a markdown file in `docs/board-meetings/` (create the directory if it doesn't exist). Name it:

```
YYYYMMDD-HHMM-NNN-bm.md
```

Where `YYYYMMDD-HHMM` is the current date and time, and `NNN` is a zero-padded sequential number starting at `001` for the day (check the folder for existing files from the same day to determine the next number).

#### Document structure

The document **leads with the summary** — the opposite of the chat flow, where the summary naturally comes last:

```markdown
# Board Meeting — <one-line topic>
**Date:** YYYY-MM-DD HH:MM
**Roster:** <comma-separated agent names>

## Summary
<2–4 sentences: what was discussed, what the board recommended, key risks surfaced, and the decision Gio made (approve/amend/reject). Readable in under 10 seconds.>

## Board Recommendation
<the recommendation as it appeared in the meeting>

## Discussion
<full agent turns in order, exactly as they appeared in the chat>
```

If Gio says keep in chat only, do nothing — the meeting output is already visible.

## Voice discipline

The quality of a board meeting lives or dies on whether each agent sounds like themselves, not like a generic assistant with a name tag. Before speaking for an agent:

- Pull 2–3 specific things from that agent's PERSONA.md — a phrase they'd use, a framework they own, a thing they explicitly do *not* own.
- Speak from inside those. If the Recruiter has a "calibration protocol", invoke it by name. If the Editor has a "Scan Test", use it. Specificity is what makes the voices distinct.
- Never put words in an agent's mouth that contradict its `Does not own` list in PERSONA.md. If a topic is outside their lane, they should say "not my call" and defer.

## Scaling to any roster

This skill must work with 2 agents or 20. Two rules keep it robust:

1. **Discover, don't hardcode.** Always re-list `agent-company/*/PERSONA.md` at the start of each meeting. Never assume the roster from memory or prior conversation.
2. **Let domains drive order, not the filesystem.** Order agents by relevance to the input, using `COMPANY.md` if it exists, or by reading each PERSONA.md's domain line otherwise.

If `agent-company/` is empty or missing, tell Gio there's no board to convene and stop.

## What this skill is not

- Not a replacement for `/send-brief` — that's for handing real work between agents across sessions. Board meeting is a discussion, not a handoff.
- Not a place to execute the recommendation. The meeting ends at approval; execution happens afterwards in the normal way.
- Not a place for the agents to do deep research mid-meeting. If an agent needs information they don't have, they say so and flag it as a follow-up — they don't stall the room.
