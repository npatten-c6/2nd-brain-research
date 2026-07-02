---
type: "recommendation - us-builder persona"
title: "Recommendations — Us (experimenter / builder)"
description: "Our standing recommendation for what to build and what to borrow: OKF format + Andrej workflow + Nate's mechanics in a derived layer, all local; borrow-vs-build verdicts on the closest neighbors; the provenance wedge."
date: "2026-07-02"
---

# Recommendations — Us (experimenter / builder)

> **Tier 3 · opinion.** Our judgment as the people building/experimenting. Evidence lives in
> [Tier 2](../analysis/prior-art-landscape.md) and [Tier 1](../index.md#tier-1--sources); this doc
> links there rather than restating it. Reorganized from [`lens-WIP.md`](lens-WIP.md) (increment
> `0009`). At SPS and just want to use something? See [the SPS guide](sps-guide.md).
>
> _Freshness:_ verdicts formed 2026-06-18 against the [prior-art survey](../analysis/prior-art-landscape.md)
> of that date; OB1-derived facts re-verified 2026-07-02. The tool space moves weekly — re-check a
> neighbor's repo before acting on a verdict.

## Requirements profile (what "us" means)

- **MUST conform to OKF** — markdown concept docs + YAML frontmatter + links
  ([spec](../sources/okf-spec.md); firm requirement per [`working-notes.md`](../working-notes.md)).
- Local-first **data + infrastructure**; frontier cloud models (Claude) are the intended reasoning
  layer. No self-hosted services, no Docker daemons, no hosted DBs.
- Files are the source of truth; SQLite/DuckDB/FTS/vector are rebuildable derived views.
- Deterministic hot paths pushed down to a CLI; LLM only where synthesis/judgment is needed.

## The design position

Compose the three reference approaches rather than picking one
([comparison](../analysis/prior-art-landscape.md#reference-approach-comparison)):

- **OKF = the file format** (substrate).
- **Andrej = the workflow** — LLM-maintained living wiki, curation-in-the-loop, Obsidian as read UI.
- **Nate/OB1 = the mechanics library, selectively** — atomic extraction, fingerprint + semantic
  dedup, dry-run jobs, provenance/sensitivity tiers — applied to a **derived layer over files**,
  with his DB-as-truth + cloud coupling rejected
  ([synthesis](../analysis/ob1-synthesis.md), [claims audit](../analysis/nate-post-claims-audit.md)).

One line: _Andrej's workflow, on OKF's format, with Nate's pipeline borrowed into the derived
layer — all local._ Two genuine forks remain open: **page-vs-atom granularity** and
**edit-in-place-vs-regenerate** (the market leans regenerate — revisit our edit-in-place lean;
see [synthesis](../analysis/ob1-synthesis.md)).

## Borrow-vs-build (the honest verdict)

The broad niche is occupied and validated; our specific combination is differentiated but **not
unique**, and we are not first ([landscape §5](../analysis/prior-art-landscape.md)).

- **Basic Memory is the build-vs-borrow pressure point** — files-as-truth + LLM edits + MCP +
  schema-validate already shipped. Before writing code, do the hard spike: install it, read its
  sync + schema-tool source, and answer _"what do we get by building that forking/contributing
  wouldn't?"_ If the answer is only "OKF + provenance + Rust," weigh extensions to Basic Memory
  over a new system. (Neutral recon planned as increment `0008` — will land as a proxy source.)
- **nashsu/llm_wiki** — read as a reference design (3-layer raw/wiki/schema layout, 4-signal
  rerank, skip-unchanged cache); don't depend on it (GPL-3 desktop app; regenerate posture).
- **Khoj** — borrow retrieval mechanics (bi-encoder → cross-encoder); don't adopt its
  read-only/DB-as-index architecture.
- Full what-to-steal table with fork mappings: [`lens-WIP.md` §"What to steal"](lens-WIP.md#what-to-steal-per-closest-neighbor)
  (frozen, still accurate as of 2026-06-18).

## The wedge to lead with

**Provenance/trust for LLM-authored claims** (citations + review gate + trust ladder) is absent
from every neighbor surveyed. If this project has one defensible differentiator, that's it. Risks
to keep honest: duplication of Basic Memory, the market voting "regenerate," single-maintainer
mortality (Reor died), and "files-as-truth" becoming a marketing word.
