---
type: "AI-synthesis"
title: "Knowledge Catalog repo patterns"
description: "Reusable patterns distilled from Google's Knowledge Catalog repo: OKF as minimal 'knowledge as files', metadata-as-code sync, enrichment/discovery pipelines, and a candidate local-first architecture."
---

# Knowledge Catalog repo patterns

Source repo: [`../knowledge-catalog`](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/ba17dd5/README.md)

This note captures reusable ideas from Google's Knowledge Catalog examples for a local-first second brain / open brain design. It intentionally links to upstream docs instead of restating them.

## Executive takeaways

- The strongest portable idea is **knowledge as files**: markdown for human/agent-readable content, YAML for structured metadata, git for review/history.
- OKF is the cleanest minimum viable format: a folder of markdown concept docs with frontmatter and links. See [OKF spec](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/ba17dd5/okf/SPEC.md).
- Metadata as Code adds a heavier sync model: manifests, resource scopes, YAML asset files, markdown sidecars, reference layers, and push/pull semantics. See [mdcode concept](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/ba17dd5/agents/mdcode/docs/concept.md).
- The enrichment agents are examples of a **producer pipeline**, not part of the core format.
- For our local implementation, avoid coupling the durable knowledge representation to a catalog service. Treat SQLite/DuckDB/search indexes as derived views over files, not the source of truth.

## Relevant components

