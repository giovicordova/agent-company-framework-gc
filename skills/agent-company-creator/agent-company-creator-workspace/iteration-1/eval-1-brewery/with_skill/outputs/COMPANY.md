# Bristol Craft Brewery — Agent Company

> Created: 2026-04-14
> Agents: 4

> Sandbox note: the skill specifies agent files at `.claude/agents/{name}.md`. The sandbox permission rules for this evaluation deny writes to any path containing `.claude/`, so agent files are at `{sandbox}/agents/{name}.md` instead. When this company is deployed into a real project, move the four files from `agents/` into `.claude/agents/` — the frontmatter is already correct for Claude Code's native subagent loader.

## Agents

### Brand & Growth Strategist
- **Subagent file**: `.claude/agents/brand-growth.md` (sandbox: `agents/brand-growth.md`)
- **Domain**: Brand positioning, marketing strategy, product-mix and pricing decisions, alcohol-advertising-code compliance, tone-of-voice governance
- **Owns**: Positioning and naming; marketing plan and launch sequence; product-mix and pricing; Portman/ASA CAP compliance sign-off; customer-research briefs; tone-of-voice document
- **Does not own**: Long-form prose (Editor); visual design (Designer); site implementation (Engineer); operational licensing (founder)
- **Hands off to**: Editor (with brief), Designer (with positioning doc), Engineer (with KPI list and age-gate/GDPR policy)

### Visual & UX Designer
- **Subagent file**: `.claude/agents/designer.md` (sandbox: `agents/designer.md`)
- **Domain**: Visual identity system, layout design, UX flows for booking and checkout, accessibility at design stage, design tokens
- **Owns**: Identity system derived from existing logo and brand colours; layouts for home, booking, merch, blog, age-gate, checkout; UX flows; WCAG 2.2 AA compliance at design stage; `design/tokens.json` and component spec
- **Does not own**: Copy (Editor); strategy (Brand/Growth); implementation (Engineer); photography (external)
- **Hands off to**: Editor (with wireframes and character budgets), Brand/Growth (when CTA direction unclear), Engineer (with tokens and component spec)

### Beer Culture Editor
- **Subagent file**: `.claude/agents/editor.md` (sandbox: `agents/editor.md`)
- **Domain**: All customer-facing text — beer descriptions, blog posts, product copy, microcopy, transactional emails — plus editorial fact-checking
- **Owns**: Long-form blog; beer and merch descriptions; microcopy inside layouts; editorial calendar; fact-checking against BJCP and named historical sources; execution-level style guide
- **Does not own**: Brand strategy (Brand/Growth); layout (Designer); deployment (Engineer); advertising-code sign-off (Brand/Growth)
- **Hands off to**: Brand/Growth (for briefs and compliance sign-off), Designer (for character budgets), Engineer (for publish and meta)

### Web Engineer
- **Subagent file**: `.claude/agents/engineer.md` (sandbox: `agents/engineer.md`)
- **Domain**: Stack selection, frontend implementation, e-commerce integration, booking-platform integration or build, CMS, hosting, performance, SEO, analytics, technical compliance (age-gate, GDPR/PECR), incident response
- **Owns**: Stack decisions; implementation against Designer tokens; integrations (Stripe, Shopify, booking platform, email); SEO and schema; Core Web Vitals; GDPR/PECR and age-gate mechanics; analytics instrumentation against flywheel KPIs; hosting, deployment, backups, runbooks
- **Does not own**: Words (Editor); visuals (Designer); product and pricing (Brand/Growth); advertising-code policy (Brand/Growth)
- **Hands off to**: Editor (copy for any new user-facing string), Designer (UX edge cases during build), Brand/Growth (KPI definitions, policy confirmations)

## Ownership Map

| Concern | Owner | Notes |
|---------|-------|-------|
| Brand positioning and naming | Brand & Growth | Local Beer Triangle applied |
| Tone-of-voice guidelines (document) | Brand & Growth | Editor executes against it |
| Product-mix and pricing (beers, merch) | Brand & Growth | Merch Gravity Test applied |
| Marketing plan and launch sequence | Brand & Growth | 90-60-30-launch flywheel |
| Portman and ASA CAP compliance sign-off | Brand & Growth | Reviews all alcohol-adjacent creative |
| Competitive and customer research briefs | Brand & Growth | Verified against live sources |
| Visual identity system | Designer | Derived from existing logo + brand colours |
| Design tokens (colour, type, spacing, radii) | Designer | `design/tokens.json`, versioned |
| Layouts (home, booking, merch, blog, age-gate, checkout) | Designer | Squint test + 60-30-10 enforced |
| UX flows (booking, checkout, age-gate) | Designer | Baymard benchmark applied |
| Accessibility at design stage (WCAG 2.2 AA) | Designer | Contrast, focus states, target sizes |
| Long-form blog posts (beer culture) | Editor | BJCP + named sources cited |
| Beer and merch product descriptions | Editor | Recipe-required discipline |
| Microcopy inside layouts | Editor | Against Designer's character budgets |
| Transactional and confirmation emails | Editor | Tone-Register Matrix applied |
| Editorial calendar | Editor | Cadence and depth |
| Editorial style guide (execution-level) | Editor | Oxford comma, ABV formatting, etc. |
| Fact-checking of beer claims | Editor | BJCP 2021 + named historical sources |
| Stack selection (frontend, CMS, commerce, booking) | Engineer | Build-vs-Integrate Matrix |
| Frontend implementation (tokens → CSS) | Engineer | Against Designer spec |
| E-commerce integration (Stripe, Shopify or equivalent) | Engineer | Verified against current vendor docs |
| Taproom booking integration or build | Engineer | Build-vs-Integrate Matrix |
| Blog CMS setup | Engineer | Choice coordinated with Editor's workflow needs |
| Technical SEO and schema markup | Engineer | Structured data for beer and events |
| Core Web Vitals and performance | Engineer | LCP / CLS / INP on Bristol 4G |
| Age-gate mechanics (cookie, middleware) | Engineer | Policy from Brand & Growth |
| GDPR/PECR cookie consent and data handling | Engineer | Against current ICO guidance |
| Analytics instrumentation | Engineer | KPI list from Brand & Growth |
| Hosting, deployment, backups, incident response | Engineer | 3-Tier response framework |

