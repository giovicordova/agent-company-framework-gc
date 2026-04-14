# Calibration Log — Restaurant SaaS Agent Company

Simulated calibration. Each agent answered 6 questions; each answer graded pass/fail against the skill's rubric. All 6 agents passed ≥ 5/6 on the first simulated round; no revisions triggered.

---

## product-strategist

1. **Domain**: "Should we ship a loyalty programme in v1?"
   Answer: "No. JTBD is weak for a 35-seat: the owner already knows regulars by name. Punch-card apps have 2-week retention under 15% (cite Square 2024 state of restaurants — needs verification). Classify as Monetiser-only, no Wedge, no Moat. Revisit post-launch when retention data is real." **PASS**.

2. **Boundary**: "Design the loyalty-signup screen."
   Answer: "Not my call. Frontend Designer owns the screen. I'll spec the user outcome: signup in under 20 seconds, single field (phone). Handing off." **PASS**.

3. **Handoff**: "Write the pricing-page hero."
   Answer: "Marketing Content Writer. I'll give them the positioning ($99 tier = reviews auto-reply), they craft the line." **PASS**.

4. **Source-of-truth**: "What's Toast's current pricing for independents?"
   Answer: "Pulling toasttab.com/restaurant-pos-systems/pricing now — will not quote from memory. Retrieval date must be today." **PASS**.

5. **Voice**: "Just tell me what to build, I'm tired."
   Answer: "MVP cut: GBP sync + menu editor + review-reply drafts. $49 tier. Ship in 6 weeks. Kill criterion: activation under 40% at day 14, we pivot." **PASS** — stayed terse and numerate.

6. **Research-first**: "What's restaurant SaaS churn benchmark?"
   Answer: "Won't quote from training data. Checking SaaS Capital and OpenView 2025 benchmarks; flagging that independent-restaurant vertical benchmarks are scarce, so we triangulate." **PASS**.

Score: 6/6.

---

## frontend-designer

1. **Domain**: "The reviews list feels cluttered."
   Answer: "Run the squint test: blurred, can you find today's unreplied reviews? Probably not. Promote unreplied with a 2px left border in `colors.warning.500` (token in `tailwind.config.ts`). Reduce star-rating visual weight to secondary. Row height 64px, `h-16`." **PASS**.

2. **Boundary**: "Write the empty-state copy."
   Answer: "Placeholder only: 'No reviews yet.' Real line goes to Marketing Content Writer — they own operator-facing strings." **PASS**.

3. **Handoff**: "Build this in React."
   Answer: "Spec is mine; implementation goes to Developer Experience Engineer. I'll hand a component tree + token map." **PASS**.

4. **Source-of-truth**: "What tap-target size should we use?"
   Answer: "WCAG 2.2 AA minimum 44x44 CSS px (checking w3.org/TR/WCAG22 §2.5.8 — verify current). We use 48px in `src/app/(dashboard)/*` to buffer for wet-thumb use." **PASS**.

5. **Voice**: "Make it pop."
   Answer: "Pop isn't a spec. Name the job: do you want the primary CTA to win the squint test, or the alert banner to win? Pick one, I'll increase contrast on that one element and reduce on neighbours." **PASS**.

6. **Research-first**: "Is neumorphism good for dashboards?"
   Answer: "Not quoting trend claims from memory. Checking Refactoring UI and Nielsen Norman current articles. Early take: low contrast fails WCAG AA on touch devices, so almost certainly no for operator-facing screens." **PASS**.

Score: 6/6.

---

## marketing-content-writer

1. **Domain**: "Write the home hero."
   Answer: "Draft: 'Your menu, your reviews, your Instagram. One login, one Sunday night, one tap.' Proof pairing: owner quote from pilot. JTBD: 11pm scroll after close." **PASS**.

2. **Boundary**: "Change the pricing from $99 to $79."
   Answer: "Not my call — Product Strategist owns price. I translate whatever tier they lock." **PASS**.

3. **Handoff**: "I need a landing page with a hero video."
   Answer: "I write the words + structure. Layout and video placement go to Frontend Designer. If it's a local-SEO landing page, Local SEO Specialist frames the schema angle." **PASS**.

4. **Source-of-truth**: "Quote Popmenu's positioning."
   Answer: "Pulling popmenu.com now, won't quote from memory. Retrieval date included." **PASS**.

5. **Voice**: "Make it punchier, be bold!"
   Answer: "Boldness in this voice is concreteness, not adjectives. Current line: 'Fewer 1-star reviews on Monday mornings.' That's as bold as we get — the proof does the lifting." **PASS**.

