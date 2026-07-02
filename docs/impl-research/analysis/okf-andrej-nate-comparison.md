---
type: "AI-synthesis"
title: "OKF vs Andrej vs Nate — Compare / Contrast (superseded)"
description: "Frozen intermediary artifact — original compare/contrast of the three reference approaches; reference content now merged into prior-art-landscape.md. Kept for provenance."
---

# OKF vs Andrej vs Nate — Compare / Contrast

> **⚠️ Superseded (kept for provenance/lineage).** As of increment `0006`, this doc's *reference* content (the "three kinds of thing" framing, master comparison table, shared DNA, the real forks) is merged into [`prior-art-landscape.md`](prior-art-landscape.md) §1–2, and its `## So what — our design position` (opinion) is merged into [`lens-WIP.md`](../recommendations/lens-WIP.md). Those are now canonical. This file is **frozen** as the intermediary artifact those were built from — do not edit it as a living doc; update the landscape/lens instead. Its facts intentionally duplicate the canonical docs (a frozen snapshot, not a doc to keep in sync).

Internal working doc. Where the three reference approaches align, where they materially diverge, and what that means for our design.

Sources: OKF — [`knowledge-catalog-patterns.md`](../sources/knowledge-catalog-patterns.md). Andrej's LLM Wiki — [`andrej-wiki-gist.md`](../sources/andrej-wiki-gist.md). Nate's Open Brain — [`ob1-synthesis.md`](ob1-synthesis.md) / [`ob1-ingestion-recon.md`](../sources/ob1-ingestion-recon.md) / [`nate-post-claims-audit.md`](nate-post-claims-audit.md).

## First, they're not the same *kind* of thing

This is the unlock — comparing them apples-to-apples is a category error:

- **OKF = a file *format spec*.** "Knowledge as a vendor-neutral bundle of markdown + YAML frontmatter + links." Says nothing about workflow, retrieval, or who writes it. Substrate only.
- **Andrej = a *workflow pattern* / philosophy.** "LLM incrementally maintains a living, interlinked markdown wiki you curate." A way of working; storage is just files; tooling is deliberately optional/modular.
- **Nate = a deployed *system architecture*.** "Postgres + pgvector + MCP server so every AI can query your captured thoughts." Opinionated stack, cloud-coupled.

So: OKF answers *what the files look like*, Andrej answers *how the LLM and human work the knowledge*, Nate answers *how agents access it across tools*. Largely **complementary layers**, not three competitors for one slot.

## Master comparison

| Axis | OKF (format) | Andrej (workflow) | Nate (system) |
|---|---|---|---|
| **What it is** | File format spec | Working pattern | Built product/stack |
| **Source of truth** | Files | Files | **Database** (Postgres) |
| **Unit of knowledge** | Concept doc (1 file = 1 concept) | Wiki page (entity / concept / summary) | **Atomic thought** (1-2 sentences, <280 chars) |
| **Granularity** | Page-level | Page-level (human-readable) | Sub-sentence atoms (embed-optimized) |
| **Who authors** | Agnostic | **LLM writes, human curates/directs** | **Capture pipeline auto-extracts**, LLM classifies |
| **Human's role** | n/a (it's a format) | Curator, director, question-asker | Ambient capturer ("dump thoughts") |
| **Synthesis model** | None (static format) | **Edit-in-place living document** (revise pages, flag contradictions inline) | **Regenerable views** over atoms (wiki = disposable projection) |
| **Retrieval** | None specified | `index.md` + grep first; optional hybrid search (qmd) late | **Embeddings mandatory**, semantic vector search central |
| **Embeddings** | — | Optional / deferred | Required / load-bearing |
| **Dedup & consistency** | — (permissive conformance) | Periodic LLM **lint** pass | Engineered: fingerprint + semantic dedup + reconcile + job/dry-run |
| **Metadata / provenance** | Frontmatter fields (medium) | Light frontmatter + `log.md` | Heavy: type/importance/quality/sensitivity/provenance/trust |
| **Agent interface** | MCP optional | Single agent + Obsidian; optional CLI | **MCP server, multi-tool** (the headline feature) |
| **Locality** | Local | Local-first | **Cloud-coupled** (Supabase + OpenRouter + Slack) |
| **Navigation aids** | `index.md` (progressive disclosure) | `index.md` (content) + `log.md` (chronological) | stats / list tools + dashboards |
| **Primary problem solved** | Knowledge **portability/interchange** | **Synthesis & compounding** (beat RAG re-derivation) | **Cross-tool agent memory access** |
| **Scale target** | Any | ~100s sources / hundreds of pages | Unbounded atom stream |