| Component | Source | Essential idea | Local-first adaptation |
|---|---|---|---|
| OKF | [README](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/ba17dd5/okf/README.md), [SPEC](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/ba17dd5/okf/SPEC.md) | Vendor-neutral knowledge bundle as markdown + YAML + links | Use as baseline note/concept file format |
| OKF enrichment agent | [code](https://github.com/GoogleCloudPlatform/knowledge-catalog/tree/ba17dd5/okf/src/enrichment_agent/) | Source metadata + web docs -> OKF docs | Replace BigQuery/web crawl with local folders, git repos, PDFs, browser exports, SQLite/DuckDB schemas |
| OKF viewer | [viewer code](https://github.com/GoogleCloudPlatform/knowledge-catalog/tree/ba17dd5/okf/src/enrichment_agent/viewer/) | Parse bundle, extract links, render static graph | Useful pattern for local static visualizations |
| Metadata as Code / kcmd | [README](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/ba17dd5/agents/mdcode/README.md), [concept](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/ba17dd5/agents/mdcode/docs/concept.md) | Manage metadata as versioned local artifacts with pull/push | Borrow manifest/reference-layer ideas, skip Google sync |
| Enrichment agent | [README](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/ba17dd5/agents/enrichment/README.md) | Multi-source context routing and doc generation | Borrow routing, provenance, feedback, eval ideas |
| Discovery agent | [README](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/ba17dd5/samples/discovery/README.md) | Decompose query -> multiple searches -> rerank results | Local search agent can use FTS/vector/hybrid indexes |
| Evaluation harness | [eval docs in enrichment README](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/ba17dd5/agents/enrichment/README.md#evaluating-the-output) | Score generated metadata for grounding, contradictions, redundancy | Build evals early for local agent outputs |

## OKF, reduced to its durable core

OKF is mostly a spec, not an application. The durable parts are:

- **Bundle**: directory tree as distribution unit.
- **Concept**: one markdown file representing one unit of knowledge.
- **Frontmatter**: structured metadata for routing/filtering/indexing.
- **Body**: markdown prose, schemas, examples, citations.
- **Links**: normal markdown links express relationships.
- **Indexes**: optional `index.md` files for progressive disclosure.
- **Conformance model**: permissive consumers; unknown fields and broken links should not break the system.

For our project, this argues for a simple canonical note file:

```markdown
---
id: stable/id
kind: note | source | person | project | claim | dataset | code_component
title: Human title
description: One-sentence summary
tags: [local-first, research]
source: optional URI or file path
created: 2026-06-18T00:00:00Z
updated: 2026-06-18T00:00:00Z
---

Markdown body with links, citations, examples, and notes.
```

Do not overfit to OKF's current BigQuery-oriented examples. The useful abstraction is `Concept`, not `BigQuery Table`.

## Metadata as Code patterns worth borrowing

Metadata as Code is heavier than OKF because it is designed for sync with Knowledge Catalog. Still, several patterns are valuable:

- **Manifest**: declare what a workspace contains, what is managed, and what is derived.
- **Reference layers**: keep read-only source facts separate from editable enrichments.
- **Sidecars**: split structured metadata from long-form markdown when useful.
- **Push/pull discipline**: separate ingestion, editing, review, and publication.
- **Links as first-class metadata**: distinguish ordinary markdown links from typed relationships when needed.
- **MCP/tooling interface**: expose list/read/modify operations for agents.

Local-first translation:

```text
source files / imports
  -> immutable-ish extracted reference records
  -> editable concept notes
  -> derived indexes: SQLite/DuckDB, FTS, embeddings, graph edges
  -> consumers: CLI, TUI, web viewer, agent tools
```

## Enrichment architecture pattern

The enrichment examples use a useful staged shape:

```text
source discovery
  -> raw metadata extraction
  -> candidate context gathering
  -> relevance routing
  -> LLM synthesis
  -> write files
  -> regenerate indexes
  -> evaluate output
```

Local-first source adapters could include:

- filesystem markdown
- browser bookmarks/history exports
- PDFs converted to markdown
- local git repositories
- SQLite/DuckDB/Postgres schemas
- email/chat exports
- package docs or code symbols
- manually curated seed URLs cached locally

Keep these as adapters. The core should not know or care whether a source is BigQuery, DuckDB, a folder, or a Git repo.

## Discovery/search pattern

The Discovery sample's main idea is not Google search itself. The reusable workflow is:

```text
user question
  -> semantic decomposition into subqueries
  -> retrieve candidates from multiple indexes
  -> rerank / synthesize answer
  -> cite source concepts
```

Local implementation options:

- SQLite FTS5 for lexical search
- DuckDB for analytical scans over metadata/events
- local vector index for embeddings
- graph traversal over markdown links/backlinks
- hybrid reranking that combines text score, recency, tags, and graph distance

## Design implications for our local second brain

### Source of truth

Prefer files as source of truth:

```text
notes/*.md
concepts/*.md
sources/*.md
```

Use SQLite/DuckDB as generated indexes:

```text
.db/search.sqlite      derived FTS/index tables
.db/brain.duckdb       derived analytics tables
.db/embeddings.*       derived semantic vectors
```

This preserves portability and avoids turning the DB schema into the knowledge format.

### Concept identity

Need stable IDs independent from filenames. OKF derives ID from path, which is simple but makes renames semantically meaningful. For a long-lived personal/open brain, consider both:

- path as human-friendly locator
- frontmatter `id` as stable identity

### Provenance

Track where claims came from. Minimum fields:

- `source`
- `source_type`
- `imported_at`
- `citations`
- `confidence` or `status`, if useful

### Layers

Borrow the reference/enrichment split:

- **raw/reference layer**: extracted facts, immutable or reproducible
- **curated layer**: human-authored and agent-refined notes
- **derived layer**: indexes, backlinks, summaries, embeddings, graphs

### Guardrails

The OKF code has a concrete guardrail: web enrichment cannot shrink existing schemas/citations. Generalize this:

- agent edits should preserve important existing sections unless explicitly asked
- raw facts should not be overwritten by synthesis
- generated content should cite sources
- evals should check grounding and contradictions

## What not to copy

- Do not depend on Google Cloud, BigQuery, Dataplex, Vertex, Drive, or `kcmd` for our local core.
- Do not make the service sync model central unless we actually need remote publication.
- Do not make tables/datasets the primary ontology. Our domain is broader: notes, claims, projects, sources, people, tasks, code, decisions.
- Do not require an LLM to read the corpus. Basic grep/SQLite/FTS should work.

## Candidate local architecture sketch

```text
                 +------------------+
                 |  source adapters |
                 | files, git, pdfs |
                 | sqlite, duckdb   |
                 +---------+--------+
                           |
                           v
                 +------------------+
                 | extracted facts  |  read-only/reference layer
                 +---------+--------+
                           |
                           v
+-------------+  +------------------+  +------------------+
| human edits |->| concept markdown |->| derived indexes  |
| agent edits |  | + YAML frontmatter|  | FTS/vector/graph |
+-------------+  +---------+--------+  +---------+--------+
                           |                     |
                           v                     v
                 +------------------+  +------------------+
                 | static/wiki view |  | agent/search API |
                 +------------------+  +------------------+
```

## Open questions for later design

- Should IDs be path-derived, UUID-like, or human slugs with redirect support?
- How much typed ontology do we need at the start?
- Are typed links worth adding early, or should markdown links/backlinks be enough?
- Should each imported source get its own source note?
- Where should generated summaries live: same file, sidecar, or derived DB?
- What is the minimum eval suite for agent-written notes?
