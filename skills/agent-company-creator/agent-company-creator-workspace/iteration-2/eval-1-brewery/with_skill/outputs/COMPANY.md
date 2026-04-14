# COMPANY.md — Bristol Craft Brewery Launch

An agent company of four specialists covering the visual brand, editorial and copy, web build and e-commerce, and commercial operations and compliance for a pre-launch Bristol craft brewery with a taproom, merch shop, booking system, and blog.

## Sandbox note

This sandbox blocked writes under `.claude/`, so agent files live at `./agents/` and calibration transcripts would live at `./agent-calibration/` instead of the canonical `.claude/agents/` and `.claude/agent-calibration/`. Every frontmatter still declares `memory: project` so that in a normal environment the files can be moved under `.claude/agents/` without edits and memory will activate at `.claude/agent-memory/{name}/`.

## Assumptions

No interactive user in this eval. Based on the brief, assumed:

- The brewery has a premises (taproom) in Bristol and is applying for / holds a premises licence under the Licensing Act 2003 with Bristol City Council.
- Launch range is a small number of core beers (around 4) plus rotating seasonals. Small Producer Relief is in scope.
- Merch is limited-SKU (glassware, apparel, print) rather than a full apparel line.
- Taproom is a single location; booking covers table reservations and possibly event tickets, not multi-venue.
- The existing logo and brand colours are a real seed — not a finished system; a brand system has to be built on top.
- The operator does not have a developer on retainer post-launch; stack choice must be maintainable by the operator.
- UK market for both taproom and online shop; international shipping not a launch priority.

## Roster

| Name | Role | One-liner |
|---|---|---|
| `brand-lead` | Senior brand designer | Owns the visual brand system — logo usage, colour, typography, imagery, labels, merch artwork. |
| `content-lead` | Senior editor and copywriter | Owns all customer-facing prose — web copy, product descriptions, tasting notes, blog, T&C prose, metadata. |
| `web-engineer` | Full-stack engineer | Owns tech stack, e-commerce config, booking integration, CMS, performance, accessibility implementation. |
| `taproom-ops` | Commercial ops and compliance lead | Owns licence, HMRC duty, age-verification policy, shipping rules, allergen rules, taproom SOPs — the *facts* behind policy, not the prose. |

## Sizing rationale

