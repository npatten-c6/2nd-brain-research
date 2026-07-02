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

## What to steal — cross-tool patterns

(As of 2026-06-18; "#n" = concept-chunk numbers in [`ob1-synthesis.md`](../analysis/ob1-synthesis.md).)

| Pattern | Source(s) | Ties to our fork / agenda |
|---|---|---|
| `schema_validate`/`infer`/`diff` as agent tools | Basic Memory | write-back contract (#5); frontmatter-corruption risk |
| Observations + typed relations parsed from human-readable pages | Basic Memory | page-vs-atom (#2) — "note = file unit, atom = derived" |
| 3-layer raw/wiki/schema layout as a shipped reference | nashsu/llm_wiki | validates our layering (#1) |
| 4-signal graph relevance rerank | nashsu/llm_wiki | retrieval/rerank (#11); entity-graph (#8) |
| SHA256 skip-unchanged + guaranteed-coverage ingest | nashsu/llm_wiki (≈ OB1 fingerprint) | dedup/idempotency (#6) |
| Bi-encoder retrieve → cross-encoder rerank | Khoj | two-stage semantic retrieval (#3/#11) |
| Configurable FTS5 ↔ vector weight; local embeddings in one SQLite file | sqlite-memory | SQLite + FTS5 + sqlite-vec derived store (#3/#4) |
| Local on-device embeddings in a hidden sidecar dir | Smart Connections | DB-as-derived-view-beside-files (#1); Obsidian-as-UI (#17) |
| Ontology generation + auto-routing recall | Cognee | entity-graph (#8); schema-aware routing (#11) |
| MCP behavior-hint annotations on write tools | Basic Memory | interface/agent-access safety (#13) |
| Local stdio/loopback MCP server (`127.0.0.1`) | nashsu/llm_wiki, Basic Memory | interface (#13) — local-MCP over hosted-HTTP |
| Memory-evolution caution (LLM rewriting old notes drifts/bloats) | A-MEM (research) | edit-in-place-vs-regenerate (#3); lint (#12); fluff-accumulation risk |

## The wedge to lead with

**Provenance/trust for LLM-authored claims** (citations + review gate + trust ladder) is absent
from every neighbor surveyed. If this project has one defensible differentiator, that's it. Risks
to keep honest: duplication of Basic Memory, the market voting "regenerate," single-maintainer
mortality (Reor died), and "files-as-truth" becoming a marketing word.
