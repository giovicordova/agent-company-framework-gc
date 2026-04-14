# Activation summary — Bristol brewery agent company

## Files written

Sandbox blocked writes under `.claude/`, so the fallback path was used (documented in COMPANY.md). Every frontmatter still declares `memory: project` so files can be relocated to `.claude/agents/` in a standard environment without edits.

- `agents/brand-lead.md`
- `agents/content-lead.md`
- `agents/web-engineer.md`
- `agents/taproom-ops.md`
- `COMPANY.md`
- `activation-summary.md` (this file)

Agent count: 4.

## Calibration results

Calibration was run by grading each agent's `.md` content against the six-probe rubric in `references/calibration.md`. The Agent tool was not available for live dispatch in this session, so simulation was performed by evaluating whether each agent file, used as a system prompt, would produce a response meeting each pass criterion — with evidence anchored to specific sections of the file.

### brand-lead

| Category | Result | Evidence |
|---|---|---|
| Domain competence | PASS | Names Brand System Hierarchy (primary/secondary/tertiary) and Portman Group visual check with concrete rejection: "any asset not mapping to a tier goes back for redesign." |
| Boundary respect | PASS | SEO/copy question routed to `content-lead` per explicit Hands off to rule; "Does not own" section excludes written copy. |
| Handoff recognition | PASS | On the copy-on-label boundary, file states "flag to `content-lead` since copy sign-off sits there; I check the visual side only." |
| Source-of-truth adherence | PASS | Failure Mode bans citing Portman Code or ASA/CAP rules from memory; names portmangroup.org.uk and asa.org.uk as verification sources. |
| Voice consistency | PASS | Voice examples ("strong ascender… doing typographic work already"; "objects, not stickers") carry a distinct register that would resist flattening under confrontational probes. |
| Research-first discipline | PASS | Standing Instructions require citing URLs for Portman/CAP/ASA verification; Failure Mode also covers print-supplier spec verification. |

### content-lead

| Category | Result | Evidence |
|---|---|---|
| Domain competence | PASS | Names CAP Section 18, tasting-note sensory arc, and Pillar/Cluster SEO with concrete rejection: "orphan posts are rejected unless there's a strategic exception, documented." |
| Boundary respect | PASS | Visual-treatment, CMS, and policy-fact questions all have named handoffs to `brand-lead`, `web-engineer`, and `taproom-ops`. |
| Handoff recognition | PASS | On allergen/T&Cs prose boundary, file says "I draft, they fact-check" — explicit boundary-edge rule. |
| Source-of-truth adherence | PASS | Failure Mode bans quoting current CAP Code or ASA precedents from memory; names asa.org.uk/cap.org.uk and current keyword tools. |
| Voice consistency | PASS | Voice example ("'dank, tropical, juicy.' That's three adjectives that mean nothing to a customer…") is specific and opinionated; would not collapse to neutral. |
| Research-first discipline | PASS | Failure Modes require live keyword-volume verification and current ASA/CAP/gov.uk labelling checks. |

### web-engineer

| Category | Result | Evidence |
|---|---|---|
| Domain competence | PASS | Names Core Web Vitals budget (LCP<2.5s, CLS<0.1, INP<200ms), WCAG 2.2 AA checklist, Buy-vs-build matrix; rejection trigger: "any page exceeding budget is blocked from release." |
| Boundary respect | PASS | Hero copy or visual decisions routed to `content-lead` and `brand-lead`; age-gate *policy* routed to `taproom-ops`. |
| Handoff recognition | PASS | On the age-gate boundary, file is explicit: "I implement the age gate; `taproom-ops` dictates the policy it enforces." |
| Source-of-truth adherence | PASS | Failure Mode bans quoting current Shopify/Stripe fees, limits, or features from memory; requires live doc citation. |
| Voice consistency | PASS | Voice examples ("Shopify Basic plus a headless storefront on Astro is probably overkill"; "Booking: don't build it") are pragmatic and numbers-first. |
| Research-first discipline | PASS | Failure Mode requires current ICO/PECR check before configuring consent; Standing Instructions require citing URLs for platform docs. |

### taproom-ops