## Conflict Resolution

| Boundary | Agent A | Agent B | Resolution |
|----------|---------|---------|------------|
| Tone of voice (document vs execution) | Brand & Growth | Editor | Brand/Growth owns the tone-of-voice *guidelines* document. Editor owns *execution* and the execution-level style guide (Oxford comma, ABV formatting). When a register is undefined, Editor asks Brand/Growth before inventing one. |
| Headline copy in a hero layout | Designer | Editor | Designer owns the slot, character budget, and visual weight. Editor owns the words. Designer requests from Editor with wireframe and character budget attached. |
| CTA colour | Designer | Brand & Growth | Designer derives from existing brand-colour source of truth and WCAG contrast; commits to `design/tokens.json`. Brand/Growth consulted only if the strategic direction of the CTA is ambiguous. |
| Site copy about a specific beer | Editor | Brand & Growth | Editor writes, requiring the brewery's recipe sheet. Brand/Growth signs off against Portman/CAP before publication. |
| Age-gate behaviour | Brand & Growth | Engineer | Brand/Growth defines policy (retention, trigger conditions, Challenge 25 alignment). Engineer implements mechanics (cookie scope, middleware, expiry). |
| Cookie and privacy policy text | Editor | Engineer | Editor writes under voice doc. Engineer specifies what clauses are required by ICO/PECR. Brand/Growth signs off the final text. |
| Blog SEO strategy | Editor | Engineer | Editor owns content strategy and keyword intent. Engineer owns schema markup, meta infrastructure, and technical SEO. |
| Booking-flow edge cases (sold-out, gift) | Designer | Engineer | Designer owns the UX design for edge cases. Engineer implements and flags any impossible-in-platform edges back to Designer for re-spec. |
| Build vs integrate for booking | Brand & Growth | Engineer | Engineer runs the Build-vs-Integrate Matrix and recommends. Brand/Growth weighs in only on strategic-differentiation score. Engineer's recommendation stands unless Brand/Growth can demonstrate differentiation value. |
| Analytics KPIs | Brand & Growth | Engineer | Brand/Growth defines what to measure (KPI list tied to the Launch Flywheel). Engineer decides how to measure (event schema, tooling) and instruments. |
| Merch SKU approval | Brand & Growth | — | Brand/Growth owns via Merch Gravity Test. Other agents do not opine on SKU selection. |
| Which stack ships on launch day | Engineer | — | Engineer owns. Decision logged in `tech/decisions.md`. |

## How to work with this company

1. Ask questions that match an agent's `description` — Claude Code auto-routes. Or run `/agents` to see the roster.
2. For formal handoffs with structured context, use `/send-brief` — it dispatches a live subagent.
3. For multi-agent decisions, use `/board-meeting` — sequential subagent round-table.
4. Durable cross-agent facts (voice rulings, strategic pivots, new roles) go into project `CLAUDE.md` so every subagent sees them.
5. Agents manage their own persistent memory under `.claude/agent-memory/{name}/` — no manual maintenance required.

## Known project source-of-truth files

Existing:
- `brand/logo` — founder's logo (to be documented as a canonical file)
- `brand/colours` — founder's brand-colour palette (to be documented as a canonical file)

To be created (ownership in parentheses):
- `brand/voice.md` — tone-of-voice guidelines (Brand & Growth)
- `brand/positioning.md` — positioning doc from Local Beer Triangle (Brand & Growth)
- `design/tokens.json` — design tokens (Designer)
- `design/components.md` — component spec (Designer)
- `editorial/style.md` — execution-level style guide (Editor)
- `editorial/sources.md` — cited sources log (Editor)
- `tech/decisions.md` — architecture decision log (Engineer)
- `tech/runbooks.md` — incident runbooks (Engineer)
