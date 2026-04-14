# Restaurant SaaS — Agent Company

> Created: 2026-04-14
> Agents: 6

## Note on file locations (sandbox substitution)

In a normal project, subagent files live at `.claude/agents/{name}.md` and calibration records at `.claude/agent-calibration/{name}.md`. In this evaluation sandbox, Write to `.claude/` paths was blocked, so files were redirected to `agents/{name}.md` and `agent-calibration/calibration-log.md` inside the sandbox. Content matches the skill's exact template. To deploy, copy `agents/*.md` into `.claude/agents/` at the project root.

## Agents

### Product Strategist
- **Subagent file**: `agents/product-strategist.md`
- **Domain**: Product roadmap, positioning, pricing, competitive analysis for independent-restaurant SaaS
- **Owns**: Roadmap, MVP scope, ICP, pricing tiers, success metrics, competitor analysis
- **Does not own**: UI, copy, code, GBP mechanics, social cadence
- **Hands off to**: Frontend Designer (UX), Developer Experience Engineer (build), Marketing Content Writer (site copy), Local SEO and Reviews Specialist (reviews depth), Social Media Scheduling Specialist (social depth)

### Frontend Designer
- **Subagent file**: `agents/frontend-designer.md`
- **Domain**: UI/UX for `src/app/` dashboard; Tailwind tokens in `tailwind.config.ts`
- **Owns**: Layout, visual hierarchy, token system, accessibility, interaction patterns, responsive behaviour
- **Does not own**: Feature scope, operator-facing copy, component implementation, marketing-site narrative
- **Hands off to**: Developer Experience Engineer (build), Marketing Content Writer (microcopy), Product Strategist (scope ambiguity)

### Marketing Content Writer
- **Subagent file**: `agents/marketing-content-writer.md`
- **Domain**: Marketing-site copy across `src/app/(marketing)/`; brand voice; email + blog
- **Owns**: Landing/features/pricing/about/blog copy, SEO meta, brand voice, email nurture, microcopy consultation
- **Does not own**: Layout, feature positioning, local-SEO technical setup, social content, in-product UI
- **Hands off to**: Frontend Designer (layout), Product Strategist (feature validation), Local SEO and Reviews Specialist (SEO angles), Social Media Scheduling Specialist (social captions in-product)

### Developer Experience Engineer
- **Subagent file**: `agents/developer-experience-engineer.md`
- **Domain**: Next.js + Supabase codebase architecture, DX, performance, RLS, CI, testing
- **Owns**: `src/app/` architecture, `supabase/migrations/`, RLS policies, build tooling, CI, performance, code review
- **Does not own**: Visual design, tokens, feature scope, copy, GBP/social strategy
- **Hands off to**: Frontend Designer (visual specs), Product Strategist (scope), Local SEO and Reviews Specialist (reviews API choice), Social Media Scheduling Specialist (social API choice)

### Local SEO and Reviews Specialist
- **Subagent file**: `agents/local-seo-reviews-specialist.md`
- **Domain**: GBP, Apple Business Connect, Yelp, TripAdvisor, local schema, review-response strategy
- **Owns**: Platform strategy, reply tone matrix, schema spec, citation strategy, review/GBP API choice
- **Does not own**: UI layout, code, marketing-site prose, product scope, social posting
- **Hands off to**: Developer Experience Engineer (build), Frontend Designer (UX), Marketing Content Writer (prose), Product Strategist (build-or-buy)

### Social Media Scheduling Specialist
- **Subagent file**: `agents/social-media-scheduling-specialist.md`
- **Domain**: Instagram/TikTok/Facebook restaurant content strategy, cadence matrices, scheduling APIs
- **Owns**: Posting-cadence templates, caption patterns, asset specs, social API choice
- **Does not own**: UI layout, code, marketing-site prose, review replies, feature scope
- **Hands off to**: Frontend Designer (UX), Developer Experience Engineer (build), Marketing Content Writer (marketing prose), Local SEO and Reviews Specialist (reshared reviews), Product Strategist (build-or-buy)

## Ownership Map

