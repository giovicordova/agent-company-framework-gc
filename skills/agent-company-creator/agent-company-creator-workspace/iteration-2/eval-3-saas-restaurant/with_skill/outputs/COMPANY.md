# COMPANY.md — Restaurant SaaS Agent Company

## Sandbox path note

This company was built into an eval sandbox. Agent files are at `agents/` under the sandbox root; in production they relocate to `.claude/agents/` at the project root (the `.claude/` prefix was silently stripped by this sandbox, so files were written to the bare `agents/` path — the canonical location is `.claude/agents/`). All frontmatter declares `memory: project` so the relocation is lossless: Claude Code will resolve persistent memory at `.claude/agent-memory/{name}/` once the files sit under `.claude/agents/`.

## Roster

| Name | Role | One-liner |
|---|---|---|
| `product-lead` | Head of product | Roadmap, prioritisation, pricing, ICP, north-star metric. |
| `frontend-designer` | Senior design-engineer | Product UI, Tailwind tokens, accessibility, component library in `src/app/`. |
| `marketing-writer` | B2B content strategist | Marketing-site copy, positioning voice, launch and blog content. |
| `dx-engineer` | Staff DX engineer | CI, testing, inner-loop performance, repo structure, dev tooling. |
| `local-seo-specialist` | Local-search domain expert | GBP, review platforms, schema.org, review-response SLA, local-pack diagnostics. |
| `supabase-architect` | Principal backend architect | Postgres schema, RLS, migrations, auth, realtime, data-residency. |

## Sizing rationale

Six agents is the right number and the user's instinct was correct, but the decomposition is not the obvious one. The naive split of the four concern areas the user named (product strategy, frontend design, marketing content, developer experience) would leave two glaring orphans in a product whose *subject matter is local-search and reviews* and whose *stated infrastructure is Supabase*. A four-agent team would force product-lead to bluff on GBP ranking factors and force dx-engineer to adjudicate RLS policy design — both are recipes for silently wrong answers. Splitting out `local-seo-specialist` keeps the product honest about what a local-SEO feature can and cannot do, and splitting out `supabase-architect` puts a principal-level owner on the data surface that doubles as the security surface. Four would have been under-specialised; eight would have introduced overlap between product-lead and a notional "growth" agent, and between frontend-designer and a notional "design-system" agent, both of which fragment routing without adding coverage. Six covers every concern named by the user and every orphan implied by the stack, with no double-ownership.

## Assumptions

No live user was available for follow-up questions during this build. Stated assumptions, to be corrected by the user on first engagement:

- **Stage:** early / pre-launch. The ICP and pricing are still being validated; the team is sized for discovery-through-early-growth, not scale-up.
- **Market:** UK-first, British English default, GBP pricing with VAT position stated on every customer-facing figure. Multi-region is a later bet.
- **Stack:** Next.js App Router (`src/app/`), Tailwind v3+ (`tailwind.config.ts`), Supabase (Postgres + Auth + Storage + Realtime + Edge Functions). Node and pnpm versions pinned in `package.json` engines.
- **Team shape:** solo founder or small founding team using the agent company as force-multiplier, not a large product org.
- **Review platforms in scope:** Google Business Profile (primary), TripAdvisor, Yelp, TrustPilot. Others deferred.
- **Compliance surface:** UK GDPR + EU GDPR (Article 5, 17), nothing beyond unless user introduces PCI or a licensed-trade regulator.

## Ownership map

Every concern either raised by the user or implied by the project has exactly one owner.

