# Music Studio — Agent Company

> Created: 2026-04-14
> Agents: 4

> **Path substitution note:** the sandbox environment blocked writes to `.claude/` inside the output directory. Per the eval instructions, subagent files were written to `agents/{name}.md` and calibration transcripts to `agent-calibration/{name}.md`. In a real deployment, move these to `.claude/agents/` and `.claude/agent-calibration/` respectively so Claude Code's native subagent loader picks them up.

## Agents

### Outreach
- **Subagent file**: `agents/outreach.md` (target: `.claude/agents/outreach.md`)
- **Domain**: Client acquisition and lead pipeline
- **Owns**: Prospect lists, `client-pipeline.md`, cold/warm outreach, discovery-call prep, commercial DM replies, testimonial sourcing
- **Does not own**: Social publishing, pricing, contracts, scheduling
- **Hands off to**: Finance (when prospect agrees to book), Producer-Ops (when booked client needs dates), Social (when testimonial is approved for publication)

### Social
- **Subagent file**: `agents/social.md` (target: `.claude/agents/social.md`)
- **Domain**: Social media and audience growth
- **Owns**: `content-calendar.md`, captions/hooks/hashtags, platform analytics, fan DMs and public comments, publishing approved testimonials
- **Does not own**: Client acquisition, pricing, scheduling
- **Hands off to**: Outreach (commercial booking DMs, same day), Finance (pricing questions in comments), Outreach (testimonial permissions)

### Finance
- **Subagent file**: `agents/finance.md` (target: `.claude/agents/finance.md`)
- **Domain**: Money and contracts
- **Owns**: `rate-card.md`, quotes/contracts, invoices, payment chasing, expense log, monthly bookkeeping summary
- **Does not own**: Pitching, publishing rates, scheduling, tax filing (external accountant)
- **Hands off to**: Producer-Ops (when deposit clears, when contract signed), studio owner (when dispute risks relationship)

### Producer-Ops
- **Subagent file**: `agents/producer-ops.md` (target: `.claude/agents/producer-ops.md`)
- **Domain**: Project management and studio operations
- **Owns**: `session-calendar.md`, bookings and rescheduling, client status updates, deliverable handoffs (admin), revision-round ledger
- **Does not own**: Audio/engineering work, pricing/contracts, outreach, social
- **Hands off to**: Finance (scope changes, revisions exceeding cap), Outreach (project wrap / testimonial ask)

## Ownership Map

| Concern | Owner | Notes |
|---|---|---|
| Prospect lists, cold outreach, pitches | Outreach | Pre-sale |
| Discovery calls, proposal-to-contract handoff | Outreach | Then to Finance |
| Social posts, captions, hashtags, cadence | Social | Organic only |
| Platform analytics, audience insights | Social | IG / TikTok / YouTube |
| DMs from fans/followers (non-commercial) | Social | |
| Commercial DMs (booking enquiries) | Outreach | Social routes them over same-day |
| Quotes, rate cards, contracts | Finance | Including pricing strategy |
| Invoices, payment chasing, late fees | Finance | 30/60/90 ageing |
| Expenses, bookkeeping prep | Finance | Not tax filing |
| Session scheduling, studio calendar | Producer-Ops | |
| Deliverables, revision tracking (admin) | Producer-Ops | Not the audio work |
| Client status updates during a project | Producer-Ops | Green/Amber/Red |
| Post-project testimonial asks | Outreach | Social publishes once approved |

## Conflict Resolution

| Boundary | Agent A | Agent B | Resolution |
|---|---|---|---|
| Incoming booking DM on Instagram | Social | Outreach | Social flags and hands lead to Outreach same day |
| Client asks for a timeline change | Producer-Ops | Finance | Producer-Ops reschedules; if payment milestones shift, hands to Finance |
| Testimonial / case-study post | Outreach | Social | Outreach sources the quote/permission, Social publishes |
| Rate-card update | Finance | Outreach | Finance owns the numbers, Outreach owns how they're pitched |
| Late-payment chasing | Finance | Social | Finance alone — never delegated to Social's voice |
| Mid-project scope change | Producer-Ops | Finance | Finance's contract amendment gates any calendar change |
| Public pricing question in comments | Social | Finance | Finance supplies vetted wording; Social posts it |

## How to work with this company

1. Ask questions that match an agent's `description` — Claude Code auto-routes. Or run `/agents` to see the roster.
2. For formal handoffs with structured context, use `/send-brief` — it dispatches a live subagent.
3. For multi-agent decisions, use `/board-meeting` — sequential subagent round-table.
4. Durable cross-agent facts (voice rulings, pricing policy changes, new roles) go into project `CLAUDE.md` so every subagent sees them.
5. Agents manage their own persistent memory under `.claude/agent-memory/{name}/` once moved into place — no manual maintenance required.

## Files agents will create/curate

- `rate-card.md` — Finance (to be created)
- `client-pipeline.md` — Outreach (to be created)
- `content-calendar.md` — Social (to be created)
- `session-calendar.md` — Producer-Ops (to be created)