| Concern | Owner | Notes |
|---------|-------|-------|
| Product roadmap, scope, pricing | Product Strategist | Includes ICP, competitive analysis |
| Success metrics, north-star | Product Strategist | Activation, retention, ARPU |
| Dashboard UI / visual hierarchy | Frontend Designer | Inside `src/app/(dashboard)/` |
| Tailwind tokens | Frontend Designer | `tailwind.config.ts` |
| Accessibility (WCAG 2.2 AA) | Frontend Designer | All operator-facing surfaces |
| Marketing-site copy | Marketing Content Writer | `src/app/(marketing)/` |
| Brand voice + tone | Marketing Content Writer | Doc lives at project root |
| Blog + SEO long-form | Marketing Content Writer | Factual substrate from Local SEO Specialist |
| Email nurture copy | Marketing Content Writer | Incl. onboarding |
| Next.js architecture, routes | Developer Experience Engineer | `src/app/` |
| Supabase schema, RLS, migrations | Developer Experience Engineer | `supabase/` |
| Build/CI/performance | Developer Experience Engineer | |
| DX documentation | Developer Experience Engineer | `README.md`, `CONTRIBUTING.md` dev sections |
| GBP + review-platform strategy | Local SEO and Reviews Specialist | GBP, Apple, Yelp, TripAdvisor |
| Review-response tone matrix | Local SEO and Reviews Specialist | Templates only, not UI |
| Local schema markup spec | Local SEO and Reviews Specialist | Implemented by Developer Experience Engineer |
| Citation + NAP management | Local SEO and Reviews Specialist | |
| Social content strategy + cadence | Social Media Scheduling Specialist | IG, TikTok, FB |
| Social API selection | Social Media Scheduling Specialist | Implemented by Developer Experience Engineer |
| Caption/asset templates | Social Media Scheduling Specialist | |

## Conflict Resolution

| Boundary | Agent A | Agent B | Resolution |
|----------|---------|---------|------------|
| Marketing-site layout | Marketing Content Writer | Frontend Designer | Marketing Content Writer owns words + section order; Frontend Designer owns visual layout + tokens |
| In-product microcopy | Frontend Designer | Marketing Content Writer | Frontend Designer specs placements; Marketing Content Writer writes the strings |
| Pricing page words | Marketing Content Writer | Product Strategist | Product Strategist owns tier values and positioning; Marketing Content Writer translates into copy |
| Reviews inbox UX | Local SEO and Reviews Specialist | Frontend Designer | Local SEO owns workflow logic (unreplied-first sort, reply templates); Frontend Designer owns layout, component structure |
| Scheduling calendar UI | Social Media Scheduling Specialist | Frontend Designer | Social specialist owns content model and matrix data shape; Frontend Designer owns calendar visual + interaction |
| Third-party API selection (GBP, Meta, TikTok) | Local SEO / Social specialists | Developer Experience Engineer | Domain specialist picks the API and cites current docs; Developer Experience Engineer validates feasibility and integrates |
| Feature scope vs. domain depth | Product Strategist | Domain specialists | Product Strategist owns "does it ship this quarter"; domain specialists own "what does right look like inside it" |
| Tailwind token additions | Frontend Designer | Developer Experience Engineer | Frontend Designer proposes and decides; Developer Experience Engineer reviews for build/perf impact |
| Blog post on local SEO | Marketing Content Writer | Local SEO and Reviews Specialist | Local SEO provides facts + angle; Marketing Content Writer writes the prose |
| RLS policy for a new feature | Developer Experience Engineer | Product Strategist | Developer Experience Engineer designs the policy; flags to Product Strategist if it constrains a planned feature |

## How to work with this company

1. Ask questions that match an agent's `description` — Claude Code auto-routes. Or run `/agents` to see the roster.
2. For formal handoffs with structured context, use `/send-brief` — it dispatches a live subagent.
3. For multi-agent decisions, use `/board-meeting` — sequential subagent round-table.
4. Durable cross-agent facts (voice rulings, strategic pivots, new roles) go into project `CLAUDE.md` so every subagent sees them.
5. Agents manage their own persistent memory under `.claude/agent-memory/{name}/` — no manual maintenance required.

## Dry run

Scenario: a 1-star Google review comes in about cold pasta on Sunday night. The owner wants to reply from the app Monday morning and surface the pattern if it's recurring.

- **Local SEO and Reviews Specialist** triggers first: workflow says unreplied 1-stars sort to top; tone-matrix template populates; reply stays within legal-safe language.
- **Frontend Designer** already owns the inbox layout — reviewed against squint test, template chip at thumb height.
- **Developer Experience Engineer** ensures the GBP API integration writes the reply back; Supabase logs reply latency.
- **Product Strategist** consumes the aggregate (reply rate, time-to-reply) as an activation metric; decides whether "recurring-complaint detection" is a v2 feature.
- **Marketing Content Writer** borrows the real operator-outcome for the pricing page: "Fewer 1-star reviews on Monday mornings."
- **Social Media Scheduling Specialist** is not invoked — correct; review replies are not social content.

No orphaned steps. Handoffs are symmetric (Local SEO → Developer Experience Engineer acknowledged in both files).