| Concern | Owner | Notes |
|---|---|---|
| Product roadmap and prioritisation | `product-lead` | Uses JTBD clustering and the north-star activation funnel. |
| Pricing tier structure | `product-lead` | `marketing-writer` writes the pricing page once tiers are set. |
| ICP definition and willingness-to-pay | `product-lead` | Three-interview rule before any paid-tier feature ships. |
| Product UI components and layouts | `frontend-designer` | Lives under `src/app/`. Mobile-first; 44px tap targets minimum. |
| Tailwind tokens and theme | `frontend-designer` | All colour, spacing, type, radii in `tailwind.config.ts`. |
| Accessibility (WCAG 2.2 AA) | `frontend-designer` | Blocks ship on failure; `dx-engineer` provides axe automation. |
| Core Web Vitals budget on product surface | `frontend-designer` | LCP 2.5s, CLS 0.1, INP 200ms on mid-tier Android. |
| Marketing-site copy (home, features, pricing, blog) | `marketing-writer` | PAS structure, jargon kill-list, proof-over-promise. |
| Tone of voice and positioning language | `marketing-writer` | British English; voice guidelines codified. |
| In-product microcopy (strings, errors, empty states) | `frontend-designer` | Not `marketing-writer`. |
| Local-SEO strategy (product feature + marketing site) | `local-seo-specialist` | Proximity/Prominence/Relevance framework. |
| Google Business Profile optimisation | `local-seo-specialist` | Policy checked against current GBP Help. |
| Review-response SLA and tone | `local-seo-specialist` | 4h / 24h / 72h matrix; de-escalation pattern. |
| Schema.org markup specification | `local-seo-specialist` | Validated with Google's Rich Results Test before ship. |
| Schema.org on-page implementation | `frontend-designer` | Spec from `local-seo-specialist`; code from `frontend-designer`. |
| Postgres schema and migrations | `supabase-architect` | Lives under `supabase/migrations/`. |
| Row-level security policies | `supabase-architect` | RLS enabled at table creation; tests required. |
| Supabase Auth, Realtime, Edge Functions | `supabase-architect` | Realtime channels scoped by tenant. |
| Data residency and retention | `supabase-architect` | GDPR Article 5 and 17 map. Marketing copy pulls from this map. |
| GDPR compliance factual claims | `supabase-architect` | `marketing-writer` writes the customer-facing copy from these facts. |
| CI/CD and pre-commit hooks | `dx-engineer` | Lockfile-pinned; engines field authoritative. |
| Testing strategy (unit / integration / e2e) | `dx-engineer` | Risk-weighted pyramid; Vitest + Playwright default. |
| Inner-loop performance (dev server, HMR, build) | `dx-engineer` | HMR <300ms, full unit <30s, type-check <15s. |
| Repo structure and workspace boundaries | `dx-engineer` | Respects existing `src/app/`, `tailwind.config.ts`, `supabase/`. |
| Storybook + visual regression tooling | `dx-engineer` | Tool owner; `frontend-designer` owns story conventions. |
| Deployment workflows and preview envs | `dx-engineer` | Preview-to-prod env parity enforced. |

No concern is owned by two agents. `frontend-designer` and `local-seo-specialist` share the schema.org edge cleanly (spec vs implementation); `supabase-architect` and `marketing-writer` share the GDPR edge cleanly (facts vs copy).

## Handoff rules

Every handoff below mirrors the `Hands off to` section in each agent's `.md`. Cross-checked; no drift.

**From `product-lead`:**
- To `frontend-designer` — any question about component design, interaction, visual hierarchy in the product.
- To `marketing-writer` — homepage copy, launch content, pricing-page copy.
- To `supabase-architect` — schema changes, RLS, realtime scoping, edge functions.
- To `dx-engineer` — CI, testing strategy, dev environment.
- To `local-seo-specialist` — GBP, review-platform strategy, schema.org, local ranking.

**From `frontend-designer`:**
- To `marketing-writer` — marketing-site visuals or copy.
- To `supabase-architect` — data-shape questions that drive UI.
- To `product-lead` — design requests that are really scope/prioritisation.
- To `dx-engineer` — Storybook, visual regression, component-test infrastructure.
- To `local-seo-specialist` — review widget or schema.org markup specification.

**From `marketing-writer`:**
- To `frontend-designer` — layout, components, and all in-product microcopy.
- To `local-seo-specialist` — keyword targeting, schema, GBP.
- To `product-lead` — pricing-tier design (vs page copy).
- To `supabase-architect` — data-security or compliance factual claims.
- To `dx-engineer` — developer docs or changelog content.

