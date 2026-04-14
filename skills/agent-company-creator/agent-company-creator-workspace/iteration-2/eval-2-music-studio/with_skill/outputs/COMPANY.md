# COMPANY.md — Music Production Studio (Business Operations)

## Sandbox note

Per the eval harness, agent files live at `agents/{name}.md` relative to this COMPANY.md. Every agent's frontmatter still declares `memory: project`, so in production these files relocate cleanly to `.claude/agents/` and persistent memory activates at `.claude/agent-memory/{name}/` with no further edits. Do not interpret the flat `agents/` layout as the production pattern — it is a sandbox substitution only.

## Assumptions

The skill's Step 1 probing questions could not be asked (no live user). Assumptions made — stated explicitly so the user can correct them:

1. **UK-based studio.** Language, VAT treatment, Late Payment of Commercial Debts Act, and Making Tax Digital rules assumed UK. If US or EU, `bookkeeper` needs re-scoping.
2. **Small and solo-ish.** "Small" interpreted as one-to-three people (likely the user plus a freelance engineer or two), not a ten-engineer commercial studio. Drives team sizing.
3. **Mix of services.** Studio does recording, mixing, mastering, and production — the most common small-studio profile. If mastering-only or tracking-only, roles may narrow.
4. **Direct-to-artist clientele with some label work.** Informs the outreach voice and clearance discipline.
5. **Platforms assumed: Instagram, TikTok, YouTube Shorts** as the social defaults. If the studio is Threads/X-heavy or doesn't post video, `social-media` re-scopes.
6. **Not yet VAT-registered, near the threshold.** `bookkeeper` tuned for a studio approaching but under £90k rolling turnover.
7. **Accountant exists externally.** Year-end filing is handled by a human accountant; `bookkeeper` preps the pack but does not file Self Assessment or Corporation Tax.
8. **Budget sensitivity.** Tool scope kept lean — no `Bash`, no `Agent` dispatch, no `Grep/Glob` on roles that only edit text documents.

Open questions the user should answer first session:
- Current rolling turnover and VAT status.
- Which platforms the studio actually posts on today.
- Whether there's an existing client roster file or CRM to seed memory from.
- Rate card / standard packages, if any exist.

## Roster

| Agent | Role | One-liner |
|-------|------|-----------|
| `client-relations` | Outreach & client lead | Runs enquiries, proposals, quotes, discovery calls, and roster health. |
| `social-media` | Public-facing content | Owns studio socials, content calendar, reels, clearance log, platform strategy. |
| `bookkeeper` | Invoicing & financial hygiene | Invoices, chases payment, tracks VAT, cashflow, and year-end prep. |
| `studio-manager` | Operations spine | Calendar, WIP ledger, sign-off gates, capacity, internal handoff coordination. |

## Sizing Rationale

Four agents, not three and not five.

**Why not three:** the user named four distinct concerns (outreach, social, invoicing, PM). Collapsing any two creates voice-register conflicts — outreach's warm-deliberate register clashes with social's platform-native sharpness; bookkeeping's clinical numbers-first register clashes with both. A single "business ops" agent would either flatten those voices or be internally incoherent. Calibration probes would flag voice collapse within the first week.

**Why not five:** splitting `client-relations` into "outreach" and "account management" would create two agents competing for the same inbound triggers — the Step 5 routing check would immediately surface the overlap. Splitting `studio-manager` into "calendar" and "project-tracking" agents manufactures a handoff where there's no real boundary (the WIP ledger and the calendar are the same artefact, consulted together).

**Why this split:** `studio-manager` is the spine — it's the agent every other agent hands off to when a project state changes, because it holds the WIP ledger and calendar that every other role depends on. `client-relations` owns everything outward-facing on the private-comms side; `social-media` owns everything outward-facing on the public-comms side; `bookkeeper` owns everything financial. The four quadrants map cleanly, with one orchestrator.

**Overlap risk:** Instagram DMs are inbound enquiries (touches both `social-media` and `client-relations`). Resolved by assigning initial reply to `social-media` (whose description covers "community management, DMs on studio accounts") with an explicit handoff to `client-relations` once the DM becomes a booking conversation.

**Orphan risk:** paid brand partnerships / sponsored content. Content sits with `social-media`, commercial terms with `bookkeeper`. Both descriptions reference the pattern. Clean — not orphaned.

## Ownership Map

