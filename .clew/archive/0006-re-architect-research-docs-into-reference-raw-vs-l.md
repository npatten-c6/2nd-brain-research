---
id: 6
status: done
tags:
- research
created_at: 2026-06-18T20:09:49Z
updated_at: 2026-06-18T22:15:32Z
---
## Scope decision (2026-06-18) — Layer 1 first; personas deferred

Pivot from the original framing below: **this increment now ships Layer 1 only.** The Layer 2 persona framework is deferred to a later increment — we want the reference layer genuinely well-organized before designing personas, and not to pre-build a framework.

**Locked decisions (this pass):**
- **Layer 1 doc:** `git mv existing-tools-prior-art.md → prior-art-landscape.md`, then evolve in place (prior state preserved in git history). It becomes the decision-neutral domain map: concept/architecture taxonomy + tool instances + broadened comparison table + inherent trade-offs.
- **`okf-andrej-nate-comparison.md`:** merge its *reference* content (master comparison table, shared DNA, "the real forks") into the landscape doc as the taxonomy spine; merge its `## So what — our design position` (opinion) into the lens holding doc. **Keep the original file** as a frozen intermediary artifact (provenance/lineage) with a "superseded → see landscape" banner. Intentional, clearly-marked duplication — not a sync hazard.
- **Displaced advocacy** (TL;DR verdicts, what-to-steal/avoid, borrow-vs-build, "is our niche open?", enterprise-deployability lens, patterns-to-steal, comparison doc's "our design position"): park in a new `lens-WIP.md`, clearly marked *Layer 2 / opinionated — unorganized, pending persona increment*. Nothing lost; Layer 1 gets clean.
- **OKF:** light touch this pass — upgrade `research-index.md` from "~90% working assumption" to a firm requirement. Persona-level "us-builder MUST conform to OKF" + any conformance spec wait for Layer 2.
- **Tag scheme:** `reference` (decision-neutral domain map), `lens` (opinionated), `source` (imported external artifact, reference-flavored). Applied repo-wide in `research-index.md`.

**Revised acceptance criteria (supersede the original list below):**
- [x] `prior-art-landscape.md` exists (Layer 1): decision-neutral domain map — concept/architecture taxonomy (13 axes) + tool instances + broadened deployment table + inherent trade-offs; verification discipline + citations intact; **no advocacy** (verified by grep).
- [x] `okf-andrej-nate-comparison.md` reference content merged into landscape; original kept + banner-marked superseded.
- [x] `lens-WIP.md` exists: all displaced advocacy parked, clearly marked WIP/Layer-2-pending; pointers into Layer 1 by anchor.
- [x] `research-index.md`: every impl-research doc tagged `reference`/`lens`/`source`; convention explained; OKF upgraded to a firm requirement; Layer-2/persona deferral noted.
- [x] Cross-links between landscape ↔ lens-WIP ↔ index.

**Deferred to a later increment:** the Layer 2 persona framework (`recommendations-by-persona.md`, the 3 personas, OKF-in-us-builder persona, fact-free pointer discipline).

---

## Requirements & the 'Why' (original framing — preserved for provenance)

Reviewing the prior-art survey, the facts are too **colored by our own criteria** — opinion ("what to steal", borrow-vs-build, "is *our* niche open", the enterprise lens) is braided into the factual record, which distorts the read and makes the docs hard to reuse for other purposes/audiences.

**Goal:** split the research into two explicit layers and make the distinction a **repo-wide convention**:
- **Layer 1 — `reference` (raw):** the factual domain map. **Decision/requirement-neutral**, NOT "unopinionated" (see note below). Describes the design space, concepts/architectures, tools-as-instances, and the *inherent* trade-offs — without advocating a choice for us or any persona.
- **Layer 2 — `lens` (opinionated):** concise recommendations through the lens of specific requirements / personas. Thin, pointer-heavy; references Layer 1 by anchor, never restates facts.

**Why now:** the coloring is actively distorting our reading; the repo is small so the re-architecture is cheap now and expensive later.

## Key framing decisions (already made — don't relitigate)

- **"Decision/requirement-neutral", not "unopinionated".** Pure objectivity is a false ideal (selection, axes, even pros/cons embed a lens). Layer 1 keeps an analytical spine (taxonomy, the real forks, convergence trends) but banishes *advocacy* (steal/avoid, borrow-vs-build, niche verdict, per-requirement recommendations) to Layer 2.
- **Repo-wide, not one file.** Tag every `docs/impl-research/` doc as `reference` or `lens` in `research-index.md` so the layer is legible across the whole set (e.g. `ob1-synthesis.md` = lens; `ob1-ingestion-recon.md` = reference; `nate-post-claims-audit.md` = lens; `nate-post-open-brian.md` = reference/source).
- **Layer 1 = full domain map (concepts + tools).** `existing-tools-prior-art.md` becomes a concept/architecture taxonomy AND tool instances mapped onto it. It absorbs/merges the descriptive parts of `okf-andrej-nate-comparison.md` (resolve overlap — see open questions).
- **Broaden Layer 1 axes beyond our forks.** Current axes are our-fork-centric. Add requirement-neutral descriptive axes that matter to *other* personas: cost model, data-residency/compliance, auth/multi-user, setup-friction, maturity/licensing.
- **Personas: start with the 3 real ones, don't pre-build a framework.** (a) us — experimenting/deciding what to build; (b) enterprise non-technical staff (GTM rollout); (c) enterprise IT/builder (standing up a sanctioned option). Grow only when a real 4th profile appears.
- **New explicit requirement: adhere to the OKF spec.** Capture "follow Google's Open Knowledge Format" as a firm *requirement* for our own build/recommendation (Layer 2 / the "us-builder" persona), not just a ~90% working assumption.
- **Drift mitigation:** new tool -> update Layer 1 only; Layer 2 changes only when *requirements* change.

## Content re-homing (from current `existing-tools-prior-art.md`)

Moves to Layer 2: TL;DR verdicts, "what to steal / what to avoid", borrow-vs-build readout, "is our niche open?", the **enterprise-deployability lens** (added during 0005 wrap-up), and "patterns worth stealing tied to *our* forks".
Stays in Layer 1: tool entries, comparison table (broadened), verification discipline + tags, primary-source citations, the *inherent* trade-offs, domain convergence observations.

## Acceptance criteria

- [ ] Layer 1 reference doc exists: decision/requirement-neutral domain map (concept/architecture taxonomy + tool instances + broadened comparison table + inherent trade-offs), verification discipline intact.
- [ ] Layer 2 lens doc exists (`recommendations-by-persona.md` or similar): 3 personas, each = short requirements profile + recommendation pointing into Layer 1 by anchor; no restated facts.
- [ ] `research-index.md` tags every impl-research doc `reference` or `lens`; explains the convention.
- [ ] OKF-spec adherence captured as an explicit requirement (research-index + the relevant persona in Layer 2).
- [ ] Overlap between Layer 1 and `okf-andrej-nate-comparison.md` resolved (merged or clearly delineated; no duplicated facts).
- [ ] No advocacy left in Layer 1; no un-cited facts in Layer 2.

## Tasks

- [ ] Decide the reference/lens tag scheme + apply it across the index (one-line rationale per doc).
- [ ] Define the broadened Layer 1 axis set (our-fork axes + cost/data-residency/auth/setup-friction/maturity/licensing).
- [ ] Resolve okf-andrej-nate-comparison.md overlap (merge its concept taxonomy into Layer 1, or delineate + cross-link).
- [ ] Rewrite `existing-tools-prior-art.md` as Layer 1 (strip advocacy; add concept/architecture taxonomy; broaden table).
- [ ] Create Layer 2 `recommendations-by-persona.md`; migrate the re-homed opinion content; add OKF-adherence requirement to the us-builder persona.
- [ ] Cross-link both layers; update research-index entries + the index convention note.
- [ ] Self-check: Layer 1 advocacy-free; Layer 2 fact-free (pointers only); citations preserved.

## Open questions to resolve during work

- Final names for the two docs (keep `existing-tools-prior-art.md` for Layer 1, or rename to `prior-art-landscape.md`?).
- Merge vs delineate for `okf-andrej-nate-comparison.md` (leaning merge into Layer 1 per "concepts in Layer 1" decision, but it also feeds the comparison frame).
- Exact persona list + whether "us-builder" and "us-experimenter" are one persona or two.
