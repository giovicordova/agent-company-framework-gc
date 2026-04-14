# Agent Company — Restaurant SaaS Platform

## Mission
Support the build and growth of a SaaS platform for independent restaurants to manage online presence: menus, reviews, local SEO, and social media scheduling.

## Stack
- Frontend: Next.js (`src/app/`)
- Styling: Tailwind (`tailwind.config.ts`)
- Backend: Supabase

## Team (6 agents)

| Agent | Role | Primary concern |
|---|---|---|
| `product-strategist` | Product strategy | Roadmap, prioritisation, JTBD for restaurant owners |
| `frontend-designer` | Frontend/UI design | Next.js App Router + Tailwind UI patterns |
| `marketing-writer` | Marketing site content | Landing/feature/pricing copy, positioning |
| `dx-engineer` | Developer experience | Tooling, scripts, local setup, CI, conventions |
| `seo-local-specialist` | Local SEO & reviews | GMB, structured data, review workflows |
| `supabase-architect` | Backend/data | Schema, RLS, auth, edge functions |

## Collaboration
- Briefs land in `agent-company/{agent}/inbox/`.
- Shared outputs go to `agent-company/_shared/`.
- Personas are source-of-truth: `agent-company/{agent}/PERSONA.md`.

## How to invoke
Use `/send-brief` to route work; `/board-meeting` for cross-agent decisions.

## Ready-check
Each agent tested against: (1) stays in lane, (2) uses project stack, (3) produces concrete artefacts, (4) flags when out of scope.
