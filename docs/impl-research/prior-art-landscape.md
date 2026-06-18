---
type: "AI-synthesis"
title: "Prior-Art Landscape"
description: "Map of the design space: concept/architecture taxonomy (13 axes), the three reference approaches (OKF/Andrej/Nate) with master comparison, 12 shipping-tool instances, and decision-neutral domain observations."
---

# Prior-Art Landscape

> **Layer 1 · `reference`** — a _decision/requirement-neutral_ map of the design space and the tools in it. It describes the forks, the archetypes, and the _inherent_ trade-offs **without advocating a choice** for us or any persona. Opinion, recommendations, "what to steal," and per-requirement verdicts live in Layer 2 (see [`lens-WIP.md`](lens-WIP.md)).
>
> "Decision-neutral" ≠ "unopinionated": the selection of axes and the framing of trade-offs embed analysis. What's banished here is _advocacy_ — steal/avoid, borrow-vs-build, niche verdicts, persona recommendations.

**Date:** 2026-06-18. Scope: shipping local-first / LLM-managed PKM & agent-memory tools that solve the same value prop — a knowledge base where an LLM does the bookkeeping and knowledge compounds — plus the three reference _approaches_ (OKF / Andrej / Nate) that frame the space.

**Companion docs:** [`index.md`](index.md) (catalog) · [`working-notes.md`](working-notes.md) (conventions + assumptions) · [`lens-WIP.md`](lens-WIP.md) (Layer 2: our opinions/recommendations, parked & unorganized) · [`okf-andrej-nate-comparison.md`](okf-andrej-nate-comparison.md) (superseded — its reference content is merged here) · source artifacts: [`andrej-wiki-gist.md`](andrej-wiki-gist.md), [`nate-post-open-brian.md`](nate-post-open-brian.md), [`knowledge-catalog-patterns.md`](knowledge-catalog-patterns.md).

### Verification legend

- ✅ **verified** — confirmed at primary source (repo README / official docs / arxiv) fetched directly during this survey.
- 🟡 **partial** — core confirmed at primary, but some fields rest on secondary sources / marketing not cross-checked against code.
- ⬜ **unverified** — secondary only.

Discipline note (learned from the failed Gemini run, `0004`): every factual claim carries a primary link; no synthesized "representative" quotes; abandoned projects flagged; marketing claims that the code/README contradicts are called out explicitly.

---

## 1. Formats, workflows, and full implementations

In research we've found three different layers:

- **_Format spec_.** e.g. **OKF** "Knowledge as a vendor-neutral bundle of markdown + YAML frontmatter + links." Says nothing about workflow, retrieval, or who writes it. _Substrate only._
- **_Workflow pattern_ / philosophy.** e.g. **Andrej's LLM-wiki gist** "LLM incrementally maintains a living, interlinked markdown wiki you curate." A way of working; storage is just files; tooling is deliberately optional/modular. _Operating model._
- **A deployable implementation** e.g. **Nate (OB1)** "Postgres + pgvector + MCP server so every AI can query your captured thoughts." Opinionated stack, cloud-coupled. _Built product._

So OKF answers _what the files look like_, Andrej _how the LLM and human can collaborate and curate knowledge_, Nate _how agents access it across tools_. They are largely **complementary layers**. The shipping tools surveyed below each pick points along the same axes.

### Reference-approach comparison

