---
id: 7
status: done
tags:
- research
created_at: 2026-06-18T21:49:30Z
updated_at: 2026-06-18T23:16:44Z
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

- [x] Every non-reserved `.md` in `docs/impl-research/` has parseable YAML frontmatter with a non-empty `type` (OKF's one hard rule).
- [x] A `type` vocabulary is decided and documented (`working-notes.md` → Doc conventions).
- [x] The `index.md` question is resolved (split: reserved `index.md` listing + `working-notes.md` for the prose).
- [x] `okf-andrej-nate-comparison.md` (frozen/superseded) and `okf-spec.md` (vendored source) handling decided — both wrapped in frontmatter.
- [x] Recommended fields added where cheap (`title`, `description` on every concept doc).
- [x] A conformance check passes (`scripts/check-okf.sh`, 10/10 PASS) and is noted in `working-notes.md`.
- [x] `style.md` updated — OKF `type` frontmatter is now a writing rule.

## Decisions (resolved with user 2026-06-18)

- **`type` vocabulary.** Free-form, self-describing OKF types (not the layer tags). Three values in use: `primary source - <medium>` (external verbatim artifacts — `blog post` / `gist` / `specification`), `AI-synthesis` (everything the agent authored: surveys, recon, synthesis, audit, comparison), `working-notes` (project meta). Documented in `working-notes.md`.
- **Layer vs `type`.** Layer (`reference`/`lens`/`source`) is **demoted to an informal concept**, not a frontmatter field — user's call ("layer is a loose concept"). `type` is the classification of record. Layer column dropped from the index.
- **`index.md`.** Split `research-index.md` → reserved `index.md` (OKF listing grouped by type, `okf_version: "0.1"` the only frontmatter) + `working-notes.md` (type `working-notes`: project direction, assumptions, conventions, open threads). `research-index.md` deleted; inbound links updated (README, AGENTS, style, prior-art-landscape).
- **Exemptions.** `okf-spec.md` wrapped with frontmatter *above* the vendor banner (spec body untouched). `okf-andrej-nate-comparison.md` wrapped (`AI-synthesis`, frozen note kept). **`lens-WIP.md` excluded** from the bundle (user: it's our working file, not knowledge) — HTML-comment exemption marker added; skipped by `check-okf.sh`.
- **Concept identity.** Path-derived (OKF §2); no stable frontmatter `id`. Revisit only if a stable id becomes necessary.
- **`log.md`.** Skipped — git history + Clew suffice for a research bundle.
- **Bug found + fixed.** `nate-post-open-brian.md` had an unterminated quote in its `description` (unparseable YAML); normalized `type: clipping` → `primary source - blog post` and closed the quote.
