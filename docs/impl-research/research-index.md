# Implementation Research Index

Research on ideas and approaches for a local-first, LLM-managed personal wiki / second brain / "open brain" system.

## Project direction

- **Exploratory, not a product.** Goal is to understand the space and experiment ourselves — not to build or sell into it.
- **Output = recommendations.** Navigate it for ourselves first, then guide others.
- **Real eventual audience:** enterprise rollout guidance for our workplace (mid-sized public co., ~3-4k FTEs) — get ahead of every employee rolling their own ad-hoc second brain.
- **Deployability is a first-class goal:** solutions must be usable by non-technical staff (e.g. GTM teams), not just engineers.

## Working assumptions

- **Format direction — *firm requirement*:** follow Google's Open Knowledge Format (OKF) as the baseline for knowledge files — markdown concept docs with YAML frontmatter and ordinary markdown links. The spec is vendored locally at [okf-spec.md](okf-spec.md) (OKF v0.1). (Upgraded from a ~90% working assumption to a requirement in increment `0006`. The persona-level framing — "the us-builder MUST conform to OKF" — and any conformance checklist are deferred to the Layer 2 persona increment.)
- **"Local-first" means local *data + infrastructure*, NOT local *models*.** Frontier cloud models (Anthropic / OpenAI) are the intended reasoning layer — specifically **Claude Enterprise** as the reference AI (approved + available to all staff at work). ⚠️ This *corrects* a conflation in the research docs: `ob1-synthesis.md` leans Ollama-first and frames sensitivity gating as "never send to remote model" (#3, #15) — that's backwards from our actual stance. Local models stay an *option*, not the default.
- **No self-hosted services.** No Supabase / hosted Postgres / servers / Docker daemons that tech & security won't approve or that a non-technical user can't stand up. Storage, index, and infra stay local and simple. Derived stores (SQLite/DuckDB/FTS/vector) are views over files, never the source of truth.
- **Borrow format and patterns, not services** (e.g. from OKF / Google Knowledge Catalog).

## Layering convention (`reference` / `lens` / `source`)

Every `docs/impl-research/` doc carries a layer tag so the factual record stays separable from our opinions (established in increment `0006`):

- **`reference`** — a *decision/requirement-neutral* domain map: the design space, concepts/architectures, tools-as-instances, and *inherent* trade-offs. Describes forks; does **not** advocate a choice. ("Neutral" ≠ "unopinionated" — axis selection and trade-off framing embed analysis; what's banished is *advocacy*.)
- **`lens`** — opinionated: recommendations, verdicts, "what to steal," borrow-vs-build, niche assessment, per-requirement/persona readouts. References `reference` docs by anchor; ideally restates no facts.
- **`source`** — an imported external artifact we're studying (someone else's text/code), inherently reference-flavored but not authored by us.

**Drift rule:** a new tool/fact updates the `reference` layer only; `lens` docs change only when *our requirements/opinions* change.

**Status note:** increment `0006` shipped the **Layer 1 (`reference`) re-architecture**. The opinionated content is parked, unorganized, in [`lens-WIP.md`](lens-WIP.md); a later increment will reorganize it into a persona-structured `recommendations-by-persona.md`.

## Index

| Doc | Layer | Summary |
|---|---|---|
| [prior-art-landscape.md](prior-art-landscape.md) | `reference` | **Layer 1 domain map.** Concept/architecture taxonomy (13 axes: 8 core forks + 5 deployment axes), the three reference-approach archetypes (OKF/Andrej/Nate) with master comparison table, 12 shipping-tool instances mapped onto the axes, a broadened deployment table, and decision-neutral domain observations. Verification discipline + primary citations intact; **no advocacy** (that's in `lens-WIP.md`). Renamed from `existing-tools-prior-art.md`; absorbs the reference content of `okf-andrej-nate-comparison.md`. |
| [lens-WIP.md](lens-WIP.md) | `lens` | **⚠️ WIP holding doc.** All opinionated content extracted from Layer 1 during `0006`, not yet organized: our design position (Andrej's workflow / OKF's format / Nate's pipeline-in-derived-layer), TL;DR verdicts, what-to-steal (per neighbor + cross-tool table), borrow-vs-build readout, the enterprise-deployability lens, and the "is our niche open?" verdict (wedge = provenance/trust). Pointers into `prior-art-landscape.md`. To be reorganized into persona-structured recommendations later. |
| [okf-spec.md](okf-spec.md) | `source` | **Vendored verbatim copy of the OKF v0.1 spec** (from `GoogleCloudPlatform/knowledge-catalog`, `okf/SPEC.md` @ `ba17dd5`, copied 2026-06-18). Our firm format requirement; kept here for easy reference. Defines bundles, concept docs, required `type` frontmatter, cross-linking, index/log files, citations, and the permissive conformance model. Don't hand-edit — re-copy from upstream to update. |
| [andrej-wiki-gist.md](andrej-wiki-gist.md) | `source` | Seed idea. LLM incrementally builds and maintains a persistent, interlinked markdown wiki between you and raw sources, instead of re-deriving via RAG per query. Covers layers (raw / wiki / schema), operations (ingest / query / lint), index + log files, optional CLI search. |
| [nate-post-open-brian.md](nate-post-open-brian.md) | `source` | The raw text of Nate B. Jones's "Open Brain" post (the persuasive artifact audited in `nate-post-claims-audit.md`). |
| [knowledge-catalog-patterns.md](knowledge-catalog-patterns.md) | `reference` | Reusable patterns distilled from Google's Knowledge Catalog repo: OKF as minimal "knowledge as files" format, Metadata-as-Code sync patterns, enrichment/discovery pipelines, and a candidate local-first architecture. Includes what *not* to copy (Google service coupling). |
| [ob1-ingestion-recon.md](ob1-ingestion-recon.md) | `reference` | Deep-dive appendix on OB1's ingestion/capture/dedup pipeline (the most complex area): canonical spine, fingerprint + semantic dedup, job/dry-run model, importer family, prompt-injection hardening. Cited to source files. |
| [ob1-synthesis.md](ob1-synthesis.md) | `lens` | **Primary OB1 takeaway doc.** 18 concept chunks from Nate B. Jones's "Open Brain" (Supabase-based) with our local-first decision/tech/architecture options for each. Central reframe: OB1 is DB-as-truth, we want files-as-truth + DB-as-derived-view. Includes cloud->local cheat sheet + tech-decision agenda. |
| [nate-post-claims-audit.md](nate-post-claims-audit.md) | `lens` | Claims audit of Nate's "Open Brain" *post* (vs. the code). Inventories every assertion, scores it (KEEP/KERNEL/MISLEADING/CONTRADICTED/FLUFF), grounds the assessment in the OB1 recon. Distills ~7 durable ideas from ~80% persuasion; flags the "own it while renting the stack" contradiction; includes a reusable method for reading persuasive technical writing. |
| [okf-andrej-nate-comparison.md](okf-andrej-nate-comparison.md) | `source` (superseded) | **Frozen intermediary artifact.** Original compare/contrast of the three reference approaches; its reference content is now merged into `prior-art-landscape.md` (§1–2) and its opinion into `lens-WIP.md`. Kept for provenance/lineage; do not edit as a living doc. |

## Open threads to research

- OKF spec details vs. our needs: concept identity (path-derived vs. stable frontmatter `id`), conformance/permissiveness model.
- Local tooling stack: search (e.g. `qmd`, SQLite FTS5), graph/backlinks, viewer.
- Ingest/query/lint workflows and how much to encode in the agent schema.
- Provenance and guardrails for agent-written notes (citations, grounding, eval).
- ~~Prior art / existing tools survey~~ — **done**, see [prior-art-landscape.md](prior-art-landscape.md) (Clew `0005`; re-architected into Layer 1 in `0006`). Follow-ups it surfaced (opinion captured in [lens-WIP.md](lens-WIP.md)): (a) **borrow-vs-build spike on Basic Memory** — install + read its sync/schema-tool source, answer "why not fork/extend it?"; (b) **revisit the edit-in-place vs regenerate lean** (synthesis #3) — shipping market leans regenerate (llm_wiki, OB1); (c) **lead with provenance/trust** — the one wedge absent from every neighbor surveyed.
- **Layer 2 persona re-architecture** (deferred from `0006`): reorganize [lens-WIP.md](lens-WIP.md) into a persona-structured `recommendations-by-persona.md` (us / enterprise non-tech staff / enterprise IT-builder), each a short requirements profile + recommendation pointing into Layer 1 by anchor; add the "us-builder MUST conform to OKF" framing + any OKF conformance checklist.
