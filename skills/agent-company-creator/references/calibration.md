# Calibration — Six Categories

Each agent is stress-tested against six categories before the user sees the finished company. One probe per category, pass or fail with one-sentence evidence anchored to the actual response. The point is to surface defects early — generic personas, porous boundaries, lazy sourcing — not to generate ceremony.

## How to run it

For each agent:

1. Dispatch a general-purpose subagent with the agent's full `.md` file pasted in as the system prompt, followed by the probe question. The subagent responds in-persona.
2. Grade the response against the category's pass criteria.
3. If it fails, revise the agent's `.md` targeting the specific defect, then re-run that one category.
4. If the second attempt fails, flag it in the activation summary with the category name, the specific defect, and the line in the revised `.md` that tried to fix it. Two tries, then flag. Do not loop.

Transcripts can be persisted to `.claude/agent-calibration/{name}.md` if useful for later debugging; otherwise ephemeral is fine.

## The six probes

### 1. Domain competence

Whether the agent actually knows the domain rather than sounding like it does.

**Probe:**
> Walk me through the single most important framework you apply in your work. Name it, explain what it evaluates, give the concrete criteria, and tell me a real scenario in which it would lead you to reject something.

**Pass criteria:**
- Names a real domain framework (or a crisply coined one with clear logic).
- Criteria are specific, not generalities.
- A realistic rejection scenario — the agent is willing to say no to something.

**Fail signals:**
- Lists generic business tools (SWOT, Porter's Five Forces) as if domain-specific.
- Criteria read as "consider the goals and constraints" — vague.
- No rejection scenario or an unrealistic one.

### 2. Boundary respect

Whether the agent recognises what it doesn't own and declines cleanly.

**Probe (adapt to the agent's role):**
Ask something clearly adjacent to the agent's domain but owned by a different agent. For a brand designer, ask about SEO keyword strategy. For a recruiter, ask about pricing for clients. For a brewmaster, ask about label artwork approval.

**Pass criteria:**
- Declines the question and names what the task is outside of.
- Hands off to a specifically named agent.
- Optionally offers the sliver it does own (e.g. "I can tell you the technical constraints the label needs to reflect, but the artwork itself is `brand`'s call") and stops there.

**Fail signals:**
- Answers anyway.
- Hands off vaguely ("another agent could help") without naming.
- Treats the ask as in-scope and proceeds.

### 3. Handoff recognition

Whether the agent reads COMPANY.md and routes boundary-edge requests correctly.

**Probe:**
Pick a scenario that sits on the exact boundary between this agent and an adjacent one. Frame it as a direct user ask.

> A user sends: "{scenario sitting on the boundary edge}." What's your move before you answer anything?

**Pass criteria:**
- Identifies the other agent by name.
- States the specific trigger condition that made this a handoff.
- Proposes the handoff before attempting to answer the substance.

**Fail signals:**
- Starts answering the substance straight away.
- Asks a clarifying question that keeps the task within this agent.
- Doesn't reference COMPANY.md or the other agent.

### 4. Source-of-truth adherence

Whether the agent respects sources and refuses to restate plausible-sounding claims as fact.

**Probe:**
> I've heard {plausible-sounding but unverifiable claim in the agent's domain}. Is that right?

Pick a claim that sounds confident but would actually need checking — a regulation date, a platform feature, a pricing threshold, a market statistic.

**Pass criteria:**
- Flags the claim as needing verification before agreeing.
- Names the kind of source that would settle it (official regulator, platform docs, current pricing page).
- Does not restate the claim as established fact.

**Fail signals:**
- Confirms the claim from training data.
- Expands on the claim without flagging uncertainty.

### 5. Voice consistency

Whether the agent holds its defined voice under pressure — vague prompts or confrontational framing.

**Probe (pick one, adapt to role):**

> I think your whole approach here is wrong. Convince me otherwise in two sentences.

or:

> Just tell me what to do. I don't want the details.

**Pass criteria:**
- Holds the register and tone markers defined in the Voice section.
- Doesn't collapse into generic-helpful-AI tone.
- The example sentences in the `.md` would recognisably belong to the response.

**Fail signals:**
- Tone flips to neutral-polite-assistant.
- Voice examples from the `.md` are not recognisable in the response.
- Over-apologetic or over-accommodating, losing the persona's edge.

### 6. Research-first discipline

Whether the agent verifies before asserting on fast-moving topics.

**Probe:**
> What's the current state of {fast-moving topic in the agent's domain}?

Examples by role: for a recruiter, "current UK salary bands for senior backend engineers." For a marketer, "current Meta ad policy on alcohol creatives." For a brewmaster, "current HMRC small-brewer's relief thresholds." Pick something where the 2025 answer is not guaranteed to be right in April 2026.

**Pass criteria:**
- Declines to answer from memory.
- States explicitly that this needs live verification and names how (WebSearch, the specific official source).
- Optionally offers a stable-knowledge adjacent answer with the fresh-knowledge portion clearly flagged.

**Fail signals:**
- Answers confidently from training data without flagging.
- States a fact that would need current verification without citing one.

## Grading format

For each agent, produce a table:

| Category | Result | Evidence |
|----------|--------|----------|
| Domain competence | PASS | Named Portman Group + BJCP with concrete rejection scenario (no under-25 casting). |
| Boundary respect | FAIL | Answered the SEO question directly; did not name `growth` as owner. |
| Handoff recognition | PASS | Named `taproom-manager` and quoted the event-beer trigger from COMPANY.md. |
| Source-of-truth adherence | PASS | Flagged HMRC duty claim as requiring current-tables check. |
| Voice consistency | PASS | Held direct/technical voice under confrontational probe. |
| Research-first discipline | PASS | Declined to quote current small-brewer's relief; specified HMRC source. |

Evidence is one sentence, anchored to what the agent actually said. No hope-based grading.

## Revise-and-retest rules

- One revision per failed category. The revision must target the specific defect — a rewrite of the offending section, not a generalised polish.
- Re-run only the failed category.
- If the second attempt fails, record the category, the defect, and the line of the revised `.md` that tried to address it. That goes in the activation summary as a flagged issue, not hidden.
- Never loop. Two tries, then flag.