| Axis                       | OKF (format)                          | Andrej (workflow)                                    | Nate / OB1 (system)                                                |
| -------------------------- | ------------------------------------- | ---------------------------------------------------- | ------------------------------------------------------------------ |
| **What it is**             | File format spec                      | Working pattern                                      | Built product/stack                                                |
| **Source of truth**        | Files                                 | Files                                                | **Database** (Postgres)                                            |
| **Unit of knowledge**      | Concept doc (1 file = 1 concept)      | Wiki page (entity / concept / summary)               | **Atomic thought** (1–2 sentences, <280 chars)                     |
| **Granularity**            | Page-level                            | Page-level (human-readable)                          | Sub-sentence atoms (embed-optimized)                               |
| **Who authors**            | Agnostic                              | LLM writes, human curates/directs                    | Capture pipeline auto-extracts; LLM classifies                     |
| **Human's role**           | n/a (it's a format)                   | Curator, director, question-asker                    | Ambient capturer ("dump thoughts")                                 |
| **Synthesis model**        | None (static format)                  | Edit-in-place living document                        | Regenerable views over atoms (wiki = disposable projection)        |
| **Retrieval**              | None specified                        | `index.md` + grep first; optional hybrid (qmd) late  | Embeddings mandatory; semantic vector central                      |
| **Embeddings**             | —                                     | Optional / deferred                                  | Required / load-bearing                                            |
| **Dedup & consistency**    | — (permissive conformance)            | Periodic LLM **lint** pass                           | Engineered: fingerprint + semantic dedup + reconcile + job/dry-run |
| **Metadata / provenance**  | Frontmatter fields (medium)           | Light frontmatter + `log.md`                         | Heavy: type/importance/quality/sensitivity/provenance/trust        |
| **Agent interface**        | MCP optional                          | Single agent + Obsidian; optional CLI                | MCP server, multi-tool (headline feature)                          |
| **Locality**               | Local                                 | Local-first                                          | Cloud-coupled (Supabase + OpenRouter + Slack)                      |
| **Navigation aids**        | `index.md` (progressive disclosure)   | `index.md` (content) + `log.md` (chronological)      | stats / list tools + dashboards                                    |
| **Primary problem solved** | Knowledge **portability/interchange** | **Synthesis & compounding** (beat RAG re-derivation) | **Cross-tool agent memory access**                                 |
| **Scale target**           | Any                                   | ~100s sources / hundreds of pages                    | Unbounded atom stream                                              |

Sources for this table: OKF — [`knowledge-catalog-patterns.md`](knowledge-catalog-patterns.md); Andrej — [`andrej-wiki-gist.md`](andrej-wiki-gist.md); Nate — [`ob1-synthesis.md`](ob1-synthesis.md), [`ob1-ingestion-recon.md`](ob1-ingestion-recon.md), [`nate-post-claims-audit.md`](nate-post-claims-audit.md).

---

## 2. Concept / architecture taxonomy — the design space

The axes below define the space. They are descriptive: every tool sits _somewhere_ on each. The first eight are the "core forks" that distinguish PKM/memory architectures; the last five are cross-cutting axes that matter to deployment and adoption (cost, residency, multi-user, setup, maturity).

**Core architecture forks**

1. **Source of truth.** Files-on-disk · database-as-canonical · **DB-as-index** (files stay on client but the working copy is an indexed DB — a middle ground, e.g. Khoj). Determines portability, rebuildability, and what "your data" physically is.
2. **Unit / granularity.** Whole document/page · concept doc (1 file = 1 concept) · sub-sentence **atom** · embedding **chunk**. A files-as-truth + tiny-atom combination produces file explosion; a common resolution is _page on disk, atom/chunk as a derived granularity in the index._
3. **Synthesis model.** **Edit-in-place** living document (pages revised, contradictions noted inline) · **regenerate** disposable views from sources · **none** (read/index-only) · **memory-evolution** (new entries rewrite the attributes/links of old ones). Each implies a different consistency burden: living docs drift without linting; regenerated views are always fresh but the atom store needs dedup hygiene.
4. **Retrieval.** Keyword/FTS · semantic vector · graph traversal over links · hybrid (weighted FTS+vector) · two-stage retrieve→rerank. Orthogonal sub-axis: **embeddings deferred vs mandatory** — `index.md`+grep scales to ~100s of pages with no vector infra; semantic-first designs make embeddings load-bearing.
5. **Authoring / capture.** Curated source ingest (deliberate, one-at-a-time) · ambient capture (dump everything) · conversation-driven (AI writes during chat) · manual authoring. A stance on the human's role, and on whether "just dump it" is wise.
6. **Agent interface.** MCP (stdio/loopback or hosted) · HTTP API · SDK/library · editor plugin · none. Sub-axis: **local stdio/loopback** vs **hosted HTTP server**.
7. **Locality.** Fully local · local-first · self-hosted server · cloud-coupled. Independent sub-axis: **local vs cloud models** (a tool can be local-data + cloud-reasoning).
8. **Provenance / trust.** None · source citations only · typed edges / ontology · **trust ladder** (observed / inferred / confirmed / generated / disputed) · versioning (e.g. git-backed). Tracks how much an LLM-authored claim can be audited.

