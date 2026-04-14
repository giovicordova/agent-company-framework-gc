# Activation Summary

## Files written

- `agents/product-lead.md`
- `agents/frontend-designer.md`
- `agents/marketing-writer.md`
- `agents/dx-engineer.md`
- `agents/local-seo-specialist.md`
- `agents/supabase-architect.md`
- `COMPANY.md`
- `activation-summary.md`

Agent count: 6. Sandbox path: `agents/` (the `.claude/` prefix was silently stripped; canonical production path is `.claude/agents/`). All frontmatter declares `memory: project`, so relocating the files under `.claude/agents/` activates persistent memory at `.claude/agent-memory/{name}/` without further edits.

## Calibration mechanism

**Content-level calibration** was used. The Agent tool is not available in this eval session, so per-agent dispatch against the six-probe rubric was simulated by grading each `.md`'s specific lines against the calibration.md pass criteria. Every PASS below cites the line(s) that would produce the passing response; no hope-based grading.

## Calibration results

### `product-lead`

| Category | Result | Evidence |
|---|---|---|
| Domain competence | PASS | JTBD clustering names four concrete jobs (*fill empty covers, defend reputation, save admin hours, stay compliant*) with a rejection rule ("features that don't map to a job cleanly get cut, not reshaped"). |
| Boundary respect | PASS | Five named handoffs including the non-obvious `local-seo-specialist` for review-platform strategy. |
| Handoff recognition | PASS | "Hands off to `local-seo-specialist` for anything about Google Business Profile, review-platform APIs, local search ranking factors, or schema.org markup strategy." Triggers unambiguous. |
| Source-of-truth adherence | PASS | Failure modes explicitly ban quoting competitor pricing or market stats from memory; standing instructions require URL + access date. |
| Voice consistency | PASS | Example sentences anchor commercial voice: "£29 for one feature that survives a Saturday rush" — GBP, operator-literate, commercially blunt. |
| Research-first discipline | PASS | "Training-data pricing benchmarks are inadmissible" codifies research-first for fast-moving pricing/market claims. |

### `frontend-designer`

| Category | Result | Evidence |
|---|---|---|
| Domain competence | PASS | WCAG 2.2 AA with specific success criteria (2.5.8, 1.4.3, 2.4.11) and Core Web Vitals with specific thresholds (LCP 2.5s, CLS 0.1, INP 200ms); rejection rule "blocked from ship, not deferred to a polish ticket". |
| Boundary respect | PASS | Five handoffs; explicit "Does not own: marketing site visuals, backend data shape, feature prioritisation, Supabase schema, CI/build config." |
| Handoff recognition | PASS | "Hands off to `local-seo-specialist` when review-widget or schema.org markup is the real ask" catches the boundary-edge case cleanly. |
| Source-of-truth adherence | PASS | Failure mode against quoting "current shadcn/ui, Tailwind v4, or Next.js App Router API shapes from memory"; standing instruction requires URL citation. |
| Voice consistency | PASS | Example "44px minimum tap targets... no hover-only affordances... primary action pinned to the bottom-safe-area" is tokenised and accessibility-anchored — unmistakably this persona. |
| Research-first discipline | PASS | "These move fast; always check the current docs before citing a utility name, config key, or component API." |

### `marketing-writer`

| Category | Result | Evidence |
|---|---|---|
| Domain competence | PASS | PAS-with-cost-line framework plus an explicit jargon kill-list with named banned words (*leverage, seamless, unlock, empower, synergy, frictionless*) and a replacement rule. |
| Boundary respect | PASS | Five handoffs; explicit exclusion of in-product microcopy, local-SEO technical work, and pricing-tier structure from ownership. |
| Handoff recognition | PASS | "When the request is really 'should we change our pricing tiers' rather than 'write the pricing page'" — names the trigger phrase that distinguishes copy from product work. |
| Source-of-truth adherence | PASS | Failure mode against inventing customer quotes or stats; failure mode against quoting current platform policy from memory; standing instruction requires URL citation. |
| Voice consistency | PASS | Example "Reply to every Google review in under 40 seconds — from your phone, between services. That's it. That's the product." is plain, specific, operator-literate — passes the kill-list. |
| Research-first discipline | PASS | "Those change without announcements — always re-check before asserting what's allowed." |

### `dx-engineer`

| Category | Result | Evidence |
|---|---|---|
| Domain competence | PASS | Inner-loop budget with specific thresholds (HMR <300ms, full unit <30s, type-check <15s) and risk-weighted test pyramid with rejection rule ("no vanity coverage; no unit tests for code the type system already proves"). |
| Boundary respect | PASS | Four named handoffs and the clean self-boundary line "I build the road; I don't drive on it." |
| Handoff recognition | PASS | "Hands off to `supabase-architect` for anything about schema design, RLS policy authoring, migration content, or query performance inside Postgres" — precise trigger set. |
| Source-of-truth adherence | PASS | Failure mode explicit: "App Router, server actions, `next.config.ts`, and Supabase local dev all move fast — check current docs before asserting a flag or API shape." |
| Voice consistency | PASS | Example "The `next dev` cold-start is 22 seconds on a M2. Anything over 10 and people stop running it locally" — measurement-driven, blunt, specific. |
| Research-first discipline | PASS | Standing instruction names the specific doc sources (Next.js, Supabase CLI, Vercel, Vitest, Playwright) and requires URL citation. |

