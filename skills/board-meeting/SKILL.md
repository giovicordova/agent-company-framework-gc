---
name: board-meeting
description: Convene every agent in .claude/agents/ as a sequential round-table on one decision, plan or problem, then synthesise a board recommendation. Use when the user says "board meeting", "convene the board", "ask the agents", "get the team's view" or "what does the company think".
---

# Board Meeting

Each agent in `.claude/agents/` speaks as a real subagent, in sequence, seeing every prior turn. The main session synthesises.

1. **Roster.** List `.claude/agents/*.md` fresh each time; if there are none, say there's no board and stop. Read `COMPANY.md` for ownership and conflict rules if it exists.
2. **Open.** State the roster, the input (quoted or summarised) and the question on the table. If either is ambiguous, ask one clarifying question.
3. **Order** by domain relevance: primary owner first, tangential last (COMPANY.md ownership map, else agent descriptions).
4. **Dispatch in sequence** with the Agent tool (`subagent_type: <agent>`). Each prompt carries:
   - the input verbatim, and all prior turns in order;
   - "≤60 words, one paragraph, no bullets or preamble";
   - "apply your frameworks by name, engage with prior speakers, raise one realistic risk from your domain, end with recommend / object / abstain";
   - "flag facts you'd need to verify rather than stating them from memory; say 'not my call' outside your domain".

   Transcribe each reply verbatim under `## <agent>`.
5. **Disagreement.** Name it ("Editor and Recruiter disagree on X"). Apply COMPANY.md's conflict rule if there is one; otherwise give each side one more turn with the conflict framed, then move on.
6. **Board Recommendation**, written by the main session in ≤80 words: the recommendation, who supported, dissented or abstained, conditions, and the next action. Keep the meeting ≤400 words before it; a large roster means shorter turns, not a longer meeting.
7. **Close** with *Approve, amend, or reject?* and *Keep in chat, or save as a document?* Don't execute the recommendation. On amend, re-dispatch only the affected agents.
8. **Save** (if asked) to `.claude/board-meetings/YYYYMMDD-HHMM-NNN-bm.md` (NNN = next number for the day): title, date, roster, a 2-4 sentence summary including the decision, the recommendation, then the full discussion.
