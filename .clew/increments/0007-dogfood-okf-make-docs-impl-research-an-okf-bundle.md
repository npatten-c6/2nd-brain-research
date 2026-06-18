---
id: 7
status: backlog
tags:
- research
- needs-info
created_at: 2026-06-18T21:49:30Z
updated_at: 2026-06-18T21:49:30Z
---
## Requirements & the 'Why'

OKF is now a **firm requirement** for the knowledge base we intend to build (research-index → working assumptions, set in `0006`). Our own `docs/impl-research/` folder does **not** currently follow it. Converting it is cheap **dogfooding**: forces us to actually use the format, surfaces its rough edges early, and aligns the `reference`/`lens`/`source` layer tags (added in `0006`) with OKF's `type` field instead of leaving them in prose.

**Scope:** `docs/impl-research/` only. Out of scope: `.clew/` increments (they use their own `id`/`status`/`tags` schema, intentionally not OKF), root docs (`README`, `AGENTS.md`, `style.md`).

## Current state (conformance gap, checked 2026-06-18)

Against OKF v0.1 §9 ([okf-spec.md](../docs/impl-research/okf-spec.md)):

- **Required `type` frontmatter: missing on 10 of 11 docs.** Only `nate-post-open-brian.md` has frontmatter (and a `type: "clipping"`, by accident of how it was clipped). Everything else opens straight into `# Heading`.
- **`okf-spec.md`** leads with an HTML vendor-banner comment, no frontmatter (it's a `source` artifact — decide whether it gets a concept wrapper or is exempt).
- **No reserved `index.md` / `log.md`.** `research-index.md` plays the index role but isn't named `index.md` and carries its own H1 (OKF's `index.md` has no frontmatter and a specific listing structure).

## Acceptance criteria

- [ ] Every non-reserved `.md` in `docs/impl-research/` has parseable YAML frontmatter with a non-empty `type` (OKF's one hard rule).
- [ ] A `type` vocabulary is decided and documented (likely maps our `reference`/`lens`/`source` tags + `clipping`; see open questions).
- [ ] The `index.md` question is resolved (rename `research-index.md` → reserved `index.md` reshaped to the listing format, OR keep it a concept doc + add a thin OKF `index.md`).
- [ ] `okf-andrej-nate-comparison.md` (frozen/superseded) and `okf-spec.md` (vendored source) handling decided — frontmatter or documented exemption.
- [ ] Recommended fields added where cheap (`title`, `description`, `tags`, `timestamp`).
- [ ] A conformance check passes (manual checklist or a tiny script) and is noted in the index.
- [ ] `style.md` updated if the OKF frontmatter convention becomes a writing rule.

## Open questions to resolve during work

- **`type` vocabulary.** Reuse `reference` / `lens` / `source` as the `type` values? Or richer (e.g. `Survey`, `Reference`, `Synthesis`, `Audit`, `Clipping`, `Spec`)? OKF types are free-form and self-describing; consumers must tolerate unknowns.
- **Concept identity.** OKF concept ID = file path minus `.md` (path-derived). Confirm we're fine with path-derived identity vs. a stable frontmatter `id` (the open thread in research-index).
- **Layer tag vs `type`.** Do the `reference`/`lens`/`source` tags collapse *into* `type`, or stay separate (e.g. `type` = doc kind, `tags` include the layer)? Keep the index's layer column in sync either way.
- **`index.md` reserved-file reshape** vs keeping the richer `research-index.md` as a concept doc — OKF index files carry *no* frontmatter and are a plain listing; our index has working-assumptions prose we don't want to lose.
- **Exemptions:** vendored `okf-spec.md` and frozen `okf-andrej-nate-comparison.md` — wrap in frontmatter or document as deliberate non-concept artifacts?
- **Optional `log.md`** — worth adding a bundle changelog, or is git history + Clew enough?
