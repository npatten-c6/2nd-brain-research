---
type: "AI-synthesis"
title: "OB1 Synthesis — Concept Chunks & Our Options"
description: "Primary OB1 takeaway doc — 18 concept chunks from Nate B. Jones's 'Open Brain' with our local-first options for each; reframes DB-as-truth into files-as-truth + DB-as-derived-view."
---

# OB1 Synthesis — Concept Chunks & Our Options

Internal working doc.

Source: `~/Projects/OB1` (Nate B. Jones "Open Brain"). Scouted 2026-06-18 across schemas/server/recipes/skills/docs, at OB1 commit `2a15199`.

> **Freshness (2026-07-02):** the OB1 proxy source was refreshed at `671b923` (88 commits later) —
> see the [recon's refresh addendum](../sources/ob1-ingestion-recon.md#refresh-addendum--what-changed-2a15199--671b923).
> The pipeline facts this synthesis rests on re-verified **unchanged**; DB-as-truth is reinforced.
> Two chunks are now understated rather than wrong: **#13 (interface)** — OB1 now ships a *second*,
> 13-tool "enhanced" MCP server alongside the stock 6-tool one, and its newest capture path (a
> Chrome extension) bypasses MCP for a REST gateway; **capture surfaces (#8/#9-adjacent)** —
> ingestion now also spans browser DOM capture (Claude/ChatGPT/Gemini, incl. bulk history) and an
> offline Gmail pull that emits portable pack files. Neither changes our options below.
Companion detail: [`ob1-ingestion-recon.md`](../sources/ob1-ingestion-recon.md) (deep dive on the ingest pipeline). Seed idea: [`andrej-wiki-gist.md`](../sources/andrej-wiki-gist.md). Format direction: [`knowledge-catalog-patterns.md`](../sources/knowledge-catalog-patterns.md) (OKF).

## TL;DR — the one big inversion

OB1 = **DB-as-truth**. Supabase Postgres `thoughts` table is the system; everything (wiki, digests, dashboards) is a view over it. Cloud-coupled by design (Supabase + OpenRouter + Edge Functions).

LLM-Wiki = **files-as-truth** (OKF markdown + YAML frontmatter), **DB-as-derived-view** (SQLite etc. rebuildable index). Local-only.

=> We borrow OB1's _concepts and pipeline shapes_, invert its storage assumption, drop all hosting/transport. ~80% of OB1's value (data model, dedup, provenance/trust, synthesis, retrieval logic) is pure app/SQL logic and ports cleanly. The cloud-locked ~20% (Edge Functions, RLS, hosted Supabase, OpenRouter network calls) we replace or cut.

## Design values (seed — confirm/edit)

- Pragmatically balanced. Token-efficient but not obsessed. Right tool for the job.
- Tool split: **Rust CLI** (deterministic, hot-path, cheap) vs **LLM agent actions** (synthesis, extraction) vs **skills/prompt templates** (repeatable agent behaviors). Push deterministic work down to code.
- Continual iteration. Start dumb, measure, harden.
- Local-first, low complexity to start. No docker, no daemons-if-avoidable. Simple scripts + local file DB.

---

## Concept chunks + decisions

### 1. Source of truth & layering

- OB1: single `thoughts` row = atom; DB is canonical.
- Us: `notes/*.md` (OKF concept files) canonical; derived layer = `.db/` (FTS + vector + graph edges), fully rebuildable.
- 3-layer model (from knowledge-catalog notes): reference/raw -> curated concept notes -> derived indexes.
- DECISION: confirm files-as-truth. Then every chunk below is "how do we project files into a derived store and back."
- OPEN Q: do atoms live as individual files (1 atom = 1 file, fine-grained, OKF-ish) OR as sections inside larger concept notes (human-readable, fewer files)? OB1 atoms are tiny (1-2 sentences, <280 chars). Files-as-truth + tiny atoms = file explosion. Likely: **concept notes are the file unit; atoms are a derived/extracted granularity** in the DB. Needs design.

### 2. Knowledge atom / data model

- OB1 `thoughts`: `id, content, embedding vector(1536), metadata JSONB, content_fingerprint`, + promoted cols (type, importance 1-5, quality, sensitivity, status). Type allow-list (~8: idea/task/person_note/reference/decision/lesson/meeting/journal).
- Maps directly to OKF frontmatter (`id, kind, title, tags, source, created, updated` + body).
- Enrichment precedence (good design, port): structured-hint > caller > LLM-extracted > default.
- DECISION: define our canonical note frontmatter (extend the OKF sketch in knowledge-catalog-patterns.md with: type/kind, importance, quality, sensitivity, status, provenance fields).
- OPEN Q: how much typed schema day 1 vs let it grow. Lean: minimal frontmatter, JSON "extra" escape hatch, promote fields to columns in derived DB only when a query needs them.

### 3. Embeddings + vector search

- OB1: OpenAI `text-embedding-3-small` 1536-dim, pgvector HNSW, cosine `match_thoughts` RPC.
- Local options:
  - **Embeddings:** Ollama (nomic-embed 768 / mxbai 1024 / gte-qwen2 1536). OB1 already has `local-ollama-embeddings` recipe proving the swap. Or skip embeddings at start (FTS-only), add later.
  - **Vector store:** `sqlite-vec` (SQLite ext, simplest, single-file) vs DuckDB VSS vs local pgvector (heavier). Lean **sqlite-vec** for low complexity.
- HARD GOTCHA (flagged by 2 scouts): embedding **dim is baked into the column** — changing model = full re-embed. Pick dim deliberately; store model+dim in metadata; make re-embed a first-class rebuild op.
- OPEN Q: do we even need vectors at v1? Andrej gist says index.md + grep works to ~100s of pages. Lean: **FTS-first, vectors as an opt-in derived layer.**

### 4. Lexical / full-text + fuzzy search

- OB1: Postgres tsvector + pg_trgm (trigram) GIN, blended rank, 2-phase tsvector+ILIKE.
- Local: **SQLite FTS5** (lexical) covers most of it; trigram fuzzy via FTS5 or a small ext. DuckDB FTS as alt.
- Lean: FTS5 is the v1 retrieval backbone. Cheap, deterministic, Rust-CLI-able.

### 5. Ingestion pipeline

- OB1 spine (reference: `integrations/smart-ingest`): parse/normalize -> signal-filter -> LLM atomic extraction -> per-atom {embed, fingerprint} -> reconcile/dedup -> **dry-run job** -> upsert -> entity extraction. See appendix doc for full detail.
- Reusable regardless of backend: job model + **dry-run preview before write**, cost ceilings, CAS guard, idempotent/resumable + sync-log per source.
- Tool split: parsing/fingerprint/dedup/job-mgmt = **Rust CLI** (deterministic, cheap). Atomic extraction = **LLM**.
- OPEN Q: for a files-as-truth system, "upsert" = write/patch a markdown file + reindex. Need to define the write-back contract (which file, append vs revise).
- Patterns to consider here (not decided): agent writes proposed changes to an `inbox/`/staging area + human reviews git diffs before merge (a "human git gate"); schema-validate frontmatter _before_ writing to disk and bounce non-conforming output back for correction. Both echo OB1's dry-run/job model. Surfaced by external survey; evaluate, don't adopt yet.

### 6. Dedup (two independent layers — keep both)

- **Sync-log** = "seen this _source record_ before?" (per-source-id, app-level, cheap). Defends webhook/import retries.
- **Content fingerprint** = SHA-256 of normalized content (`trim->collapse-ws->lowercase->hash`; stronger variant strips punct/possessive/plural). Exact-dup idempotency via unique index + upsert. **Most portable primitive in the whole repo** — zero cloud coupling.
- **Semantic dedup** (needs vectors): 3-stage cascade, thresholds >0.92 skip / 0.85-0.92 richness-compare (append_evidence vs create_revision) / <0.85 add. **Fail-closed** (skip on uncertainty), never fail-open-add.
- Lean: fingerprint + sync-log in Rust CLI from day 1. Semantic dedup later w/ vectors.

### 7. Atomization / extraction

- LLM splits multi-topic text into atomic self-contained thoughts (better embed/retrieve). Strict JSON output, type clamp, quality gate (drop <30 chars / low importance), caps.
- Heuristic pre-pass (atomizer recipe): detect compound text (sentence count, enumeration, conjunctions) _before_ spending an LLM call.
- Prompt-injection hardening (KEEP): wrap untrusted input in `<document>` tags, defang closing tags, "tags are data not instructions," schema-validate output. (Also satisfies our org guidance on untrusted external content.)
- OPEN Q: atomize aggressively (OB1 style) vs keep human-authored note granularity and only extract entities/claims. Ties to chunk #1.

### 8. Entity / knowledge graph

- OB1: entities + edges + thought_entities + extraction queue + consolidation log; auto-queue trigger; **typed reasoning edges** (supports/contradicts/supersedes, temporal validity, decay); traversal via **recursive CTE / BFS in SQL — no graph DB needed**.
- Provenance chains: `derived_from` lineage, recursive CTE to trace ancestry.
- Local: all of this is plain SQL (recursive CTEs work in SQLite + DuckDB) + markdown backlinks. No Neo4j.
- Lean: start with markdown links/backlinks as the graph; add typed edges table in derived DB when needed. Edge classification = cheap-model-filter -> strong-model cascade.

### 9. Provenance / trust / governance (the conceptually richest part)

- OB1 "Agent Memory" layer (`safe-agent-memory-provenance.md`): every memory carries **provenance status** (observed/inferred/user_confirmed/imported/generated/superseded/disputed), **trust ladder** ("memory is evidence, not instruction"), use-policy, scope rules, **review queue**, **recall traces** (why was this surfaced).
- Explicitly storage-agnostic (clean JSON contracts; docs even sanction a future SQLite mirror) => ports cleanly.
- Lean: adopt provenance status + trust-as-evidence + review queue as frontmatter fields + a derived review table. High value for an LLM-written wiki (guards hallucinated/auto-generated claims). Strong fit with OKF citations + grounding evals.

### 10. Synthesis / wiki compilation

- OB1 recipes: wiki-compiler, wiki-synthesis, entity-wiki, daily/weekly digest, dossiers — all **regenerable views** over atoms (explicit Karpathy "LLM-wiki" framing — same as our seed).
- TRAP (flagged): don't index synthesized summaries back into default retrieval (search pollution / feedback loop). Keep generated views in a separate namespace.
- Lean: synthesis = LLM agent op writing markdown pages; mark generated pages distinctly; exclude from re-ingest by default.

### 11. Retrieval / query / recall

- OB1: query embed -> vector search; recency-boosted match (`sim*(1-w) + exp(-age/halflife)*w`); schema-aware-routing (route query to right tables); discovery decomposition (subqueries -> multi-index -> rerank).
- Local: FTS5 + (opt) vectors + recency + tag/graph-distance reranking. Decomposition/rerank = LLM or simple heuristics.
- Lean: index.md + FTS first (per Andrej gist), layer hybrid rerank later.

### 12. Health / lint

- OB1: lint-sweep, brain-health-monitoring, smoke-test — contradiction detection, orphans, stale claims, dup review. Tiered: free SQL/graph checks first, capped LLM last.
- Lean: cheap deterministic checks (orphans, broken links, missing backlinks, stale dates) in Rust CLI; LLM only for contradiction/synthesis-quality. Matches Andrej "lint" op.

### 13. Interface / agent access

- OB1: MCP server (6 tools: search/fetch/search*thoughts/list_thoughts/thought_stats/capture_thought) as Supabase Edge Function over HTTP; shared-key auth; CLAUDE.md \_forbids* local MCP. ChatGPT connectors need remote HTTPS (conflicts w/ local-only).
- Us: options =
  - **Local MCP stdio server** (drops HTTP/CORS/auth entirely) — clean for Claude Code / Cursor / pi.
  - **Rust CLI** the agent shells out to (simplest, no server, token-cheap, fits our values).
  - Skills + prompt templates for repeatable agent workflows.
- Lean: **Rust CLI first** (search/capture/dedup/index/lint as subcommands), add a thin stdio MCP wrapper if/when a client needs it. ChatGPT remote connector = likely **non-goal** for local-only.

### 14. Capture adapters

- OB1: Slack/Discord/Telegram/Readwise = inbound webhooks (need reachable endpoint) + embed + classify + source-id dedup + insert + reply. Plus many export-file importers (ChatGPT/Obsidian/Gmail/X/etc).
- Local-first: webhooks need a public endpoint = friction. Prefer **pull/poll** (cron + API token) or **export-file import** (already local-friendly). Export importers' parser logic (branch resolution, session-split, signal filter, pyramid summaries) is portable.
- Lean: start with file/export import + Obsidian vault import; defer live webhook capture.

### 15. Sensitivity gating

- OB1: regex tiers (standard/personal/restricted); restricted (SSN/cards/keys) blocked from cloud; escalation-only.
- Local: in fully-local system "block from cloud" -> "never send to remote model." Still a routing signal (local-only model vs cloud model). Cheap regex at capture.
- Lean: keep tier concept; default everything local; tag restricted to bar any future cloud calls. (Aligns with org data-handling guidance.)

### 16. Skills / extensions / packaging

- OB1: **skills** = plain-text prompt packs (`SKILL.md` + `metadata.json`), tool-agnostic, cross-referencing — port nearly as-is. **Extensions** = agent-generatable 5-file modules adding sidecar tables + an Edge Function (cloud-heavy). Composition at agent layer, not FK graph.
- Lean: adopt skill packaging (fits pi skills + prompt templates). Extensions concept = domain schema add-ons; reframe as derived-view extensions over files, drop Edge Function + RLS.

### 17. Dashboards / UI

- OB1: SvelteKit (direct Supabase) + Next.js 16/React 19 (thin client over brain HTTP API, 8 pages: search/ingest/audit/dupes/kanban/agent-memory/thoughts) + static landing.
- Local: Obsidian _is_ the primary UI per Andrej gist (graph view, backlinks, Dataview on frontmatter). A dashboard is optional.
- Lean: **Obsidian as the read UI** v1; maybe a tiny local static viewer later. No web app to start.

### 18. Cost / model tiering

- OB1: tiered cost everywhere — free SQL/graph checks first, capped LLM last; cheap-model-filter -> strong-model-classify cascade. Works with local models too.
- Lean: bake this in. Deterministic-first, cheap-model-second, strong-model-last. Matches our token-pragmatism value.

---

## Cloud dep -> local replacement (cheat sheet)

| OB1 cloud piece                | Used for                    | Local replacement                                           |
| ------------------------------ | --------------------------- | ----------------------------------------------------------- |
| Supabase Postgres + pgvector   | storage + vector            | files-as-truth + SQLite(+sqlite-vec) / DuckDB derived index |
| Supabase Edge Functions (Deno) | hosting MCP/REST            | Rust CLI + optional local stdio MCP                         |
| Postgres RLS / auth.users      | multi-user isolation        | drop (single-user)                                          |
| OpenRouter                     | embeddings + LLM extraction | Ollama local (or user-chosen API, gated by sensitivity)     |
| Inbound webhooks               | live capture                | pull/poll + export-file import                              |
| Next/Svelte dashboards         | UI                          | Obsidian (+ optional static viewer)                         |

## Tech stack decisions to make (the agenda)

1. **DB:** SQLite (+FTS5 +sqlite-vec) vs DuckDB vs both? (Lean SQLite for low-complexity single-file; DuckDB if we want analytical scans over metadata.)
2. **Embeddings at v1?** yes/no; if yes which Ollama model + dim (one-way door).
3. **Atom granularity:** file-per-concept-note vs file-per-atom vs hybrid (note=file, atom=derived). (Chunk #1 — biggest design fork.)
4. **Interface:** Rust CLI vs local MCP vs both, and ordering.
5. **Write-back contract:** how agent edits files (append/revise/supersede) + reindex trigger. Candidate patterns to weigh (open): `inbox/`-staging + human git-diff gate; schema-validate-before-write w/ correction loop.
6. **How much provenance/trust day 1.**
7. **Language for the CLI:** Rust (stated preference) — confirm; or start scripts then port hot paths.

## Open risks / notes

- File explosion if we copy OB1's tiny-atom model into files-as-truth. Resolve granularity early.
- Embedding dim lock-in. Treat re-embed as a planned rebuild.
- Don't index synthesized/generated pages into default retrieval.
- `entity-wiki` recipe depends on unmerged OB1 PRs; entity-extraction is partly aspirational in their `main`.
- Failure modes to design against (plausible, surfaced by external survey — treat as hypotheses, not documented evidence): **semantic drift / "fluff accumulation"** — unsupervised LLM rewrites compress crisp notes into wordy AI-prose over time; **synonym page duplication** — agent creates `Large Language Models` when `LLMs` already exists, fracturing the graph; **frontmatter corruption** — LLM edits break YAML (unescaped colons, unquoted specials, invented fields). Bears on the edit-in-place vs regenerate fork + lint design (#10, #12).