**Cross-cutting deployment axes**

9. **Cost model.** Free/OSS · freemium (paid cloud sync) · API/inference cost only · paid product.
10. **Data residency / compliance.** Local-only · self-host (data stays in your infra) · cloud (data leaves the device).
11. **Auth / multi-user.** Single-user · multi-user/team · multi-device sync (incl. CRDT).
12. **Setup friction.** App install (one-click) · editor plugin · CLI / dev tool · server + DB (Docker).
13. **Maturity / licensing.** Activity & age signal; license class (permissive MIT/Apache vs copyleft AGPL/GPL) gates redistribution.

### Shared DNA (convergence across the space)

Decision-neutral observation: independent of the forks above, the field converges on five things.

1. **Markdown as the human-readable substrate** — even DB-as-truth systems (Nate) generate markdown _views_.
2. **The LLM does the bookkeeping** — extraction, summarizing, cross-referencing, filing. None expect the human to do it.
3. **Raw vs curated/derived separation** — immutable sources kept distinct from synthesis (OKF reference-layers; Andrej raw/wiki/schema; Nate raw thought + regenerated views).
4. **An index/navigation layer** — `index.md`, stats/list tools, dashboards.
5. **The compounding thesis** (Karpathy "LLM-wiki" framing) — knowledge accumulates into a persistent artifact instead of being re-derived per query. OKF is silent (just a format) but compatible.

### Timeline signal

Karpathy's April-2026 "LLM wiki" gist (the seed idea) spawned a wave within ~2 months: `nashsu/llm_wiki` went idea → 11.9k-star shipping product by mid-June 2026. The broad niche moved from empty to crowded and validated inside a quarter.

---

## 3. Tool instances mapped onto the axes

