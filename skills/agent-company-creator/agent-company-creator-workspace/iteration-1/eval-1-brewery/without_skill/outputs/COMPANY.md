# Brewery Agent Company

A team of five specialist agents supporting the launch of a Bristol craft brewery with a website, e-commerce for merch, taproom booking, and a beer-culture blog.

## Context

- **Project**: Craft brewery launch in Bristol, UK.
- **Existing assets**: Logo, brand colours.
- **Missing**: Everything else — brand identity system, written content, website, e-commerce, booking flow, legal/compliance groundwork.
- **Constraints**: UK market, alcohol sales (age verification, HMRC duty, licensing), local Bristol taproom component.

## Why this team

The user proposed design + content + web dev. That trio builds a website, but it misses three things a real brewery launch needs:

1. **Brand strategy** — five agents rowing in different directions without a brand north star produces generic output. One lead owns voice, visual identity rules, and creative direction so everyone else works from the same brief.
2. **E-commerce & operations** — selling alcohol online in the UK has specific legal and logistical constraints (age gate, Challenge 25, delivery rules, HMRC alcohol duty, returns law). Web dev alone doesn't cover this.
3. **Taproom & community** — bookings, events, local Bristol scene, and customer comms are an operations job, not a web dev job.

Content and web dev stay — they're essential. Design is folded into the Brand Director role since the user already has a logo and colours (visual direction exists; what's missing is a system and voice, not a designer role in isolation).

## Team (5 agents)

| Agent | Domain | Owns |
|---|---|---|
| `brand-director` | Brand strategy, voice, visual system | Brand guidelines, tone of voice, creative briefs, design QA |
| `content-writer` | Copy and editorial | Website copy, blog posts on beer culture, product descriptions, newsletters |
| `web-developer` | Website build and maintenance | Tech stack choice, frontend/backend, CMS, hosting, performance, accessibility |
| `ecommerce-operator` | Merch store, payments, fulfilment, compliance | Stripe/checkout, age verification, shipping, returns, UK alcohol regulation |
| `taproom-community-manager` | Bookings, events, local engagement | Booking system requirements, event calendar, social media strategy, local partnerships |

## How they work together

- `brand-director` sets the brief. Everyone else produces work against it.
- `content-writer` and `web-developer` pair on website delivery — writer supplies copy, dev implements.
- `ecommerce-operator` briefs `web-developer` on e-commerce requirements (compliance is non-negotiable, UX is collaborative) and briefs `content-writer` on product copy and legal microcopy.
- `taproom-community-manager` briefs `web-developer` on booking flow and calendar, and briefs `content-writer` on event/community content.
- Cross-agent handoffs use the `send-brief` skill; major decisions can convene via `board-meeting`.

## File layout and deployment

Persona files are in `agents/` at this sandbox root. For Claude Code to pick them up as native subagents, copy them into your project at `.claude/agents/{name}.md` (or into `~/.claude/agents/` for user-scoped availability). The YAML frontmatter and Markdown body are already in the correct Claude Code subagent format.

## Out of scope (deliberately)

- **Dedicated designer**: User has logo and colours. Brand Director handles design direction and QA. If bespoke illustration, packaging design, or a major visual overhaul is needed later, add a `visual-designer` agent.
- **Brewing/product agent**: The user is the brewer. No agent second-guesses the beer.
- **Legal counsel**: `ecommerce-operator` flags compliance issues but real licensing/legal advice comes from a human solicitor.
- **Paid ads / performance marketing**: Not in the initial brief. Add a `growth-marketer` agent once the site is live and there's traffic to optimise.