**From `dx-engineer`:**
- To `supabase-architect` — schema design, RLS authoring, migration content, query performance.
- To `frontend-designer` — Storybook conventions, component-test patterns.
- To `product-lead` — scope questions disguised as tooling.
- To `marketing-writer` — user-facing docs on the marketing site.

**From `local-seo-specialist`:**
- To `marketing-writer` — customer-facing copy, even on SEO-targeted pages.
- To `frontend-designer` — review-triage UI, GBP-sync UI, on-page schema implementation.
- To `supabase-architect` — review data model, GBP sync state, ranking history storage.
- To `product-lead` — SEO-feature prioritisation, pricing, platform-integration scoping.
- To `dx-engineer` — automated schema validation in CI.

**From `supabase-architect`:**
- To `frontend-designer` — query-result rendering, error surfacing in UI.
- To `marketing-writer` — customer-facing security, GDPR, uptime copy (I supply facts).
- To `dx-engineer` — migration tooling, CI schema checks, local Supabase setup.
- To `product-lead` — schema questions that are really scope decisions.
- To `local-seo-specialist` — the review data shape they consume.

## Conflict resolution

One row per real boundary edge. Default tie-breaker: the agent whose ownership the decision falls under wins.

| Boundary | Agent A | Agent B | Resolution |
|---|---|---|---|
| In-product microcopy (errors, empty states, tooltips) | `marketing-writer` | `frontend-designer` | `frontend-designer` wins — in-product strings live with the component, tone reviewed by `marketing-writer` on request but not approved. |
| Pricing page content | `product-lead` | `marketing-writer` | `product-lead` owns the tier structure and the numbers; `marketing-writer` owns the copy that sells them. Page does not ship without both sign-offs. |
| Marketing-site security/GDPR claims | `marketing-writer` | `supabase-architect` | `supabase-architect` supplies the verified facts (residency, retention, backups, uptime); `marketing-writer` writes the copy. No security claim on the site without an architect-approved fact line. |
| Schema.org markup (Restaurant, Menu, Review) | `local-seo-specialist` | `frontend-designer` | `local-seo-specialist` authors the JSON-LD spec and validates via Rich Results Test; `frontend-designer` implements it on-page. |
| Review-triage product UI | `frontend-designer` | `local-seo-specialist` | `frontend-designer` owns the UI; `local-seo-specialist` provides the response-SLA rules and de-escalation pattern the UI must surface. |
| Tailwind tokens used by both product and marketing | `frontend-designer` | `marketing-writer` | `frontend-designer` owns the token system in `tailwind.config.ts`. Marketing consumes; does not add tokens. |
| Storybook conventions and component-test patterns | `dx-engineer` | `frontend-designer` | `dx-engineer` owns the tooling; `frontend-designer` owns the conventions (naming, story structure, a11y coverage). |
| Data-model changes that drive UI shape | `supabase-architect` | `frontend-designer` | `supabase-architect` owns the schema; collaborates on the exposed shape but does not defer to UI convenience over integrity. |
| Feature scope expressed as "we need a schema change" | `supabase-architect` | `product-lead` | `product-lead` wins — scope is product's call; `supabase-architect` flags cost and risk but does not gatekeep feature decisions. |
| Review-platform integration (which platforms, which tiers) | `product-lead` | `local-seo-specialist` | `product-lead` wins on prioritisation and commercial model; `local-seo-specialist` owns the platform-policy and API-access feasibility verdict — veto if policy blocks it. |
| Preview-deploy envs diverging from production | `dx-engineer` | `supabase-architect` | `dx-engineer` owns parity; `supabase-architect` defines which Supabase config must match (RLS, extensions, auth providers). |
| Developer docs vs marketing docs | `dx-engineer` | `marketing-writer` | `dx-engineer` owns anything a developer reads to get work done (`README.md`, `docs/`, changelog). `marketing-writer` owns anything on the marketing site. |

## Cross-check

Every concern in the ownership map is named in exactly one agent's `Owns` section. Every handoff in the rules table is mirrored in both agents' `Hands off to` sections. No orphans, no double-owners.
