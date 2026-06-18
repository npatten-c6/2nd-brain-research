# Existing Tools — Prior-Art Survey

Internal working doc. **Date:** 2026-06-18. Verified survey of *shipping* local-first / LLM-managed PKM & agent-memory tools that solve the same value prop we're chasing: a knowledge base where an LLM does the bookkeeping and knowledge compounds.

**Purpose:** (1) know what already exists, (2) find our closest neighbors and decide borrow-vs-build, (3) harvest concrete patterns worth stealing, (4) test whether our specific niche (files-as-truth + local-only + OKF + LLM-maintained *living* wiki + curation-in-the-loop) is actually unoccupied.

**Two lenses applied** (see [`research-index.md`](research-index.md) → Project direction): a **research lens** (what's the best design?) and an **enterprise-deployability lens** (could a non-technical employee run this with **Claude Enterprise** as the only approved AI and *no self-hosted services*?). The second is now a primary goal — see [its own section below](#enterprise-deployability-lens). Note "local-first" here means local *data + infra*, **not** local models — frontier cloud models are the intended reasoning layer.

**Companion docs:** [`research-index.md`](research-index.md) · [`okf-andrej-nate-comparison.md`](okf-andrej-nate-comparison.md) (the axes this survey maps onto) · [`ob1-synthesis.md`](ob1-synthesis.md) (our decisions + open forks) · [`nate-post-claims-audit.md`](nate-post-claims-audit.md) (the skeptical-reading lens — applied here).

### Verification legend

- ✅ **verified** — confirmed at primary source (repo README / official docs / arxiv) fetched directly during this survey.
- 🟡 **partial** — core confirmed at primary, but some fields rest on secondary sources / marketing not cross-checked against code.
- ⬜ **unverified** — secondary only.

Discipline note (learned from the failed Gemini run): every factual claim below carries a primary link; no synthesized "representative" quotes; abandoned projects flagged; marketing claims that the code/README contradicts are called out explicitly.

---

## TL;DR

1. **Our broad niche is no longer empty — it filled fast in 2026.** Karpathy's April-2026 "LLM wiki" gist (our seed idea) spawned a wave; the closest is **[`nashsu/llm_wiki`](https://github.com/nashsu/llm_wiki)** (11.9k stars, releasing actively as of today), a desktop app that implements almost exactly the raw/wiki/schema 3-layer pattern we sketched. We are **not first**.
2. **Closest neighbor on *mechanics + files-as-truth*: [Basic Memory](https://github.com/basicmachines-co/basic-memory).** Markdown files are the source of truth, frontmatter + wikilink graph, an LLM reads/writes/**edits-in-place** via MCP, FTS + vector + graph retrieval, and — notably — it ships `schema_validate`/`schema_infer` MCP tools that directly answer our open "validate-frontmatter-before-write" fork.
3. **Closest neighbor on *workflow/philosophy*: `nashsu/llm_wiki`.** Same 3-layer model, Obsidian-vault output, wikilinks + YAML, local MCP server, hybrid keyword+vector+graph retrieval. But it **regenerates** the wiki from sources (disposable view) rather than maintaining an edit-in-place living narrative — the Nate posture, not the Andrej one.
4. **Closest *mature product*: [Khoj](https://github.com/khoj-ai/khoj)** (35k+ stars, multi-client, local models). But it's **read/index-only** — a chat-and-search layer over a server-side DB index of your docs; it doesn't author or maintain a wiki. It diverges from us on files-as-truth (DB-as-index) and synthesis (none).
5. **The "regenerate vs edit-in-place" fork is being voted on — and the market leans regenerate.** llm_wiki and Nate's OB1 both regenerate; only Andrej and Basic Memory do edit-in-place living docs. Worth revisiting our lean (synthesis #3).
6. **The "agent-memory" cluster (Mem0, Letta, Cognee) is a different category** — DB/graph-as-truth memory layers for agents, not files-as-truth personal wikis. Useful for *mechanics* (extraction, dedup, typed graphs, recall routing), not as architectural neighbors.
7. **Watch the marketing-vs-code gap (claims-audit lesson holds).** [`sqlite-memory`](https://github.com/sqliteai/sqlite-memory) markets "markdown as the source of truth" but its README says the knowledge base "lives in one portable `.db` file" — it's DB-as-truth with markdown as I/O. Don't take the tagline at face value.
8. **One dead body to learn from:** [Reor](https://github.com/reorproject/reor) (local markdown + LanceDB + Ollama) was **archived 2026-03-07** — a files-on-disk + local-vector PKM that didn't survive.
9. **Verdict on "is our niche open?":** the *broad* niche is now crowded and validated; our *specific* combination (OKF-format compliance + edit-in-place living wiki + curated ingest + provenance/trust ladder + Rust-CLI-first, all local) is still differentiated but **not unique**. The honest risk: we could be rebuilding Basic Memory with extra steps. We need a crisp "why not just fork Basic Memory / study llm_wiki" answer before building.
10. **Through the enterprise-deployability lens (now a primary goal), the answer flips on its head:** the best *architecture* isn't the best *rollout candidate* — what wins is whatever clears "non-technical staff can install it + tech/security approve it + runs on Claude Enterprise + no self-hosted server." Today that's **Obsidian + plugins** (broad adoptability) or a **managed/one-click local MCP server behind Claude Enterprise**; self-hosted-server tools (Khoj, the agent-memory layers) are out for self-serve use. The unsolved enterprise gap — an *LLM-maintained living wiki* with zero-infra, minute-scale install on Claude Enterprise — is the most useful thing to track for the work recommendation. See [Enterprise-deployability lens](#enterprise-deployability-lens).

---

## Comparison table (mapped onto our axes)

Axes from [`okf-andrej-nate-comparison.md`](okf-andrej-nate-comparison.md). Cells abbreviated; see per-tool entries for nuance + citations.

| Tool | Category | Source of truth | Unit / granularity | Synthesis | Retrieval | Local + local models | Agent interface | Capture | Provenance/trust | Alive? | Verif |
|---|---|---|---|---|---|---|---|---|---|---|---|
| **Basic Memory** | Files-as-truth PKM + MCP | **Files** (md) | Note = entity; observations + relations parsed out | **Edit-in-place** | FTS + vector + graph | Local-first; FastEmbed local | **MCP** (read/write/edit/move + schema tools) | Conversation-driven (AI writes during chat) | Light (frontmatter); schema validate | ✅ v0.22.1, Jun 2026 | ✅ |
| **nashsu/llm_wiki** | LLM-maintained wiki (desktop) | **Files** (raw/wiki/schema) | Wiki page (entity/concept/source) | **Regenerate** (2-step ingest) | Keyword + opt. vector (LanceDB) + graph expansion | Fully local; any OpenAI-compatible incl. Ollama | HTTP API + **local MCP** + agent skill | Curated source ingest | none explicit | ✅ v0.4.25, Jun 18 2026 | ✅ |
| **Khoj** | Personal-AI search/chat | **DB index** (files synced in) | Doc chunk | **None** (read-only) | Bi-encoder vectors + cross-encoder rerank | Self-host; local HF embeddings + local LLM | Obsidian/Emacs/desktop/web/API | Sync from clients | none | ✅ 35k★, active | ✅ (license unconfirmed in README) |
| **Reor** | Local AI notes (desktop) | **Files** (1 dir) | Note, chunked | Edit (manual) | Vector (LanceDB) auto-link + RAG | Fully local; Ollama + Transformers.js | Desktop app only | Manual md authoring | none | ❌ **archived 2026-03-07** | ✅ |
| **sqlite-memory** | Agent memory (md→SQLite) | **DB** (`.db`); md is I/O | Chunk (512 tok) | none | **Hybrid** FTS5 + vector, weighted | Local; llama.cpp local embeddings | SQL ext + CLI + MCP | agent writes | none | ✅ v1.3.5, Jun 2026 | ✅ (truth-model flagged) |
| **Mem0** | Agent memory layer | **DB** (vector+graph+kv) | Extracted "memory" fact | Regenerate/update | Semantic + BM25 + entity | Self-host (Docker); local models | SDK/REST/CLI/skills | Auto-extract from chat | none (ADD-only as of Apr 2026) | ✅ 58.9k★, active | ✅ |
| **Letta (MemGPT)** | Stateful agent runtime | **DB** | Memory block / archival item | Agent-managed | Vector (agentic retrieval) | Self-host; local models | SDK/API/ADE | Agent-driven | versioned (git-backed memory) | ✅ 21k★, active | 🟡 |
| **Cognee** | Agent memory (KG) | **DB** (graph+vector+rel) | Entity + typed edge | ECL pipeline (rebuild) | 14 modes; graph + vector, auto-route | Self-host; local LLM | Python lib + CLI + MCP | `remember()` ingest | ontology/typed edges | ✅ 17.9k★, active | ✅ |
| **AnythingLLM** | Local RAG desktop/app | **Vector DB** (docs ingested) | Doc chunk | none (chat only) | Vector RAG | Local-by-default; Ollama/LMStudio | Desktop app + no-code agents | Upload docs | citations only | ✅ 61.8k★, active | ✅ |
| **Smart Connections** | Obsidian plugin | **Files** (your vault) | Note / block | none (surface links) | Local embeddings (semantic) | Local; on-device embed model | Obsidian plugin | n/a (over existing vault) | none | 🟡 active | 🟡 |
| **Obsidian Copilot** | Obsidian plugin | **Files** (your vault) | Note | none (chat/RAG) | RAG over vault + local embed | Local; Ollama native | Obsidian plugin | n/a | none | 🟡 active | 🟡 |
| **A-MEM** (research) | Academic memory system | n/a (paper) | Zettelkasten "memory note" | **Memory evolution** (links + attrs update) | Embedding + autonomous links | n/a | n/a | agent interactions | none | 🟡 NeurIPS 2025 | 🟡 |

---

## Tier-1 deep-dives (closest neighbors)

### 1. Basic Memory — closest on *files-as-truth + mechanics* ✅

**Link:** <https://github.com/basicmachines-co/basic-memory> · docs <https://docs.basicmemory.com/>
**Category:** Local-first, files-as-truth PKM with a native MCP agent interface.

**What it is:** "AI conversations that actually remember." Knowledge is stored as plain Markdown files on disk ("Plain text on your disk. Forever."). Each file is an *Entity* with YAML frontmatter (`title`, `type`, `permalink`, `tags`). The AI and the human write to the same files; a sync process keeps the derived index in step ("Two-way. AI and humans write to the same files; sync keeps them in step.").

**Schema mapping:**
- **Source of truth:** files (markdown). Index (SQLite/Postgres) is derived. *This is our exact stance.*
- **Unit/granularity:** note = entity (page-level, human-readable), **but** atomic structure is parsed out of the body: **Observations** = atomic facts tagged `[category]` (e.g. `[fact]`, `[method]`) + optional hashtags; **Relations** = wiki-style typed links (`relation_type [[Target]]`, bare `[[X]]` → `links_to`). So you get page-on-disk **and** atom/edge granularity in the derived graph — the resolution we hypothesized for our page-vs-atom fork (#2).
- **Synthesis:** **edit-in-place** — "Edits happen directly in-place — no regeneration cycles." (The Andrej posture.)
- **Retrieval:** three parallel paths — SQLite/Postgres full-text, semantic vector (FastEmbed), and graph traversal over relations (`build_context` walks `memory://` URLs link-by-link).
- **Local + models:** local-first; local FastEmbed embeddings; optional paid cloud ($15/mo, hosted Postgres + S3) for cross-device sync. Local = AGPL-3.0.
- **Agent interface:** **MCP-native** — `write_note`, `read_note`, `edit_note`, `move_note`, `delete_note`, `search`, `build_context`, `canvas` (generates Obsidian canvas), plus `schema_infer` / `schema_validate` / `schema_diff`. Tools carry MCP behavior hints (`readOnlyHint`, `destructiveHint`, `idempotentHint`).
- **Capture:** conversation-driven — the AI writes notes as you chat, rather than a curated external-source ingest.
- **Maturity:** v0.22.1 (2026-06-13), 86 releases, ~1,481 commits, Python. Alive and active.

**What to steal:**
- **`schema_validate` / `schema_infer` / `schema_diff` as first-class tools.** This is the concrete realization of our open fork #5 ("schema-validate-before-write w/ correction loop") and a direct guard against the frontmatter-corruption risk flagged in `ob1-synthesis.md`.
- **Observations/relations-in-body syntax** → atoms & typed edges *derived by parsing human-readable pages*, not stored as separate atom files. Validates "note = file unit, atom = derived granularity."
- **MCP behavior-hint annotations** on every tool (read-only/destructive/idempotent) — cheap safety metadata for an agent that writes to disk.
- **`memory://` URL graph navigation** — a clean addressing scheme for link-by-link context building.

**What to avoid / limits:** its format is *its own* (observations/relations DSL), **not OKF** — adopting it forecloses OKF compliance. Capture is chat-centric (weak story for curated ingest of external sources/PDFs, which Andrej's workflow and we care about). AGPL-3.0 is copyleft (matters if we ever distribute). It's the tool we most risk *duplicating* — borrow-vs-build pressure is highest here.

---

### 2. nashsu/llm_wiki — closest on *workflow/philosophy* ✅

**Link:** <https://github.com/nashsu/llm_wiki>
**Category:** Local desktop app that builds & maintains an interlinked markdown wiki from your sources — a direct implementation of Karpathy/Andrej's pattern (our seed).

**What it is:** "A cross-platform desktop application that turns your documents into an organized, interlinked knowledge base — automatically… Instead of traditional RAG… the LLM incrementally builds and maintains a persistent wiki from your sources."

**Schema mapping:**
- **Source of truth:** files, in a **3-layer model that mirrors ours**: `raw/sources/` (immutable inputs) → `wiki/` (LLM-generated `index.md`, `log.md`, `overview.md` + entity/concept/source subdirs) → `schema.md` + `purpose.md`. The `wiki/` dir is an Obsidian vault using `[[wikilinks]]` + YAML frontmatter.
- **Unit/granularity:** wiki page (entity / concept / source summary). Page-level, human-readable.
- **Synthesis:** **regenerate** — a two-step ingest (analyze source → generate wiki files) with a "SHA256 incremental cache" that skips unchanged sources and a "guaranteed source summary" coverage check. The wiki is a derived projection of sources (the Nate/regenerate posture), **not** an edit-in-place living narrative.
- **Retrieval:** multi-phase — tokenized keyword search (with CJK bigram support), optional vector semantic search via **LanceDB**, and **graph expansion using a 4-signal relevance model** (direct links, source overlap, Adamic-Adar, type affinity), with configurable context budgets (4K–1M tokens).
- **Local + models:** fully local (Tauri desktop), optional local MCP server at `127.0.0.1:19828`, any OpenAI-compatible LLM incl. Ollama.
- **Agent interface:** built-in HTTP API + local MCP server + an installable agent skill (`npx skills add …/llm_wiki_skill.git`).
- **Capture:** curated source ingest (drop docs into `raw/`).
- **Maturity:** GPL-3.0, **11.9k stars**, 1.4k forks, latest release v0.4.25 (**2026-06-18** — releasing the day of this survey). Very alive.

**What to steal:**
- **Validation that our 3-layer plan works as a shipped product** — raw/wiki/schema, Obsidian-vault output, wikilinks + frontmatter is a real, popular implementation. Study its file layout directly before we design ours.
- **4-signal graph relevance rerank** (direct links + source overlap + Adamic-Adar + type affinity) — a concrete, deterministic graph-distance reranking recipe for our retrieval layer (synthesis #11), beyond plain FTS/vector.
- **SHA256 incremental cache to skip unchanged sources** + "guaranteed source summary" coverage — the same idempotency/fingerprint primitive OB1 uses, applied to a files system. Cheap, deterministic, Rust-CLI-able.
- **Configurable context budget (4K–1M tokens)** as an explicit retrieval knob.

**What to avoid / limits:** **regenerate model** means the wiki is disposable — no living, hand-edited narrative that accrues human edits (our Andrej lean prefers edit-in-place for entity pages). GPL-3.0 desktop Tauri app (not a CLI/library we'd compose). No provenance/trust layer. No OKF alignment (its own frontmatter conventions). It's a *product*, not a substrate — we'd borrow patterns, not depend on it.

---

### 3. Khoj — closest *mature product* (but read-only) ✅

**Link:** <https://github.com/khoj-ai/khoj> · docs <https://docs.khoj.dev/>
**Category:** Self-hostable personal-AI search/chat over your docs + the web.

**What it is:** "Your AI second brain. Self-hostable. Get answers from the web or your docs… Turn any online or local LLM into your personal, autonomous AI." Multi-client: Browser, Obsidian, Emacs, Desktop, Phone, WhatsApp.

**Schema mapping:**
- **Source of truth:** **DB index**, not files. Clients (Obsidian/Desktop/Emacs) *sync* your files into a server-side store that Khoj indexes; "re-index all your documents" and an admin `SearchModelConfig` confirm a managed backend index. Your files remain on your client, but Khoj's working copy is the indexed DB — **DB-as-index**, the opposite of our files-as-truth (though milder than OB1's DB-as-canonical).
- **Unit/granularity:** document chunk (for embedding/retrieval).
- **Synthesis:** **none** — Khoj retrieves & chats; it does **not** author or maintain a wiki. (The README does not describe any write-back to your notes.)
- **Retrieval:** semantic — "A bi-encoder model is used to create meaning vectors (aka vector embeddings) of your documents and search queries," then "A cross-encoder model re-ranks results for quality." Two-stage retrieve→rerank.
- **Local + models:** self-hostable; **local HF/sentence-transformers embeddings by default** ("Khoj sets up decent default local search model config"); any local or online LLM (llama3/qwen/gemma/mistral/gpt/claude/gemini/deepseek).
- **Agent interface:** Obsidian/Emacs plugins, desktop, web, API; custom agents + scheduled automations + deep research.
- **Maturity:** ~35k+ stars, active (open PRs/issues, recent commits). License **not stated in the fetched README** (widely reported AGPL-3.0 — *unconfirmed at primary source here*).

**What to steal:**
- **Bi-encoder retrieve → cross-encoder rerank** as the standard two-stage semantic retrieval shape for our opt-in vector layer (synthesis #3/#11).
- **Sensible local-embedding defaults** so self-hosting "just works" without model config — good UX bar for our v1.
- **Multi-client reach pattern** (one brain, many front-ends) — though for us that's a *local* CLI/stdio-MCP, not a hosted server.

**What to avoid / limits:** **DB-as-index + read-only** = it's a retrieval layer, not a compounding *living wiki*; no synthesis, no edit-in-place, no provenance. Self-host is heavier (server + DB, Docker). It answers "how do agents *search* my docs," not "how does the knowledge *compound into an artifact*" — which is our core thesis.

---

## Tier-2 light entries

### 4. Reor ✅ — ⚠️ archived (dead)
<https://github.com/reorproject/reor> — AGPL-3.0. Local desktop AI notes: "Reor works within a single directory in the filesystem"; "Every note you write is chunked and embedded into an internal vector database" (**LanceDB**); "Related notes are connected automatically via vector similarity"; RAG Q&A over the corpus; local LLMs/embeddings via Ollama + Transformers.js; Obsidian-like markdown editor. **Archived by the owner on 2026-03-07, now read-only.** *Lesson:* a files-on-disk + local-vector + auto-link PKM (architecturally near us) that didn't survive — worth a postmortem on why (single-maintainer desktop app, narrow differentiation).

### 5. Mem0 ✅
<https://github.com/mem0ai/mem0> — Apache-2.0, 58.9k★, active (343 releases). "Universal memory layer for AI Agents." **DB-as-truth** (vector + graph + key-value; Qdrant in self-host). LLM extracts "memories" from chat; hybrid retrieval = "semantic, BM25 keyword, and entity matching." Notable: the **April-2026 algorithm is "Single-pass ADD-only extraction" with "no UPDATE/DELETE"** — memories accumulate without overwriting. Library / self-hosted Docker / cloud; SDKs + REST + CLI + agent skills. *Not a files-as-truth wiki* — agent memory. **Steal:** the BM25+semantic+entity hybrid; **contrast:** ADD-only is the opposite of our dedup/edit-in-place hygiene — a deliberate simplicity trade we should note (accumulation-isn't-free, per the claims audit).

### 6. Letta (formerly MemGPT) 🟡
<https://github.com/letta-ai/letta> — ~21k★, active. Stateful-agent runtime built on the MemGPT "LLM-as-OS" idea: memory tiers (core memory blocks in-context like RAM; archival memory out-of-context, agentically retrieved). Memory is **DB-backed and versioned** (reported git-backed, inspectable). Proactive retrieval (the LLM decides when/what to fetch via tools), not passive RAG. *Mostly secondary sources — partial.* **Steal:** the core-vs-archival tiering maps to our "context budget" concern; versioned memory ≈ our git-tracked files (we already get this free). *Not files-as-truth, not a wiki.*

### 7. Cognee ✅
<https://github.com/topoteretes/cognee> — Apache-2.0, 17.9k★, active (v1.1.3, Jun 2026). "Open-source AI memory platform… self-hosted knowledge graph engine." **DB-as-truth** (knowledge graph + vector + relational; README notes it supports both file-based and DB sources). **ECL pipeline** (Extract → Cognify → Load) builds a typed-entity graph with **ontology generation**. Ops: `remember` / `recall` (auto-routes search strategy) / `forget` / `improve`. 14 retrieval modes. Python lib + CLI + MCP + Claude Code plugin. **Steal:** ontology/typed-edge generation + **auto-routing recall** (pick best search strategy per query) → directly relevant to our entity-graph fork (#8) and schema-aware routing (#11). *Not files-as-truth.*

### 8. AnythingLLM ✅
<https://github.com/Mintplex-Labs/anything-llm> — MIT, 61.8k★, active. "All-in-one AI application… private, fully-featured ChatGPT." Workspaces of uploaded docs → **vector DB** (default **LanceDB**) → vector RAG chat; no note-authoring/maintenance ("no mention of note-taking or maintenance features — it's designed for document retrieval and conversation"). Local-by-default desktop (Mac/Win/Linux); Ollama/LM Studio/LocalAI; no-code agent builder; source citations. *Document-RAG product, not a living wiki.* **Steal:** the bundled-LanceDB + CPU-embedder "zero-config local" UX bar; **avoid:** treating ingested docs as throwaway RAG context (no compounding artifact).

### 9. Obsidian Smart Connections 🟡
<https://github.com/brianpetro/obsidian-smart-connections> — Obsidian plugin. **Files-as-truth (your vault).** Creates **local on-device embeddings** ("Zero setup. No API key"), stores them in a hidden `.smart-env/` dir, surfaces semantically related notes/excerpts in graph+list view, re-embeds on edit, works offline after indexing. *Secondary-sourced — partial.* **Steal:** local-embeddings-over-an-existing-vault with a hidden derived-index dir is precisely our "DB-as-derived-view beside the files" pattern, proven inside Obsidian — and it shows Obsidian-as-UI + a sidecar index is a viable shape for v1.

### 10. Obsidian Copilot 🟡
<https://github.com/logancyang/obsidian-copilot> — Obsidian plugin. **Files-as-truth (your vault).** In-vault chat + RAG over notes; Ollama-native local LLMs; "Relevant Notes" auto-context; long-term memory + user-defined commands. *Secondary-sourced — partial.* **Steal:** the "Relevant Notes auto-pulled into each conversation" UX (ambient context injection) and CORS-handling for local Ollama; confirms the Obsidian-plugin delivery path for local-LLM chat over a vault.

### 11. A-MEM (research, not a product) 🟡
<https://arxiv.org/abs/2502.12110> — "A-MEM: Agentic Memory for LLM Agents" (Rutgers / Ant Group / Salesforce; NeurIPS 2025). Zettelkasten-inspired "memory notes" with LLM-generated keywords/tags/context, **autonomous bidirectional linking**, and **memory evolution** (a new note can update the attributes/links of existing notes). *Arxiv abstract via search — partial.* **Relevance:** directly informs our edit-in-place-vs-regenerate fork (#3) and lint/consolidation (#12) — but its "memory evolution" (LLM rewrites old notes) is exactly the mechanism behind our **semantic-drift / fluff-accumulation** risk hypothesis. A research-grade caution, not something to copy wholesale.

### Honorable mention: sqlite-memory ✅ (truth-model flagged)
<https://github.com/sqliteai/sqlite-memory> — MIT, 70★, v1.3.5 (Jun 2026). Markets itself as "markdown files as the source of truth," **but the README states the knowledge base "lives in one portable `.db` file"** — so it's **DB-as-truth with markdown as import/export I/O**, not files-as-truth. Hybrid search ("Combines vector similarity (cosine distance) with FTS5 full-text search," configurable vector-vs-FTS weight), local llama.cpp embeddings, block-level LWW-CRDT multi-agent sync, SQL-ext + `sqlmem` CLI + MCP. **Steal:** the configurable FTS5+vector weight (a hybrid knob), llama.cpp local embeddings in a single SQLite file (validates our SQLite + sqlite-vec + FTS5 derived-store plan), CRDT sync as a multi-device idea. **Lesson:** apply the claims-audit — the tagline contradicts the README; verify "files-as-truth" claims against where the data actually lives.

---

## Closest neighbors — borrow-vs-build readout

**The uncomfortable finding:** two tools now occupy most of our space, and a third owns the mature-product slot.

- **Basic Memory ≈ our mechanics + truth model.** Files-as-truth markdown, frontmatter, wikilink graph, edit-in-place, MCP read/write/edit, FTS+vector+graph, and `schema_validate`-before-write. If we strip our project to "files-as-truth + LLM writes/edits markdown + MCP + derived index," **Basic Memory already is that.** *Build-vs-borrow pressure is highest here.* Our differentiators that justify building (or forking) rather than adopting:
  1. **OKF-format compliance** (Basic Memory uses its own observations/relations DSL, not OKF).
  2. **Curated external-source ingest** (Basic Memory is chat-capture-centric; Andrej's curated raw→wiki ingest is core to us).
  3. **Provenance/trust ladder** (observed/inferred/confirmed/generated) — Basic Memory has none; this is our richest borrowed idea from OB1.
  4. **Rust-CLI-first, deterministic hot paths** (Basic Memory is Python; our values push determinism down to code).
  - **Recommendation:** before writing code, do a hard spike on Basic Memory — install it, read its sync + schema-tool source — and answer "what do we get by building that forking/contributing wouldn't?" If the answer is only "OKF + provenance + Rust," consider whether those are extensions to Basic Memory rather than a new system.

- **nashsu/llm_wiki ≈ our workflow.** It's a working, popular implementation of the exact raw/wiki/schema pattern from our seed. **Borrow:** its file layout, the 4-signal graph rerank, the SHA256 skip-unchanged cache, the context-budget knob. **Diverge:** it *regenerates* (disposable wiki); we lean edit-in-place for entity pages. **Recommendation:** read its source as a reference design; don't depend on it (GPL-3 desktop app).

- **Khoj ≈ the search/chat layer we're *not* building.** It's the mature option if all you want is "ask my docs." It validates local-embedding defaults and retrieve→rerank, but its read-only/DB-as-index posture is the thing our thesis explicitly rejects. **Borrow:** retrieval mechanics. **Don't** adopt its architecture.

---

## Enterprise-deployability lens

A second readout, since enterprise rollout guidance is now a primary goal. The bar: **a non-technical employee (e.g. GTM) can use it with Claude Enterprise as the approved AI, no self-hosted services (no Supabase/Postgres/Docker servers), and nothing tech/security must vet.** Frontier cloud models are fine; *standing up infra* is the disqualifier.

| Tool | Deployable by non-tech staff? | What it needs | Verdict for enterprise rollout |
|---|---|---|---|
| **Claude Enterprise + MCP server (local)** e.g. Basic Memory | 🟡 Medium | Install an MCP server locally; connect from Claude. Files on disk, no DB server. | **Best fit in spirit** — but MCP setup is still a technical step; needs a one-click/managed install to clear the GTM bar. Claude Enterprise MCP support + admin policy is the gating question. |
| **Obsidian + plugins** (Smart Connections, Copilot) | ✅ High | Install Obsidian + a plugin; point at a model. No servers. | **Most realistic for broad staff** today — GUI, app-store install, files local. Copilot can use cloud models. Weakest on "LLM maintains the wiki," strongest on adoptability. |
| **nashsu/llm_wiki** | ✅ High (single user) | Desktop app install; bring an API key (Anthropic OK). No infra. | Good adoptability *as an app*; but it's an individual desktop tool, GPL-3, regenerate-model — not an org-sanctioned platform. Watch licensing for any internal distribution. |
| **Khoj (self-host)** | ❌ Low | Server + DB, Docker. Or pay for cloud (data leaves). | Self-host fails the no-infra bar; cloud fails data-residency. Org-hosted instance = a real IT project, not a staff-self-serve tool. |
| **AnythingLLM (desktop)** | ✅ High (desktop) / ❌ (Docker) | Desktop app is one-click + bundled vector DB; the multi-user server is Docker. | Desktop edition is genuinely staff-deployable; but it's document-RAG chat, not a compounding wiki. |
| **Mem0 / Letta / Cognee** | ❌ Low | Python, infra, vector/graph DBs. Developer SDKs. | Building blocks for *us* to assemble, **not** end-user tools. Disqualified for direct staff rollout. |
| **sqlite-memory** | ❌ Low | Dev tool (SQL ext / CLI). | Infra/plumbing, not an end-user product. |

**Takeaways for the recommendation track:**
- The enterprise winner is **not** the best *architecture* — it's whatever clears the **install + approval** bar. Today that's **Obsidian + plugins** (broad staff) or a **managed/one-click local MCP server behind Claude Enterprise** (if/when MCP admin policy + packaging allow).
- **Self-hosted-server tools (Khoj, the agent-memory layers) are out** for self-serve staff use — they're IT projects or developer SDKs.
- **The unsolved enterprise gap:** an *LLM-maintained living wiki* that a non-technical employee installs in minutes, runs on Claude Enterprise, keeps data in local/approved files, and needs zero server. Obsidian-plugin tools are adoptable but don't maintain the wiki; the wiki-maintainers (llm_wiki, Basic Memory) need a packaging/approval story. **That gap is the most useful thing to track for the work recommendation.**
- **Open question to resolve:** what exactly Claude Enterprise permits — local MCP servers, custom connectors, admin-approved tools, and where files may live. This gates every "Claude Enterprise + X" option above.

## Patterns worth stealing (cross-tool, tied to our open forks)

| Pattern | Source(s) | Ties to our fork / agenda |
|---|---|---|
| **`schema_validate`/`infer`/`diff` as agent tools** (validate frontmatter before write, correction loop) | Basic Memory | Open fork #5 (write-back contract); frontmatter-corruption risk in `ob1-synthesis.md` |
| **Observations + typed relations parsed from human-readable pages** (atoms/edges as *derived* granularity, not separate files) | Basic Memory | Page-vs-atom fork (#2) — confirms "note = file unit, atom = derived" |
| **3-layer raw/wiki/schema layout as a shipped reference** | nashsu/llm_wiki | Validates our layering (synthesis #1) — study before designing |
| **4-signal graph relevance rerank** (direct links + source overlap + Adamic-Adar + type affinity) | nashsu/llm_wiki | Retrieval/rerank (#11); entity-graph (#8) |
| **SHA256 skip-unchanged + guaranteed-coverage on ingest** | nashsu/llm_wiki (≈ OB1 fingerprint) | Dedup/idempotency (#6) in a files system — Rust-CLI-able |
| **Bi-encoder retrieve → cross-encoder rerank** | Khoj | Two-stage semantic retrieval for opt-in vector layer (#3/#11) |
| **Configurable FTS5 ↔ vector weight (hybrid knob); local embeddings in one SQLite file** | sqlite-memory | Validates SQLite + FTS5 + sqlite-vec derived store (#3/#4); a tunable hybrid (RRF-style) |
| **Local on-device embeddings in a hidden sidecar dir beside the vault** | Smart Connections | DB-as-derived-view-beside-files (#1); Obsidian-as-UI v1 (#17) |
| **Ontology generation + auto-routing recall** (pick search strategy per query) | Cognee | Entity-graph (#8); schema-aware routing (#11) |
| **MCP behavior-hint annotations** (readOnly/destructive/idempotent) on write tools | Basic Memory | Interface/agent-access safety (#13) |
| **Local stdio/loopback MCP server** (`127.0.0.1`) as the agent interface | nashsu/llm_wiki, Basic Memory | Interface (#13) — confirms local-MCP over hosted-HTTP |
| **Memory-evolution caution** (LLM rewriting old notes drifts/bloats) | A-MEM (research) | Edit-in-place-vs-regenerate (#3); lint (#12); fluff-accumulation risk |

---

## Gaps / is our niche open?

**Honest verdict: the broad niche is occupied and validated; our specific intersection is differentiated but not unique — and we are not first.**

- **What's now covered by shipping tools:** files-as-truth markdown PKM (Basic Memory, Smart Connections, Copilot), LLM-maintained wiki from sources (nashsu/llm_wiki), local-model semantic search/chat over docs (Khoj, AnythingLLM, Reor†), agent-memory layers with extraction/dedup/graphs (Mem0, Letta, Cognee). The Karpathy-gist workflow specifically went from idea (April 2026) to popular product (llm_wiki, 11.9k★) in ~2 months.

- **What no single tool combines (our slot):** OKF-format compliance **+** edit-in-place *living* wiki (not regenerate) **+** curated external-source ingest **+** a provenance/trust ladder **+** Rust-CLI-first determinism **+** Obsidian-as-UI — all fully local. Each ingredient exists somewhere; the *combination* doesn't. That's a real but narrow differentiator.

- **Risks to our thesis (call them out):**
  1. **Duplication risk.** Basic Memory already nails files-as-truth + edit-in-place + MCP + schema-validate. We need a crisp answer to "why not fork/extend it?" Our four differentiators (OKF, curated ingest, provenance, Rust) may be features *on* it rather than a reason for a ground-up build.
  2. **The market is voting "regenerate."** llm_wiki and OB1 both regenerate; only Andrej + Basic Memory edit-in-place. Our edit-in-place lean (synthesis #3) should be re-examined against this, not assumed.
  3. **Single-maintainer mortality.** Reor (our nearest architectural twin) was archived after ~a year. A files+local-vector desktop PKM is a crowded, hard-to-differentiate space; survival needs a sharp wedge.
  4. **"Files-as-truth" is a marketing word now** (sqlite-memory) — our differentiation has to be real (data genuinely lives in OKF files, index genuinely rebuildable), not a tagline.

- **Where we're still clearly ahead of the pack:** **provenance/trust for LLM-authored claims** (OB1's richest idea) is essentially absent from every neighbor surveyed — none track observed/inferred/generated/disputed status or run a review queue. If our project has one defensible wedge, **trustworthy LLM-authored knowledge with citations + a review gate** is it. Lead with that.

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
