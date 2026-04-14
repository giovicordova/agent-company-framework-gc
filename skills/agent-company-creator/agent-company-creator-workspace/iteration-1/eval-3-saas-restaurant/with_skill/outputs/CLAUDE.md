# Restaurant SaaS — Project Instructions

See [README.md](README.md) for the project overview.

## Codebase conventions

- Next.js App Router: `src/app/(dashboard)/` for the operator app, `src/app/(marketing)/` for the public site.
- Tailwind tokens live in `tailwind.config.ts`. No arbitrary Tailwind values in components.
- Supabase schema and RLS policies live in `supabase/migrations/`. Every table ships with RLS enabled and explicit SELECT/INSERT/UPDATE/DELETE policies.
- Environment contract: `pnpm install && pnpm dev` must produce a running app on a clean clone in under 10 minutes.

## Agent company

@COMPANY.md