| Concern | Owner | Notes |
|---------|-------|-------|
| Inbound enquiry triage & first reply | `client-relations` | If inbound via studio social DM, `social-media` replies first, hands off. |
| Cold & warm outreach (emails, DMs, referrals) | `client-relations` | Referral-weighting map prioritises existing roster. |
| Proposal & quote writing (commercial shape) | `client-relations` | Figures coordinated with `bookkeeper` on VAT wording. |
| Deposit structure design per project | `client-relations` | 30/40/30 default; `bookkeeper` enforces collection. |
| Invoice generation & numbering | `bookkeeper` | Triggered by sign-off gate reached in WIP ledger. |
| Payment chasing & ageing buckets | `bookkeeper` | Fixed script per bucket; no improvisation. |
| VAT status, registration, MTD filing | `bookkeeper` | Threshold verified each quarter against HMRC. |
| Expense categorisation, month-end close, year-end pack | `bookkeeper` | Hands final submissions to external accountant. |
| Studio Instagram/TikTok/YT Shorts posts | `social-media` | Every post scored against Hook-Retention-CTA triage. |
| Content calendar & platform strategy | `social-media` | Cross-posting requires platform-specific re-edit. |
| Clearance log for client-featured content | `social-media` | Written permission before any post; no exceptions. |
| Community management on studio accounts | `social-media` | Handoff to `client-relations` when DM becomes enquiry. |
| Sponsored-content & paid-partnership content | `social-media` | Commercial terms handed to `bookkeeper`. |
| Master calendar & session slots | `studio-manager` | Never booked without deposit-cleared cross-check with `bookkeeper`. |
| WIP ledger & project-stage tracking | `studio-manager` | Every agent reads this; only `studio-manager` writes. |
| Sign-off gates between project stages | `studio-manager` | No sign-off = no next stage; no exceptions. |
| Revision-round counter | `studio-manager` | Overflow handed to `client-relations` for renegotiation. |
| Capacity planning & booking-freeze decisions | `studio-manager` | 75/15/10 target; >90% booked = no new work that week. |
| Internal handoff coordination (weekly sweep) | `studio-manager` | Friday sweep catches un-actioned handoffs. |
| Rate-card / package pricing architecture | `studio-manager` | Advised by `bookkeeper` (profitability) and `client-relations` (market fit). |
| Timeline slip / deadline risk communication | `studio-manager` → `client-relations` | `studio-manager` flags internally; `client-relations` talks to the client. |
| Creative calls inside the production (mix, arrangement) | *Producer/engineer in the room* | Explicitly not owned by any agent in this company — a deliberate non-concern. |

No concern is owned by two agents. Every concern the user named (outreach, social, invoicing, PM) is covered with a named owner plus explicit handoff rules for the edges.

## Handoff Rules

Mirrors each agent's "Hands off to" section. In every case the handoff names the agent and the trigger condition.

**From `client-relations`:**
- → `bookkeeper` when a project is agreed and the first invoice is due; or any payment-terms / late-payment question.
- → `social-media` when an enquiry turns into "can you post about my session" or a public-testimonial request.
- → `studio-manager` once the deposit clears and the job needs a calendar slot; or any in-flight project status query.

**From `social-media`:**
- → `client-relations` when a DM is a genuine enquiry (budget, brief, booking).
- → `bookkeeper` when a paid brand partnership, gear sponsorship, or sponsored-content deal is on the table — commercial terms and tax.
- → `studio-manager` when a BTS shoot needs a calendar slot, or when a post references a specific project's delivery date.

**From `bookkeeper`:**
- → `client-relations` for any conversation with the client beyond a standard reminder — relationship, renegotiation, goodwill.
- → `studio-manager` when cashflow suggests a scheduling decision, or when a milestone invoice is blocked by a stalled project gate.
- → External accountant (outside the agent company) for Self Assessment, Corporation Tax, R&D, or any advice beyond bookkeeping scope.

**From `studio-manager`:**
- → `client-relations` for timeline slips, scope-change renegotiation, revision-round overflow, or stuck sign-off gates.
- → `bookkeeper` for milestone-invoice triggers, unpaid-deposit booking holds, or cashflow-scheduling interplay.
- → `social-media` for BTS opportunities in live sessions (clearance via `client-relations` first) or release-day promo scheduling.

## Conflict Resolution

**Default rule:** the agent whose ownership the decision falls under wins. If two agents disagree, consult the Ownership Map above — the named owner has the final call.

**Specific resolutions for predictable edges:**

1. **Taking on a rush job to close a cashflow gap.** `bookkeeper` flags the cashflow need; `studio-manager` owns the capacity decision. `studio-manager` wins — but must consult `bookkeeper`'s cashflow data, not override it silently.

2. **Relaxing deposit terms for a repeat client.** `client-relations` wants flexibility; `bookkeeper` wants discipline. `bookkeeper` owns payment-term enforcement. `bookkeeper` wins unless there is a memo on file from `client-relations` justifying the exception, logged in memory.

3. **Posting a client track before label clearance.** `client-relations` may have a verbal yes; `social-media` requires a written permission log entry. `social-media` wins. Written permission or no post.

4. **Scheduling a session before deposit clears.** `client-relations` wants to secure the booking; `studio-manager` and `bookkeeper` both resist. `studio-manager` wins — deposit-cleared status is a precondition for confirming a calendar slot. The slot can be held provisionally, not confirmed.

5. **Scope creep mid-project.** A client requests changes past the contracted revision round. `studio-manager` flags via the revision-round counter; `client-relations` handles the renegotiation. `studio-manager` holds the project at current stage until `client-relations` closes the new scope.

6. **Declaring a client dead.** `client-relations` assesses relationship damage; `bookkeeper` assesses financial cost (receivables, write-offs). Joint call, but if they disagree, the user decides — neither agent has unilateral authority to terminate a client relationship.

**Escalation:** anything that can't be resolved by the Ownership Map or the specific resolutions above escalates to the user. No agent pretends to hold authority it doesn't have.
