# Activation Summary — Music Production Studio Agent Company

## Calibration mechanism

**Content-level calibration.** The Agent tool was not available for live dispatch in this eval session. Instead, each agent's `.md` was graded strictly against the six-probe rubric in `references/calibration.md` by citing the specific lines that would produce a passing response. Flagged here for full transparency — a live dispatch run would add behavioural evidence that content review cannot replicate.

## Files written

All paths relative to the sandbox root `/Users/giovannicordova/Documents/02_projects/_P4_tooling/agent-company-framework-gc/skills/agent-company-creator/agent-company-creator-workspace/iteration-2/eval-2-music-studio/with_skill/outputs/`. The sandbox strips the `.claude/` prefix, so files are written to `agents/` flat. Production relocation to `.claude/agents/` is clean because every frontmatter declares `memory: project`.

- `agents/client-relations.md`
- `agents/social-media.md`
- `agents/bookkeeper.md`
- `agents/studio-manager.md`
- `COMPANY.md`
- `activation-summary.md` (this file)

**Agent count:** 4.

## Calibration results

### `client-relations`

| Category | Result | Evidence |
|----------|--------|----------|
| Domain competence | PASS | Enquiry-to-fit scorecard with 5 weighted dimensions and <15/25 → decline threshold; deposit-milestone-balance with concrete £500 trigger. |
| Boundary respect | PASS | "Does not own" explicitly routes invoicing, public posts, and scheduling to the three other agents with named handoff triggers. |
| Handoff recognition | PASS | "Hands off to" section names each agent plus trigger ("deposit paid → `studio-manager`"; "payment-terms → `bookkeeper`"). |
| Source-of-truth adherence | PASS | Failure mode bans quoting market rates from memory; Standing Instructions name SoundBetter / Gearspace / MPG with URL requirement. |
| Voice consistency | PASS | Voice examples quote specific GBP amounts and push back on vague briefs ("£400 job and a £900 one"), demonstrating the direct-deliberate register. |
| Research-first discipline | PASS | Standing Instructions require live-source verification with citation for all market-rate quotes; failure mode reinforces this. |

### `social-media`

| Category | Result | Evidence |
|----------|--------|----------|
| Domain competence | PASS | Hook-Retention-CTA triage with explicit rewrite-or-kill threshold; Platform-channel fit map rejects blind cross-posting. |
| Boundary respect | PASS | "Does not own" routes proposals, invoices, and scheduling to the three other agents; description's "Do NOT use" clause mirrors this. |
| Handoff recognition | PASS | DM-as-enquiry → `client-relations`; sponsorship → `bookkeeper`; BTS scheduling → `studio-manager`, each with trigger condition. |
| Source-of-truth adherence | PASS | Failure mode calls out training-data platform-reach claims as stale; Standing Instructions name platform blogs and Social Media Today. |
| Voice consistency | PASS | Voice examples demonstrate platform-native sharpness ("Retention or it didn't happen") and pushback on unclear-permission scenarios. |
| Research-first discipline | PASS | Standing Instructions explicitly ban quoting platform algorithm / ad-policy / creator-fund rules from training data. |

### `bookkeeper`

| Category | Result | Evidence |
|----------|--------|----------|
| Domain competence | PASS | Ageing bucket triage with fixed action per bucket and Late Payment Act citation; VAT-threshold watch with 80%/90% decision triggers. |
| Boundary respect | PASS | "Does not own" separates outreach (→ `client-relations`), Self Assessment (→ external accountant), and public posts (→ `social-media`). |
| Handoff recognition | PASS | Handoff to `client-relations` for relationship recovery; to `studio-manager` for cashflow-scheduling interplay; to external accountant for out-of-scope tax advice. |
| Source-of-truth adherence | PASS | Failure mode explicitly bans memory-quoted VAT thresholds, MTD rules, and Late Payment Act interest rates; Standing Instructions cite gov.uk URLs. |
| Voice consistency | PASS | Voice examples demonstrate clinical-numbers-first register ("You're at £82k rolling turnover. VAT threshold is £90k…"). |
| Research-first discipline | PASS | Standing Instructions require HMRC URL citation for all tax/VAT figures quoted; failure mode reinforces. |

### `studio-manager`

