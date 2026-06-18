# Implementation Research Index

Research on ideas and approaches for a local-first, LLM-managed personal wiki / second brain / "open brain" system.

## Project direction

- **Exploratory, not a product.** Goal is to understand the space and experiment ourselves — not to build or sell into it.
- **Output = recommendations.** Navigate it for ourselves first, then guide others.
- **Real eventual audience:** enterprise rollout guidance for our workplace (mid-sized public co., ~3-4k FTEs) — get ahead of every employee rolling their own ad-hoc second brain.
- **Deployability is a first-class goal:** solutions must be usable by non-technical staff (e.g. GTM teams), not just engineers.

## Working assumptions

- **Format direction (~90% confidence):** follow Google's Open Knowledge Format (OKF) as the baseline for knowledge files — markdown concept docs with YAML frontmatter and ordinary markdown links.
- **"Local-first" means local *data + infrastructure*, NOT local *models*.** Frontier cloud models (Anthropic / OpenAI) are the intended reasoning layer — specifically **Claude Enterprise** as the reference AI (approved + available to all staff at work). ⚠️ This *corrects* a conflation in the research docs: `ob1-synthesis.md` leans Ollama-first and frames sensitivity gating as "never send to remote model" (#3, #15) — that's backwards from our actual stance. Local models stay an *option*, not the default.
- **No self-hosted services.** No Supabase / hosted Postgres / servers / Docker daemons that tech & security won't approve or that a non-technical user can't stand up. Storage, index, and infra stay local and simple. Derived stores (SQLite/DuckDB/FTS/vector) are views over files, never the source of truth.
- **Borrow format and patterns, not services** (e.g. from OKF / Google Knowledge Catalog).

## Index

| Doc | Summary |
|---|---|
| [andrej-wiki-gist.md](andrej-wiki-gist.md) | Seed idea. LLM incrementally builds and maintains a persistent, interlinked markdown wiki between you and raw sources, instead of re-deriving via RAG per query. Covers layers (raw / wiki / schema), operations (ingest / query / lint), index + log files, optional CLI search. |
| [knowledge-catalog-patterns.md](knowledge-catalog-patterns.md) | Reusable patterns distilled from Google's Knowledge Catalog repo: OKF as minimal "knowledge as files" format, Metadata-as-Code sync patterns, enrichment/discovery pipelines, and a candidate local-first architecture. Includes what *not* to copy (Google service coupling). |
| [ob1-synthesis.md](ob1-synthesis.md) | **Primary OB1 takeaway doc.** 18 concept chunks from Nate B. Jones's "Open Brain" (Supabase-based) with our local-first decision/tech/architecture options for each. Central reframe: OB1 is DB-as-truth, we want files-as-truth + DB-as-derived-view. Includes cloud->local cheat sheet + tech-decision agenda. |
| [ob1-ingestion-recon.md](ob1-ingestion-recon.md) | Deep-dive appendix on OB1's ingestion/capture/dedup pipeline (the most complex area): canonical spine, fingerprint + semantic dedup, job/dry-run model, importer family, prompt-injection hardening. Cited to source files. |
| [nate-post-claims-audit.md](nate-post-claims-audit.md) | Claims audit of Nate's "Open Brain" *post* (vs. the code). Inventories every assertion, scores it (KEEP/KERNEL/MISLEADING/CONTRADICTED/FLUFF), grounds the assessment in the OB1 recon. Distills ~7 durable ideas from ~80% persuasion; flags the "own it while renting the stack" contradiction; includes a reusable method for reading persuasive technical writing. |
| [okf-andrej-nate-comparison.md](okf-andrej-nate-comparison.md) | Concise compare/contrast of the three reference approaches (OKF / Andrej's LLM Wiki / Nate's Open Brain). Key frame: they're different *categories* (format spec / workflow pattern / deployed system) and largely complementary. Master comparison table, shared DNA, the 7 material forks (files-vs-DB truth, page-vs-atom, edit-vs-regenerate, embeddings, curate-vs-capture, single-vs-multi-tool, local-vs-cloud), and our slot-together position. |
| [existing-tools-prior-art.md](existing-tools-prior-art.md) | **Verified prior-art survey of shipping tools** (12 entries) mapped onto our comparison axes. Closest neighbors: Basic Memory (files-as-truth + MCP + edit-in-place + schema-validate), nashsu/llm_wiki (our 3-layer raw/wiki/schema pattern as a shipped product), Khoj (mature but read-only DB-index). Plus agent-memory layers (Mem0/Letta/Cognee), local RAG (AnythingLLM), Obsidian plugins, A-MEM research, and one dead twin (Reor, archived). Verdict: broad niche now occupied & validated — we're not first; our specific slot (OKF + edit-in-place living wiki + curated ingest + provenance/trust + Rust-CLI, all local) is differentiated but not unique. Provenance/trust for LLM-authored claims is our clearest wedge. Includes patterns-to-steal table and a borrow-vs-build readout (esp. Basic Memory). |

## Open threads to research

- OKF spec details vs. our needs: concept identity (path-derived vs. stable frontmatter `id`), conformance/permissiveness model.
- Local tooling stack: search (e.g. `qmd`, SQLite FTS5), graph/backlinks, viewer.
- Ingest/query/lint workflows and how much to encode in the agent schema.
- Provenance and guardrails for agent-written notes (citations, grounding, eval).
- ~~Prior art / existing tools survey~~ — **done**, see [existing-tools-prior-art.md](existing-tools-prior-art.md) (Clew `0005`). Follow-ups it surfaced: (a) **borrow-vs-build spike on Basic Memory** — install + read its sync/schema-tool source, answer "why not fork/extend it?"; (b) **revisit the edit-in-place vs regenerate lean** (synthesis #3) — shipping market leans regenerate (llm_wiki, OB1); (c) **lead with provenance/trust** — the one wedge absent from every neighbor surveyed.