## Where they align (shared DNA)

1. **Markdown + structure as the human substrate.** OKF and Andrej are literally markdown files; Nate generates markdown wiki *views* from the DB. All converge on markdown as the readable layer.
2. **LLM does the grunt work** — extraction, summarizing, cross-referencing, filing. None expect the human to do bookkeeping.
3. **Raw vs curated/derived separation.** OKF reference-layers; Andrej's raw / wiki / schema; Nate's raw thought + regenerated views. Everyone keeps immutable sources distinct from synthesis.
4. **An index/navigation layer.** OKF `index.md`, Andrej `index.md` + `log.md`, Nate stats/list/dashboards.
5. **Compounding thesis** (Andrej + Nate explicitly, both cite the Karpathy "LLM-wiki" framing): knowledge accumulates into a persistent artifact instead of being re-derived per query. OKF is silent (just a format) but compatible.

## Where they materially diverge (the real forks)

These are the actual design decisions we inherit:

1. **Files-as-truth vs DB-as-truth.** OKF + Andrej = files. Nate = Postgres. *The* fork. Our project sided with files-as-truth (DB = rebuildable derived view). Nate's whole stack inverts ours.
2. **Page vs atom granularity.** Andrej's human-readable pages vs Nate's sub-sentence atoms. Files-as-truth + tiny atoms = file explosion (flagged in `ob1-synthesis.md` #1). The likely resolution: **page/concept = the file unit, atom = a derived extraction granularity in the DB** — i.e. take Andrej's unit on disk, Nate's unit in the index.
3. **Edit-in-place vs regenerate.** Andrej *revises* a living narrative wiki (pages evolve, contradictions noted inline). Nate stores atoms and *regenerates* views on demand (the wiki is throwaway). Different consistency models: Andrej's pages drift if not linted; Nate's views are always fresh but the atom store needs dedup hygiene. Decide per-artifact (entity pages = living; digests = regenerable).
4. **Embeddings: deferred vs mandatory.** Andrej proves `index.md` + grep gets you far at ~100s of pages (no vector infra). Nate makes semantic search the centerpiece. Our lean: **FTS-first, vectors as opt-in derived layer** — Andrej's posture, Nate's mechanics available when needed.
5. **Curation-heavy vs capture-heavy.** Andrej = deliberate sourcing, ingest one-at-a-time, stay involved. Nate = frictionless ambient capture, dump everything. Opposite stances on the human's role and on whether "just dump it" is wise (the audit flags that Nate's own code signal-gates and dedups, contradicting "no curation needed").
6. **Single-agent local vs multi-tool protocol access.** Andrej = one agent + Obsidian. Nate = MCP so Claude/ChatGPT/Cursor/next-month's-tool all query one brain. Nate's portability point is genuine and the one thing Andrej doesn't address — worth borrowing (as a **local** CLI/stdio-MCP, not a hosted HTTP server).
7. **Local vs cloud.** OKF/Andrej local; Nate cloud-coupled. We follow OKF/Andrej.

## So what — our design position

The three slot together cleanly:

- **OKF = our file format** (markdown concept docs + YAML frontmatter + links; permissive). The *substrate*.
- **Andrej = our workflow + philosophy** (LLM-maintained living wiki, files-as-truth, ingest/query/lint ops, `index.md` + `log.md`, Obsidian as read UI, curation-in-the-loop). The *operating model*.
- **Nate = our mechanics & access library, selectively** (atomic extraction, fingerprint + semantic dedup, dry-run/job model, provenance/sensitivity tiers, embeddings, MCP/CLI agent interface) — applied to a **derived layer over files**, with his DB-as-truth + cloud coupling rejected.

One-line: **Andrej's workflow, on OKF's format, with Nate's pipeline borrowed into the derived layer — all local.** The two genuine forks still open: page-vs-atom granularity (#2) and edit-in-place-vs-regenerate (#3). Both already on the agenda in `ob1-synthesis.md`.