| Category | Result | Evidence |
|----------|--------|----------|
| Domain competence | PASS | WIP-and-capacity ledger with 75/15/10 utilisation target and >90% booking-freeze; sign-off gate enforcement between project stages. |
| Boundary respect | PASS | "Does not own" excludes outreach, content, invoicing, and creative calls with specific handoffs named. |
| Handoff recognition | PASS | Explicit handoff triggers for each adjacent agent; weekly Friday handoff sweep institutionalises the mechanism. |
| Source-of-truth adherence | PASS | Failure mode rejects "industry-standard" timelines from training data; requires historical throughput from the WIP log as the source of truth. |
| Voice consistency | PASS | Voice examples demonstrate operational-specificity register ("Tuesday's vocal session overran by ninety minutes, so the mix slot on Wednesday morning now starts at 11:00"). |
| Research-first discipline | PASS | Standing Instructions require URL citation for external claims about session norms, equipment lead times, or industry timelines. |

**No category failed. No revisions were required.**

## Routing sanity check

**Mechanism:** content-level routing check. 12 realistic user prompts were drafted (mix of core-domain, edge-case, and ambiguous phrasings) and matched against the four agent `description` fields twice. Descriptions include explicit trigger phrases and `Do NOT use` exclusions, which removed every candidate tie.

Representative prompts tested:

1. "Draft a reply to this enquiry from a rapper asking about mix rates." → `client-relations`
2. "The invoice I sent in January still hasn't been paid." → `bookkeeper`
3. "Turn this BTS clip from yesterday's session into a reel." → `social-media`
4. "When's our next free mix slot in three weeks?" → `studio-manager`
5. "A client just DM'd us on Instagram asking about booking." → `social-media` (first reply) → handoff to `client-relations` (per `social-media` description's explicit handoff rule for DM-as-enquiry)
6. "Are we over the VAT threshold yet?" → `bookkeeper`
7. "How should we structure deposits on a new £2k booking?" → `client-relations`
8. "Tuesday's session overran — what does my week look like now?" → `studio-manager`
9. "Should we post about the track we made with Artist X last month?" → `social-media`
10. "Client is asking for a fourth revision round." → `studio-manager` (revision-round counter) → handoff to `client-relations` (renegotiation)
11. "New gear brand wants to sponsor a reel." → `social-media` (content) with explicit handoff to `bookkeeper` (commercial terms) — covered by both descriptions' sponsored-content clauses
12. "We're at 90% capacity next month — should we take this new booking?" → `studio-manager`

**Result: clean.** Both runs returned identical routing. No ties, no "ambiguous" verdicts, no "none" (coverage gaps), no flips between runs. No `description` fields required revision.

The two handoff-chain prompts (5 and 11) are not routing ambiguities — both primary-owner descriptions name the downstream agent and the trigger condition explicitly, so the router has clear guidance on the initial pick plus the follow-on.

## How to dispatch

Once the files are relocated to `.claude/agents/` in production:

- **Direct dispatch by name:** invoke the Agent tool with `subagent_type: client-relations` (or any of the four names). Claude Code reads the frontmatter at session start and registers them.
- **Auto-routing:** describe a task in natural language (e.g. "chase the unpaid invoice from January") and Claude Code's router matches against the `description` fields — in this project that will hit `bookkeeper` cleanly.
- **Round-tables:** use the `board-meeting` skill for any multi-agent decision (pricing architecture, rate-card changes, big strategic calls). That skill auto-discovers the four agents from `.claude/agents/` and sequences their input.

## Worth the user's attention

1. **Sandbox assumptions are in `COMPANY.md`** — UK-based, small, pre-VAT-registration, external accountant exists. Correct any that don't fit before first dispatch.
2. **`bookkeeper` is the agent most likely to go stale** — UK tax thresholds and MTD rules shift with every Budget. Its Standing Instructions force live HMRC checks, but treat memory-only bookkeeper answers with suspicion.
3. **`social-media` clearance log is a hard gate** — no post featuring a client goes out without a written permission entry. Seed this log with any existing verbal agreements on first-session memory setup.
4. **`studio-manager` owns the spine.** If any handoff feels stuck, start there — the Friday handoff sweep is the mechanism, and the user can trigger it mid-week with "run the handoff sweep".
5. **Content-level calibration caveat.** These agents passed content review but have not been live-dispatched. First real-session behaviour may surface defects the `.md` doesn't predict. Re-run the six probes live against each agent in the first working session if any response feels off-persona.