Cells abbreviated; see per-tool entries for nuance + citations. Axes 1–8 are the core forks; the deployment columns (cost / residency / multi-user / setup / maturity+license) are summarized in [§4](#4-deployment-axes-cross-cutting).

| Tool                  | Category                      | Source of truth                | Unit                                               | Synthesis                      | Retrieval                                         | Local + local models                            | Agent interface                               | Capture                   | Provenance/trust                     | Alive?                     | Verif                              |
| --------------------- | ----------------------------- | ------------------------------ | -------------------------------------------------- | ------------------------------ | ------------------------------------------------- | ----------------------------------------------- | --------------------------------------------- | ------------------------- | ------------------------------------ | -------------------------- | ---------------------------------- |
| **Basic Memory**      | Files-as-truth PKM + MCP      | **Files** (md)                 | Note = entity; observations + relations parsed out | **Edit-in-place**              | FTS + vector + graph                              | Local-first; FastEmbed local                    | **MCP** (read/write/edit/move + schema tools) | Conversation-driven       | Light (frontmatter); schema validate | ✅ v0.22.1, Jun 2026       | ✅                                 |
| **nashsu/llm_wiki**   | LLM-maintained wiki (desktop) | **Files** (raw/wiki/schema)    | Wiki page (entity/concept/source)                  | **Regenerate** (2-step ingest) | Keyword + opt. vector (LanceDB) + graph expansion | Fully local; any OpenAI-compatible incl. Ollama | HTTP API + **local MCP** + agent skill        | Curated source ingest     | none explicit                        | ✅ v0.4.25, Jun 18 2026    | ✅                                 |
| **Khoj**              | Personal-AI search/chat       | **DB index** (files synced in) | Doc chunk                                          | **None** (read-only)           | Bi-encoder vectors + cross-encoder rerank         | Self-host; local HF embeddings + local LLM      | Obsidian/Emacs/desktop/web/API                | Sync from clients         | none                                 | ✅ 35k★, active            | ✅ (license unconfirmed in README) |
| **Reor**              | Local AI notes (desktop)      | **Files** (1 dir)              | Note, chunked                                      | Edit (manual)                  | Vector (LanceDB) auto-link + RAG                  | Fully local; Ollama + Transformers.js           | Desktop app only                              | Manual md authoring       | none                                 | ❌ **archived 2026-03-07** | ✅                                 |
| **sqlite-memory**     | Agent memory (md→SQLite)      | **DB** (`.db`); md is I/O      | Chunk (512 tok)                                    | none                           | **Hybrid** FTS5 + vector, weighted                | Local; llama.cpp local embeddings               | SQL ext + CLI + MCP                           | agent writes              | none                                 | ✅ v1.3.5, Jun 2026        | ✅ (truth-model flagged)           |
| **Mem0**              | Agent memory layer            | **DB** (vector+graph+kv)       | Extracted "memory" fact                            | Regenerate/update              | Semantic + BM25 + entity                          | Self-host (Docker); local models                | SDK/REST/CLI/skills                           | Auto-extract from chat    | none (ADD-only as of Apr 2026)       | ✅ 58.9k★, active          | ✅                                 |
| **Letta (MemGPT)**    | Stateful agent runtime        | **DB**                         | Memory block / archival item                       | Agent-managed                  | Vector (agentic retrieval)                        | Self-host; local models                         | SDK/API/ADE                                   | Agent-driven              | versioned (git-backed memory)        | ✅ 21k★, active            | 🟡                                 |
| **Cognee**            | Agent memory (KG)             | **DB** (graph+vector+rel)      | Entity + typed edge                                | ECL pipeline (rebuild)         | 14 modes; graph + vector, auto-route              | Self-host; local LLM                            | Python lib + CLI + MCP                        | `remember()` ingest       | ontology/typed edges                 | ✅ 17.9k★, active          | ✅                                 |
| **AnythingLLM**       | Local RAG desktop/app         | **Vector DB** (docs ingested)  | Doc chunk                                          | none (chat only)               | Vector RAG                                        | Local-by-default; Ollama/LMStudio               | Desktop app + no-code agents                  | Upload docs               | citations only                       | ✅ 61.8k★, active          | ✅                                 |
| **Smart Connections** | Obsidian plugin               | **Files** (your vault)         | Note / block                                       | none (surface links)           | Local embeddings (semantic)                       | Local; on-device embed model                    | Obsidian plugin                               | n/a (over existing vault) | none                                 | 🟡 active                  | 🟡                                 |
| **Obsidian Copilot**  | Obsidian plugin               | **Files** (your vault)         | Note                                               | none (chat/RAG)                | RAG over vault + local embed                      | Local; Ollama native                            | Obsidian plugin                               | n/a                       | none                                 | 🟡 active                  | 🟡                                 |
| **A-MEM** (research)  | Academic memory system        | n/a (paper)                    | Zettelkasten "memory note"                         | **Memory evolution**           | Embedding + autonomous links                      | n/a                                             | n/a                                           | agent interactions        | none                                 | 🟡 NeurIPS 2025            | 🟡                                 |

---

## 4. Deployment axes (cross-cutting)

Decision-neutral mapping of each tool onto the deployment forks (axes 9–13). No verdicts — those are persona-dependent and live in Layer 2.

| Tool                  | Cost model                        | Data residency                                         | Auth / multi-user                    | Setup friction                         | License                                   | Maturity signal                              |
| --------------------- | --------------------------------- | ------------------------------------------------------ | ------------------------------------ | -------------------------------------- | ----------------------------------------- | -------------------------------------------- |
| **Basic Memory**      | OSS + optional $15/mo cloud sync  | Local-only (cloud sync optional: hosted Postgres + S3) | Single-user; cloud adds cross-device | Local MCP server install               | **AGPL-3.0**                              | v0.22.1, 86 releases, ~1,481 commits, Python |
| **nashsu/llm_wiki**   | OSS; bring-your-own API key       | Local-only                                             | Single-user desktop                  | One desktop app install                | **GPL-3.0**                               | 11.9k★, 1.4k forks, v0.4.25 (Jun 18 2026)    |
| **Khoj**              | OSS self-host + paid cloud        | Self-host (local) or cloud (data leaves)               | Multi-user/server                    | Server + DB (Docker)                   | reported AGPL-3.0 (unconfirmed in README) | ~35k★, active                                |
| **Reor**              | OSS                               | Local-only                                             | Single-user desktop                  | Desktop app install                    | AGPL-3.0                                  | ❌ archived 2026-03-07                       |
| **sqlite-memory**     | OSS                               | Local                                                  | Block-level LWW-CRDT multi-agent     | SQL ext / CLI (dev)                    | MIT                                       | 70★, v1.3.5 (Jun 2026)                       |
| **Mem0**              | OSS self-host + cloud             | Self-host or cloud                                     | Multi-user (SDK)                     | Python + infra                         | Apache-2.0                                | 58.9k★, 343 releases, active                 |
| **Letta**             | OSS self-host + cloud             | Self-host or cloud                                     | Multi-agent runtime                  | Server/SDK                             | Apache-2.0 (reported)                     | ~21k★, active                                |
| **Cognee**            | OSS self-host + cloud             | Self-host or cloud                                     | Multi-user                           | Python + DBs                           | Apache-2.0                                | 17.9k★, v1.1.3 (Jun 2026)                    |
| **AnythingLLM**       | OSS (desktop free; Docker server) | Local (desktop) or self-host (server)                  | Desktop single / server multi-user   | Desktop one-click **or** Docker server | MIT                                       | 61.8k★, active                               |
| **Smart Connections** | OSS plugin                        | Local (your vault)                                     | Single-user                          | Obsidian plugin                        | (plugin)                                  | active 🟡                                    |
| **Obsidian Copilot**  | OSS plugin                        | Local (your vault)                                     | Single-user                          | Obsidian plugin                        | (plugin)                                  | active 🟡                                    |
| **A-MEM**             | research                          | n/a                                                    | n/a                                  | n/a                                    | n/a                                       | NeurIPS 2025 paper                           |

---

## 5. Tool entries (descriptive)

Each entry: what it is, where it sits on the axes, and its _inherent_ trade-offs/limits. Patterns worth borrowing and per-tool verdicts are deliberately omitted here — they're in [`lens-WIP.md`](lens-WIP.md).

### 5.1 Basic Memory — files-as-truth PKM + native MCP ✅

**Link:** <https://github.com/basicmachines-co/basic-memory> · docs <https://docs.basicmemory.com/>

**What it is:** "AI conversations that actually remember." Knowledge is plain Markdown files on disk ("Plain text on your disk. Forever."). Each file is an _Entity_ with YAML frontmatter (`title`, `type`, `permalink`, `tags`). AI and human write to the same files; a sync process keeps the derived index in step ("Two-way. AI and humans write to the same files; sync keeps them in step.").

**Axis placement:**

- **Source of truth:** files (markdown); index (SQLite/Postgres) is derived.
- **Unit/granularity:** note = entity (page-level), **but** atomic structure is parsed from the body: **Observations** = atomic facts tagged `[category]` (e.g. `[fact]`, `[method]`) + optional hashtags; **Relations** = wiki-style typed links (`relation_type [[Target]]`; bare `[[X]]` → `links_to`). Page-on-disk **plus** atom/edge granularity in the derived graph.
- **Synthesis:** edit-in-place — "Edits happen directly in-place — no regeneration cycles."
- **Retrieval:** three parallel paths — full-text (SQLite/Postgres), semantic vector (FastEmbed), graph traversal over relations (`build_context` walks `memory://` URLs link-by-link).
- **Local + models:** local-first; local FastEmbed embeddings; optional paid cloud ($15/mo, hosted Postgres + S3) for cross-device sync.
- **Agent interface:** MCP-native — `write_note`, `read_note`, `edit_note`, `move_note`, `delete_note`, `search`, `build_context`, `canvas`, plus `schema_infer` / `schema_validate` / `schema_diff`. Tools carry MCP behavior hints (`readOnlyHint`, `destructiveHint`, `idempotentHint`).
- **Capture:** conversation-driven — the AI writes notes as you chat.
- **Maturity/license:** v0.22.1 (2026-06-13), 86 releases, ~1,481 commits, Python; **AGPL-3.0** (local).

**Inherent trade-offs / limits:** its format is _its own_ observations/relations DSL, **not OKF** — interop is on its terms. Capture is chat-centric (no first-class curated ingest of external PDFs/sources). AGPL-3.0 is copyleft (matters for redistribution).

### 5.2 nashsu/llm_wiki — LLM-maintained wiki from sources ✅

**Link:** <https://github.com/nashsu/llm_wiki>

**What it is:** "A cross-platform desktop application that turns your documents into an organized, interlinked knowledge base — automatically… Instead of traditional RAG… the LLM incrementally builds and maintains a persistent wiki from your sources." A direct implementation of the Karpathy/Andrej pattern.

**Axis placement:**

- **Source of truth:** files, in a **3-layer model**: `raw/sources/` (immutable inputs) → `wiki/` (LLM-generated `index.md`, `log.md`, `overview.md` + entity/concept/source subdirs) → `schema.md` + `purpose.md`. The `wiki/` dir is an Obsidian vault using `[[wikilinks]]` + YAML frontmatter.
- **Unit/granularity:** wiki page (entity / concept / source summary), human-readable.
- **Synthesis:** **regenerate** — two-step ingest (analyze source → generate wiki files) with a "SHA256 incremental cache" that skips unchanged sources and a "guaranteed source summary" coverage check. The wiki is a derived projection of sources, not an edit-in-place living narrative.
- **Retrieval:** multi-phase — tokenized keyword search (CJK bigram support), optional vector semantic search via **LanceDB**, and **graph expansion using a 4-signal relevance model** (direct links, source overlap, Adamic-Adar, type affinity), with configurable context budgets (4K–1M tokens).
- **Local + models:** fully local (Tauri desktop), optional local MCP server at `127.0.0.1:19828`, any OpenAI-compatible LLM incl. Ollama.
- **Agent interface:** HTTP API + local MCP server + installable agent skill (`npx skills add …/llm_wiki_skill.git`).
- **Capture:** curated source ingest (drop docs into `raw/`).
- **Maturity/license:** **GPL-3.0**, 11.9k★, 1.4k forks, v0.4.25 (2026-06-18).

**Inherent trade-offs / limits:** the **regenerate** model means the wiki is disposable — no living, hand-edited narrative that accrues human edits. GPL-3.0 desktop Tauri app (a product, not a composable CLI/library). No provenance/trust layer. Frontmatter conventions are its own (not OKF).

### 5.3 Khoj — personal-AI search/chat (read-only) ✅

**Link:** <https://github.com/khoj-ai/khoj> · docs <https://docs.khoj.dev/>

**What it is:** "Your AI second brain. Self-hostable. Get answers from the web or your docs… Turn any online or local LLM into your personal, autonomous AI." Multi-client: Browser, Obsidian, Emacs, Desktop, Phone, WhatsApp.

**Axis placement:**

- **Source of truth:** **DB index**, not files. Clients sync your files into a server-side store Khoj indexes ("re-index all your documents"; admin `SearchModelConfig`). Files remain on your client, but Khoj's working copy is the indexed DB — **DB-as-index** (milder than DB-as-canonical).
- **Unit/granularity:** document chunk.
- **Synthesis:** **none** — retrieves & chats; does not author or maintain a wiki (no write-back described in the README).
- **Retrieval:** semantic — bi-encoder "meaning vectors" of documents and queries, then a cross-encoder re-ranks. Two-stage retrieve→rerank.
- **Local + models:** self-hostable; **local HF/sentence-transformers embeddings by default**; any local or online LLM (llama3/qwen/gemma/mistral/gpt/claude/gemini/deepseek).
- **Agent interface:** Obsidian/Emacs plugins, desktop, web, API; custom agents + scheduled automations + deep research.
- **Maturity/license:** ~35k★, active. License **not stated in the fetched README** (widely reported AGPL-3.0 — unconfirmed at primary here).

**Inherent trade-offs / limits:** DB-as-index + read-only = a retrieval layer, not a compounding living artifact; no synthesis, edit-in-place, or provenance. Self-host is heavier (server + DB, Docker); cloud option means data leaves the device.

### 5.4 Reor — local AI notes (desktop) ✅ — ⚠️ archived

<https://github.com/reorproject/reor> — AGPL-3.0. "Reor works within a single directory in the filesystem"; "Every note you write is chunked and embedded into an internal vector database" (**LanceDB**); "Related notes are connected automatically via vector similarity"; RAG Q&A; local LLMs/embeddings via Ollama + Transformers.js; Obsidian-like editor. **Archived by the owner on 2026-03-07, now read-only.** A files-on-disk + local-vector + auto-link PKM that did not survive (single-maintainer desktop app, narrow differentiation).

### 5.5 Mem0 — agent memory layer ✅

<https://github.com/mem0ai/mem0> — Apache-2.0, 58.9k★, active (343 releases). "Universal memory layer for AI Agents." **DB-as-truth** (vector + graph + key-value; Qdrant in self-host). LLM extracts "memories" from chat; hybrid retrieval = "semantic, BM25 keyword, and entity matching." The April-2026 algorithm is "Single-pass ADD-only extraction" with "no UPDATE/DELETE" — memories accumulate without overwriting. Library / self-hosted Docker / cloud; SDKs + REST + CLI + agent skills. _Inherent trade-off:_ ADD-only trades dedup/edit hygiene for simplicity — accumulation is unbounded.

### 5.6 Letta (formerly MemGPT) 🟡

<https://github.com/letta-ai/letta> — ~21k★, active. Stateful-agent runtime on the MemGPT "LLM-as-OS" idea: memory tiers (core memory blocks in-context like RAM; archival memory out-of-context, agentically retrieved). Memory is **DB-backed and versioned** (reported git-backed, inspectable). Proactive retrieval (the LLM decides when/what to fetch via tools), not passive RAG. _Mostly secondary sources — partial._ Not files-as-truth, not a wiki.

### 5.7 Cognee — agent memory (knowledge graph) ✅

<https://github.com/topoteretes/cognee> — Apache-2.0, 17.9k★, active (v1.1.3, Jun 2026). "Open-source AI memory platform… self-hosted knowledge graph engine." **DB-as-truth** (knowledge graph + vector + relational; supports file-based and DB sources). **ECL pipeline** (Extract → Cognify → Load) builds a typed-entity graph with **ontology generation**. Ops: `remember` / `recall` (auto-routes search strategy) / `forget` / `improve`. 14 retrieval modes. Python lib + CLI + MCP + Claude Code plugin. Not files-as-truth.

### 5.8 AnythingLLM — local RAG desktop/app ✅

<https://github.com/Mintplex-Labs/anything-llm> — MIT, 61.8k★, active. "All-in-one AI application… private, fully-featured ChatGPT." Workspaces of uploaded docs → **vector DB** (default **LanceDB**) → vector RAG chat; no note-authoring/maintenance. Local-by-default desktop (Mac/Win/Linux); Ollama/LM Studio/LocalAI; no-code agent builder; source citations. A document-RAG product: ingested docs are retrieval context, not a compounding artifact.

### 5.9 Obsidian Smart Connections 🟡

<https://github.com/brianpetro/obsidian-smart-connections> — Obsidian plugin. **Files-as-truth (your vault).** Creates **local on-device embeddings** ("Zero setup. No API key"), stores them in a hidden `.smart-env/` dir, surfaces semantically related notes/excerpts in graph+list view, re-embeds on edit, works offline after indexing. _Secondary-sourced — partial._ A local-embeddings-over-an-existing-vault pattern with a hidden derived-index dir, inside Obsidian.

### 5.10 Obsidian Copilot 🟡

<https://github.com/logancyang/obsidian-copilot> — Obsidian plugin. **Files-as-truth (your vault).** In-vault chat + RAG over notes; Ollama-native local LLMs; "Relevant Notes" auto-context; long-term memory + user-defined commands. _Secondary-sourced — partial._

### 5.11 A-MEM — agentic memory (research, not a product) 🟡

<https://arxiv.org/abs/2502.12110> — "A-MEM: Agentic Memory for LLM Agents" (Rutgers / Ant Group / Salesforce; NeurIPS 2025). Zettelkasten-inspired "memory notes" with LLM-generated keywords/tags/context, **autonomous bidirectional linking**, and **memory evolution** (a new note can update the attributes/links of existing notes). _Arxiv abstract via search — partial._ The "memory evolution" mechanism (LLM rewrites old notes) is the canonical instance of the **semantic-drift / fluff-accumulation** risk on axis 3.

### 5.12 sqlite-memory — md↔SQLite agent memory ✅ (truth-model flagged)

<https://github.com/sqliteai/sqlite-memory> — MIT, 70★, v1.3.5 (Jun 2026). Markets itself as "markdown files as the source of truth," **but the README states the knowledge base "lives in one portable `.db` file"** — so it's **DB-as-truth with markdown as import/export I/O**, not files-as-truth. Hybrid search ("vector similarity (cosine distance) with FTS5 full-text search," configurable vector-vs-FTS weight), local llama.cpp embeddings, block-level LWW-CRDT multi-agent sync, SQL-ext + `sqlmem` CLI + MCP. **Verification lesson:** the tagline contradicts the README — verify "files-as-truth" claims against where data actually lives.

---

## 6. Domain observations (decision-neutral)

Trends visible across the surveyed tools, stated without recommending a choice:

- **The broad niche filled fast.** Files-as-truth markdown PKM (Basic Memory, Smart Connections, Copilot), LLM-maintained wiki from sources (llm_wiki), local-model search/chat over docs (Khoj, AnythingLLM, Reor†), and agent-memory layers with extraction/dedup/graphs (Mem0, Letta, Cognee) all ship today. The Karpathy-gist workflow went idea → 11.9k★ product in ~2 months.
- **The synthesis fork is being voted on.** Among shipping tools, llm_wiki and OB1 **regenerate**; Andrej and Basic Memory **edit-in-place**; most retrieval tools do **no** synthesis. No consensus.
- **"Files-as-truth" has become a marketing phrase.** sqlite-memory markets it but stores data in a `.db`. The claim must be checked against where data physically lives.
- **Provenance/trust is rare.** Among the tools surveyed, none track an observed/inferred/confirmed/generated/disputed status or run a review gate for LLM-authored claims; the closest are Cognee's typed edges/ontology and Letta's versioning. This is the emptiest region of the design space.
- **Single-maintainer desktop PKM is mortal.** Reor (a files-on-disk + local-vector + auto-link PKM) was archived ~a year in.
- **Agent-memory ≠ files-as-truth PKM.** Mem0/Letta/Cognee/sqlite-memory are DB/graph-as-truth memory layers for agents, a distinct category from a files-as-truth personal wiki, even though they share mechanics (extraction, dedup, typed graphs, hybrid retrieval).

† Reor archived 2026-03-07.

---

## Sources (primary links used)

- Khoj — repo <https://github.com/khoj-ai/khoj>, README <https://github.com/khoj-ai/khoj/blob/master/README.md>, search docs <https://docs.khoj.dev/features/search>, setup <https://docs.khoj.dev/get-started/setup/>
- Basic Memory — repo <https://github.com/basicmachines-co/basic-memory>, docs <https://docs.basicmemory.com/>, site <https://basicmemory.com/>
- nashsu/llm_wiki — repo <https://github.com/nashsu/llm_wiki>
- Reor — repo <https://github.com/reorproject/reor>, README <https://github.com/reorproject/reor/blob/main/README.md>
- sqlite-memory — repo <https://github.com/sqliteai/sqlite-memory>
- Mem0 — repo <https://github.com/mem0ai/mem0>
- Letta — repo <https://github.com/letta-ai/letta>, awesome-letta <https://github.com/letta-ai/awesome-letta>
- Cognee — repo <https://github.com/topoteretes/cognee>
- AnythingLLM — repo <https://github.com/Mintplex-Labs/anything-llm>, docs <https://docs.anythingllm.com/>
- Obsidian Smart Connections — repo <https://github.com/brianpetro/obsidian-smart-connections>, site <https://smartconnections.app/>
- Obsidian Copilot — repo <https://github.com/logancyang/obsidian-copilot>
- A-MEM — arxiv <https://arxiv.org/abs/2502.12110>
- Karpathy LLM-wiki gist (seed reference) — <https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f>
- Reference-approach table — derived from [`knowledge-catalog-patterns.md`](knowledge-catalog-patterns.md), [`andrej-wiki-gist.md`](andrej-wiki-gist.md), [`ob1-synthesis.md`](ob1-synthesis.md), [`ob1-ingestion-recon.md`](ob1-ingestion-recon.md).