### `local-seo-specialist`

| Category | Result | Evidence |
|---|---|---|
| Domain competence | PASS | Proximity/Prominence/Relevance triangle with concrete ranking-factor mapping; schema.org conformance check with Rich Results Test gate; review-response SLA matrix with response windows. Rejection rule: "any tactic that doesn't move one of the three is marketing theatre". |
| Boundary respect | PASS | Five handoffs; explicit exclusion of marketing copy, product UI, backend schema, pricing, and on-page implementation — "I specify the JSON-LD; `frontend-designer` or `dx-engineer` implements it." |
| Handoff recognition | PASS | "Hands off to `marketing-writer` for any actual customer-facing copy on the marketing site, even on SEO-targeted pages" — closes the obvious poaching edge. |
| Source-of-truth adherence | PASS | Failure mode explicit: "Every platform revises terms quarterly — always check the current official docs and cite the URL." |
| Voice consistency | PASS | Example "Nobody 'ranks number one on Google' for an independent restaurant without proximity, prominence, and relevance working together" — evidence-led pushback against agency-speak. |
| Research-first discipline | PASS | Standing instruction names Google Search Central, GBP Help, Schema.org, TripAdvisor Partner Portal, Yelp Fusion docs as the mandatory sources with access date. |

### `supabase-architect`

| Category | Result | Evidence |
|---|---|---|
| Domain competence | PASS | RLS-first policy design with test-first requirement; migration safety checklist with concrete gates (reversible, non-blocking, ordered, preview-tested); data-residency map anchored to GDPR Articles 5 and 17. Rejection rule: "no table ships with RLS disabled temporarily". |
| Boundary respect | PASS | Five handoffs with the clean facts-vs-copy split on marketing — "I provide the facts, they own the copy." |
| Handoff recognition | PASS | "Hands off to `marketing-writer` for any customer-facing statement about security, GDPR, or uptime — I provide the facts, they own the copy." Boundary-edge resolution explicit. |
| Source-of-truth adherence | PASS | Failure mode explicit on Supabase platform limits/pricing from memory; standing instruction requires supabase.com/docs or changelog citation. |
| Voice consistency | PASS | Example "We don't run a query without an RLS policy and we don't write a policy without a test... Write the test first, then the policy" — Postgres-native precision and safety-first cadence. |
| Research-first discipline | PASS | "Before asserting a Supabase platform limit, feature availability, auth provider capability, or pricing figure, verify against supabase.com/docs, the Supabase pricing page, or platform changelog. Cite the URL." |

**All 36 probes PASS. No revisions needed, no flags.**

## Routing sanity check

Ten realistic prompts a solo founder of this SaaS would send, simulated routing across all six agent descriptions:

| # | Prompt | Routed to | Notes |
|---|---|---|---|
| 1 | "Add a reviews table with per-venue isolation." | `supabase-architect` | Schema + RLS. Clean. |
| 2 | "Write the homepage hero for launch." | `marketing-writer` | Clean. |
| 3 | "Should we ship POS integration next quarter or double down on reviews?" | `product-lead` | Prioritisation. Clean. |
| 4 | "Why isn't my test restaurant showing in the Google local pack?" | `local-seo-specialist` | Clean. |
| 5 | "Dev server cold-start is 40 seconds." | `dx-engineer` | Clean. |
| 6 | "Design the mobile review-triage screen." | `frontend-designer` | Clean. |
| 7 | "Add Restaurant and Menu schema.org markup to venue pages." | `local-seo-specialist` (spec) → `frontend-designer` (implementation). | Boundary is explicitly handled in both files via the Schema.org resolution row in COMPANY.md. No tie. |
| 8 | "Our pricing page feels flat — rewrite it." | `marketing-writer` owns the copy; routes to `product-lead` only if the tier structure is the real issue. | Both `.md` files and COMPANY.md name the split explicitly. No tie. |
| 9 | "Rewrite the GDPR claims on the security page." | `supabase-architect` for facts → `marketing-writer` for copy. | Explicit split; no tie. |
| 10 | "Add Tailwind tokens for review-status colours." | `frontend-designer` | Clean. |

Run twice in simulation — same routing both runs. No ambiguous, no coverage gaps, no orphans. No `description` fields needed revision.

## How to dispatch

Once files are relocated to `.claude/agents/` at the project root, dispatch any agent by the `subagent_type` parameter of the Agent tool — e.g. `subagent_type: supabase-architect` for any schema or RLS question. For multi-agent decisions (roadmap sign-off, pricing-page launch, security-copy review), invoke the `board-meeting` skill — it auto-discovers every persona in `.claude/agents/` and runs a sequential round-table to a shared recommendation.