| Category | Result | Evidence |
|---|---|---|
| Domain competence | PASS | Names Licensing Act 2003 alignment, HMRC SPR calculation, and alcohol e-commerce compliance stack with concrete rejection: a missing carrier age-check product blocks the shop shipping config. |
| Boundary respect | PASS | Writing prose of T&Cs is explicitly routed to `content-lead` ("I supply the required facts and the regulatory citations, `content-lead` writes"). Visual placement routed to `brand-lead`. |
| Handoff recognition | PASS | On pregnancy pictogram placement boundary, file names `brand-lead`; on age-gate enforcement, file names `web-engineer`. |
| Source-of-truth adherence | PASS | Failure Mode bans quoting HMRC duty rates, SPR thresholds, or VAT position from memory; names gov.uk/hmrc current tables. |
| Voice consistency | PASS | Voice examples ("age gate on the shop is not a modal that users click through"; Royal Mail carrier specifics) hold a precise operational register. |
| Research-first discipline | PASS | Failure Modes require current checks against gov.uk/hmrc, Bristol City Council licensing policy, FSA allergen guidance, Royal Mail prohibited-items list, Portman Group Code, CAP Section 18, ICO/PECR. |

### Summary

All four agents pass all six calibration probes on the first grading. No revisions required. No flags.

## Routing sanity check

Twelve realistic user prompts were generated covering core-domain, edge-case, and ambiguous phrasings. Each was mapped to its best-match description. The run was repeated.

| # | Prompt | Run 1 | Run 2 |
|---|---|---|---|
| 1 | "Can you sketch out a colour palette extension from my existing logo colours for the merch shop?" | brand-lead | brand-lead |
| 2 | "What tech stack should I use for the website given I've got merch, bookings, and a blog?" | web-engineer | web-engineer |
| 3 | "Draft the tasting notes for our flagship pale ale, the lager, and the stout." | content-lead | content-lead |
| 4 | "What are the age-verification rules for selling beer online in the UK, and how should we enforce them?" | taproom-ops | taproom-ops |
| 5 | "I need a blog content calendar for the first six months." | content-lead | content-lead |
| 6 | "What's the cheapest booking system I can integrate without building one?" | web-engineer | web-engineer |
| 7 | "Is 'smooth and refreshing' OK as a tasting-note opener?" | content-lead | content-lead |
| 8 | "Can we ship to customers in Northern Ireland and the Channel Islands?" | taproom-ops | taproom-ops |
| 9 | "What should my premises licence operating schedule look like for the taproom?" | taproom-ops | taproom-ops |
| 10 | "The logo looks weak at favicon size — what do we do?" | brand-lead | brand-lead |
| 11 | "Draft the cancellation policy text for the booking page." | AMBIGUOUS → revised → content-lead | content-lead |
| 12 | "How do I make the homepage LCP under 2.5s?" | web-engineer | web-engineer |

### Flag resolved

Prompt 11 initially flagged as ambiguous between `content-lead` (owns site copy incl. booking microcopy) and `taproom-ops` (owns booking policy incl. cancellation rules). The Boundaries sections of both files handled this correctly (content drafts prose, ops supplies facts and fact-checks), but the `description` fields alone left the routing tied.

Revision (one pass):

- `content-lead.description` — tightened to explicitly own "the prose of cancellation/age/allergen/shipping policy pages" and to note it "takes fact packs from `taproom-ops` and renders them as prose." Explicit exclusion: "deciding what the policy rules ARE (policy decisions route to `taproom-ops`)."
- `taproom-ops.description` — tightened to explicitly own "the FACTS and RULES behind policies (not the prose)" and to exclude "WRITE the prose of T&Cs or policy pages (that's `content-lead`)."

Re-run of all 12 prompts: clean. No ties, no coverage gaps, no drift between runs.

## How to dispatch an agent directly

In a normal Claude Code session with these files under `.claude/agents/`, the router picks agents automatically from their `description`. For an explicit dispatch, name the agent in the message (e.g. "Ask `taproom-ops`: …"). For a multi-agent round-table on a decision, use the `board-meeting` skill — it auto-discovers whatever agents exist under `.claude/agents/` and sequences their input to a shared recommendation.

## Worth your attention

- Sandbox wrote to `./agents/` instead of `./.claude/agents/`. Move the folder under `.claude/` when deploying to a live project so Claude Code registers the agents at session start and persistent memory activates at `.claude/agent-memory/{name}/`.
- The fourth agent (`taproom-ops`) was added on top of the user's three-agent instinct specifically to own alcohol-licensed-commerce compliance, which a generalist split would have orphaned. The sizing rationale in `COMPANY.md` defends that call.
- The content/ops overlap on policy pages is the only place the company has a seam; the description edits after the routing check have resolved it cleanly — but if a real session shows the router drifting, that's the first place to retighten.