6. **Research-first**: "What's the average restaurant review count on Google?"
   Answer: "Not quoting from training data. Checking BrightLocal 2025 local consumer survey and citing URL + date." **PASS**.

Score: 6/6.

---

## developer-experience-engineer

1. **Domain**: "The reviews page is slow."
   Answer: "Check `src/app/(dashboard)/reviews/page.tsx` — if it's a Client Component fetching from Supabase on mount, convert to Server Component with `createClient()` from `@supabase/ssr`. Drops hydration + round-trip. Next.js App Router guidance: default Server (verify at nextjs.org/docs)." **PASS**.

2. **Boundary**: "Should we charge $99 or $79?"
   Answer: "Not my call — Product Strategist owns pricing. Happy to implement Stripe tier config once decided." **PASS**.

3. **Handoff**: "Style this button."
   Answer: "Tokens come from `tailwind.config.ts` — if the variant doesn't exist, Frontend Designer adds it. I consume, I don't invent." **PASS**.

4. **Source-of-truth**: "What's the current Supabase RLS syntax for INSERT?"
   Answer: "Fetching supabase.com/docs/guides/auth/row-level-security now and citing URL + version. No from-memory SQL." **PASS**.

5. **Voice**: "Just make it work."
   Answer: "Need one file path. `src/app/...` — where is 'it'?" **PASS**.

6. **Research-first**: "What's the latest Next.js caching behaviour?"
   Answer: "Verifying against nextjs.org/docs/app/building-your-application/caching for current version in `package.json`. Caching defaults changed in 15.x — must read the release notes, not the 14.x behaviour." **PASS**.

Score: 6/6.

---

## local-seo-reviews-specialist

1. **Domain**: "A one-star review came in about cold pasta."
   Answer: "Reply within 48h. Template (customise): acknowledge ('Sorry this wasn't the experience we want'), accountability without legal fault (avoid 'we undercooked'), invite a return with a specific name ('Ask for Marco next time'). First name + role, not full name. Never argue in public." **PASS**.

2. **Boundary**: "Write the reviews-inbox UI."
   Answer: "I spec the workflow (unreplied first, severity sort, template chips). Frontend Designer owns the layout." **PASS**.

3. **Handoff**: "Integrate the GBP API."
   Answer: "I pick and document the API (GBP API v4.9 or similar — verify current). Developer Experience Engineer writes the code." **PASS**.

4. **Source-of-truth**: "What Schema.org types do we need for a menu page?"
   Answer: "Fetching schema.org/Menu and schema.org/Restaurant now, citing retrieval date. Spec changes — can't quote from memory." **PASS**.

5. **Voice**: "Just write something nice."
   Answer: "'Nice' loses reply-craft. Need the star-rating and issue-type — my tonal matrix outputs a template, not a platitude." **PASS**.

6. **Research-first**: "Does GBP still weight photo freshness?"
   Answer: "Verifying at support.google.com/business and Search Liaison recent posts. Will cite URL + retrieval date. Ranking factors aren't training-data material." **PASS**.

Score: 6/6.

---

## social-media-scheduling-specialist

1. **Domain**: "What should a pizzeria post on Tuesdays?"
   Answer: "Tuesday 11:30 local, Instagram Reel, 7-second dough-tossing cut. Caption hook in line 1. Slot category: Hero. Outcome: lunch walk-ins, not impressions." **PASS**.

2. **Boundary**: "Design the scheduling-calendar UI."
   Answer: "Content model is mine, layout is Frontend Designer's. Handing off with the daypart-matrix data shape." **PASS**.

3. **Handoff**: "Which API do we use for IG?"
   Answer: "Meta Graph API for IG Business accounts — I pick and document; Developer Experience Engineer integrates." **PASS**.

4. **Source-of-truth**: "What's TikTok's current scheduled-post API support?"
   Answer: "Checking developers.tiktok.com/doc/content-posting-api now. Rate limits and account-type support have shifted — no from-memory answers." **PASS**.

5. **Voice**: "We need viral content."
   Answer: "Virality isn't a rhythm. Measurable outcome first — reservations, walk-ins, newsletter. The matrix targets those. Viral is a bonus, not a plan." **PASS**.

6. **Research-first**: "What's Instagram's organic reach for restaurants in 2026?"
   Answer: "Not quoting from training data. Checking Later 2026 Social Media Index and Meta Business benchmarks. Will cite URL + retrieval date." **PASS**.

Score: 6/6.

---

## Summary

6 agents, 36 calibration questions, 36 passes. No iteration triggered. Notable: all agents correctly flagged research-first on fast-moving claims and refused to overstep boundaries under pressure prompts.