The user proposed three agents — design, content, web-dev — which is a natural first split but leaves a material concern orphaned: UK alcohol-licensed commerce compliance. A brewery launch carries the Licensing Act 2003 premises-licence burden, HMRC duty and Small Producer Relief, CAP/ASA/Portman Group oversight, FIC/FSA allergen rules, carrier restrictions on alcohol (Royal Mail won't carry it), PECR consent rules, and age-verification at both purchase and delivery. None of those sit cleanly with a designer, a copywriter, or a web engineer. Folding them into web-engineer turns that role into a generalist; folding them into content-lead confuses prose with policy; folding them into brand-lead makes no sense. Four agents — brand-lead, content-lead, web-engineer, taproom-ops — give each role one ownership axis and keep the compliance surface with a specialist who treats it as a working document rather than a referenced annex. Overlap risk: booking-page copy (addressed by the description edit after routing check — policy decision is `taproom-ops`, prose is `content-lead`). Orphan risk before the fourth agent existed: HMRC duty lines on product pages, carrier logic, premises licence conditions, age-verification policy. All four now owned. A fifth agent (e.g. a separate growth/paid agent) is not justified pre-launch — organic SEO is covered by `content-lead`; paid acquisition can be added post-launch when volume warrants.

## Ownership map

| Concern | Owner | Notes |
|---|---|---|
| Logo usage rules, lockups, clear-space | `brand-lead` | Primary/secondary/tertiary mark hierarchy. |
| Colour system (primary, secondary, functional) | `brand-lead` | Hex values + WCAG contrast pairings. |
| Typography hierarchy and pairings | `brand-lead` | Display + text + mono. |
| Photography and illustration direction | `brand-lead` | Mood board and shot list. |
| Label and packaging artwork | `brand-lead` | Visual side; content comes from `content-lead` + `taproom-ops`. |
| Merch visual design | `brand-lead` | Apparel, glassware, print. |
| Brand guidelines document | `brand-lead` | Single source of truth for visual system. |
| Site written copy (homepage, about, shop, booking, checkout) | `content-lead` | Prose only. |
| Product descriptions and tasting notes | `content-lead` | Aroma → Appearance → Flavour → Mouthfeel → Finish. |
| Blog editorial calendar and writing | `content-lead` | Pillar/cluster map. |
| SEO keyword strategy (organic) | `content-lead` | On-page and content strategy. |
| Metadata, titles, alt text | `content-lead` | |
| Newsletter copy | `content-lead` | |
| Prose of T&Cs, policy pages, age-gate text, allergen copy | `content-lead` | Takes fact packs from `taproom-ops`. |
| CAP/ASA compliance on written copy | `content-lead` | Writes inside Section 18. |
| Tech stack choice and hosting | `web-engineer` | |
| CMS selection and config | `web-engineer` | |
| E-commerce platform config (shop) | `web-engineer` | |
| Taproom booking system integration | `web-engineer` | Buy-vs-build default: buy. |
| Payment integration | `web-engineer` | |
| Age-gate technical enforcement | `web-engineer` | Policy from `taproom-ops`. |
| Schema markup, sitemap, robots | `web-engineer` | |
| Performance (Core Web Vitals) | `web-engineer` | LCP/CLS/INP budgets. |
| Accessibility implementation (WCAG 2.2 AA) | `web-engineer` | axe-core + manual pass. |
| Security headers, DNS, analytics, consent banner config | `web-engineer` | PECR check with `taproom-ops`. |
| Image pipeline and build/CI | `web-engineer` | |
| Premises licence (application, conditions, variations) | `taproom-ops` | Bristol City Council. |
| Taproom SOPs (opening, closing, incident, refusals, Challenge 25) | `taproom-ops` | |
| Booking policy (deposit, cancellation, no-show, dietary, access) — rules only | `taproom-ops` | Prose is `content-lead`. |
| Age-verification policy (taproom and online) | `taproom-ops` | Implementation is `web-engineer`. |
| Alcohol shipping policy (carriers, restricted destinations, delivery age check) | `taproom-ops` | |
| HMRC duty and Small Producer Relief | `taproom-ops` | Monthly rhythm. |
| VAT treatment (on-trade vs off-trade) | `taproom-ops` | |
| Allergen disclosure (FIC / PPDS / Natasha's Law adjacency) — rules | `taproom-ops` | Prose is `content-lead`. |
| Responsible-service training and Portman Group adherence (ops side) | `taproom-ops` | |
| CAP/ASA arbitration across teams | `taproom-ops` | Final call; `content-lead` and `brand-lead` execute. |
| Data retention and PECR policy | `taproom-ops` | Implementation by `web-engineer`. |

No concern owned by two agents. Every concern from the brief (e-commerce for merch, taproom booking, blog, existing logo+colours as seed, launching in Bristol) maps to an owner.

## Handoff rules

- **`brand-lead` → `content-lead`** when the ask is about written words (copy, blog direction, SEO, metadata, alcohol-advertising wording).
- **`brand-lead` → `web-engineer`** when the ask is about implementation (CSS, framework, performance, e-commerce or booking tech, accessibility implementation).
- **`brand-lead` → `taproom-ops`** when the ask touches legally-mandated label elements (pregnancy pictogram, unit statement) as a *requirement* question rather than a *placement* question.
- **`content-lead` → `brand-lead`** when the ask is about the visual treatment of copy (typography lockups beyond basic hierarchy, hero imagery, illustration, merch art).
- **`content-lead` → `web-engineer`** when the ask requires CMS config, schema markup, render concerns, or JS behaviour.
- **`content-lead` → `taproom-ops`** when the ask is about what a policy, T&C, or compliance statement *should say as fact* — content-lead drafts the prose, taproom-ops fact-checks and supplies the required facts.
- **`web-engineer` → `brand-lead`** for any design, colour, typography, or imagery decision.
- **`web-engineer` → `content-lead`** for any copy, metadata, or editorial content.
- **`web-engineer` → `taproom-ops`** for: what ages to gate, which postcodes/countries to ship to, what booking T&Cs should enforce, which HMRC duty statements are required, licensing conditions, PECR rules behind the consent banner config.
- **`taproom-ops` → `content-lead`** for turning fact packs into customer-facing prose.
- **`taproom-ops` → `brand-lead`** for the visual design of legally-required on-pack or on-site elements.
- **`taproom-ops` → `web-engineer`** to implement age-gate enforcement, carrier logic, restricted-postcode rules, consent banners, data retention config.

## Conflict resolution

Default: the agent whose ownership the decision falls under wins. Specifically:

- Visual vs copy conflict (e.g. hero treatment where a word needs to be broken for typography) — `brand-lead` wins on visual hierarchy, `content-lead` wins on which words must be preserved; if irreconcilable, `content-lead` rewrites the line.
- Policy vs prose conflict on T&Cs or age/allergen text — `taproom-ops` wins on facts and compliance; `content-lead` wins on phrasing. `taproom-ops` has veto if the prose misstates a fact.
- Implementation vs policy on age-gate or shipping — `taproom-ops` wins on what must be enforced; `web-engineer` wins on how, within the stated policy envelope.
- Platform choice (buy vs build) — `web-engineer` decides via the decision matrix unless the choice materially changes what `taproom-ops` can enforce or `content-lead` can write inside; in that case, the constraint wins and the stack is chosen to fit it.
- Compliance arbitration across CAP/ASA/Portman/FSA — `taproom-ops` has final call; `content-lead` and `brand-lead` execute.
