# Studio Business Operations — Agent Company

A four-agent team handling the business side of a small music production studio so the owner can stay focused on production, mixing, and mastering.

## Team

| Agent | Role | Primary outputs |
|---|---|---|
| `client-outreach` | Client Outreach Lead | Prospect research, cold/warm outreach, proposals, CRM |
| `social-media` | Social Media Manager | Content calendar, captions, short-form scripts, newsletter |
| `invoicing-finance` | Finance & Invoicing Officer | Invoices, payment chases, expense log, cashflow snapshots |
| `project-manager` | Project Manager | Project plans, session schedule, status updates, client coordination |

## How they work together

```
  New lead ──▶ client-outreach ──▶ (signed) ──▶ project-manager
                                                    │
                          ┌─────────────────────────┼─────────────────────────┐
                          ▼                         ▼                         ▼
                   social-media               invoicing-finance         weekly status
                (case studies, clips)     (deposits, milestones)        (to client)
```

- `project-manager` is the central hub once a project is signed.
- `client-outreach` feeds new work in; hands off signed briefs to `project-manager`.
- `invoicing-finance` is triggered by `project-manager` at milestone points (deposit, mid-project, delivery).
- `social-media` pulls from `project-manager` for publishable moments (with client permission).

## File layout

Agent persona files live in `agents/` (the `.claude/` path was blocked in this sandbox — move them into `.claude/agents/` in the real project).

```
agents/
  client-outreach.md
  social-media.md
  invoicing-finance.md
  project-manager.md
```

## Invocation

In Claude Code, use each agent as a subagent:

```
> Use the client-outreach agent to draft a cold email to [artist].
> Use the project-manager agent to turn this brief into a plan.
> Use the invoicing-finance agent to generate the deposit invoice for [client].
> Use the social-media agent to plan next week's content.
```

## Scope

Business operations only — no production, no technical/audio work. The owner keeps full creative control; agents handle the admin surface around it.

## Guardrails common to all agents

- Nothing ships to a client or the public without owner approval.
- All money figures, scope commitments, and client-facing claims are confirmed before sending.
- Client work is never published without written permission.
