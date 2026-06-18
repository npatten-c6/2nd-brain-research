# Implementation Research Index

Research on ideas and approaches for a local-first, LLM-managed personal wiki / second brain / "open brain" system.

## Working assumptions

- **Format direction (~90% confidence):** follow Google's Open Knowledge Format (OKF) as the baseline for knowledge files — markdown concept docs with YAML frontmatter and ordinary markdown links.
- **Local-only:** no Google Cloud services (BigQuery, Dataplex, Vertex, Drive) or other hosted dependencies. Borrow the *format and patterns*, not the services. Derived stores (SQLite/DuckDB/FTS/vector) are views over files, never the source of truth.

## Index

| Doc | Summary |
|---|---|
| [andrej-wiki-gist.md](andrej-wiki-gist.md) | Seed idea. LLM incrementally builds and maintains a persistent, interlinked markdown wiki between you and raw sources, instead of re-deriving via RAG per query. Covers layers (raw / wiki / schema), operations (ingest / query / lint), index + log files, optional CLI search. |
| [knowledge-catalog-patterns.md](knowledge-catalog-patterns.md) | Reusable patterns distilled from Google's Knowledge Catalog repo: OKF as minimal "knowledge as files" format, Metadata-as-Code sync patterns, enrichment/discovery pipelines, and a candidate local-first architecture. Includes what *not* to copy (Google service coupling). |
| [ob1-synthesis.md](ob1-synthesis.md) | **Primary OB1 takeaway doc.** 18 concept chunks from Nate B. Jones's "Open Brain" (Supabase-based) with our local-first decision/tech/architecture options for each. Central reframe: OB1 is DB-as-truth, we want files-as-truth + DB-as-derived-view. Includes cloud->local cheat sheet + tech-decision agenda. |
| [ob1-ingestion-recon.md](ob1-ingestion-recon.md) | Deep-dive appendix on OB1's ingestion/capture/dedup pipeline (the most complex area): canonical spine, fingerprint + semantic dedup, job/dry-run model, importer family, prompt-injection hardening. Cited to source files. |
| [nate-post-claims-audit.md](nate-post-claims-audit.md) | Claims audit of Nate's "Open Brain" *post* (vs. the code). Inventories every assertion, scores it (KEEP/KERNEL/MISLEADING/CONTRADICTED/FLUFF), grounds the assessment in the OB1 recon. Distills ~7 durable ideas from ~80% persuasion; flags the "own it while renting the stack" contradiction; includes a reusable method for reading persuasive technical writing. |
| [okf-andrej-nate-comparison.md](okf-andrej-nate-comparison.md) | Concise compare/contrast of the three reference approaches (OKF / Andrej's LLM Wiki / Nate's Open Brain). Key frame: they're different *categories* (format spec / workflow pattern / deployed system) and largely complementary. Master comparison table, shared DNA, the 7 material forks (files-vs-DB truth, page-vs-atom, edit-vs-regenerate, embeddings, curate-vs-capture, single-vs-multi-tool, local-vs-cloud), and our slot-together position. |

## Open threads to research

- OKF spec details vs. our needs: concept identity (path-derived vs. stable frontmatter `id`), conformance/permissiveness model.
- Local tooling stack: search (e.g. `qmd`, SQLite FTS5), graph/backlinks, viewer.
- Ingest/query/lint workflows and how much to encode in the agent schema.
- Provenance and guardrails for agent-written notes (citations, grounding, eval).
- Prior art / existing tools survey: how shipping local-first LLM-PKM tools (Khoj, Mem0/Letta, Cognee, Reor, etc.) solve the same value prop, and whether our niche is unoccupied. Scoped as Clew increment `0005` (not yet started).
