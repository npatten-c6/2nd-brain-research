---
okf_version: "0.1"
---

# Implementation Research

Research on ideas and approaches for a local-first, LLM-managed personal wiki /
second brain / "open brain" system. Project direction, working assumptions, doc
conventions, and open threads live in [working-notes.md](working-notes.md).

# Primary sources

* [LLM Wiki (Karpathy gist)](andrej-wiki-gist.md) - seed idea: an LLM incrementally builds and maintains a persistent, interlinked markdown wiki between you and raw sources, instead of re-deriving via RAG per query.
* [Nate B. Jones — "Open Brain" post](nate-post-open-brian.md) - the raw persuasive artifact audited in the claims audit.
* [Open Knowledge Format (OKF) v0.1 spec](okf-spec.md) - vendored verbatim copy of the OKF v0.1 spec; our firm format requirement. Don't hand-edit — re-copy from upstream to update.

# AI-synthesis

* [Prior-Art Landscape](prior-art-landscape.md) - map of the design space: concept/architecture taxonomy (13 axes), the three reference approaches (OKF/Andrej/Nate) with master comparison, 12 shipping-tool instances, and decision-neutral domain observations.
* [OB1 Synthesis — Concept Chunks & Our Options](ob1-synthesis.md) - 18 concept chunks from Nate B. Jones's "Open Brain" with our local-first options for each; reframes DB-as-truth into files-as-truth + DB-as-derived-view.
* [OB1 Ingestion / Capture / Dedup Recon](ob1-ingestion-recon.md) - deep-dive on OB1's ingestion/capture/dedup pipeline: canonical spine, fingerprint + semantic dedup, job/dry-run model, importer family, prompt-injection hardening.
* [Nate "Open Brain" Post — Claims Audit](nate-post-claims-audit.md) - claims audit of Nate's post vs. the code; scores each assertion and distills the durable ideas from the persuasion.
* [Knowledge Catalog repo patterns](knowledge-catalog-patterns.md) - reusable patterns distilled from Google's Knowledge Catalog repo: OKF as minimal "knowledge as files", metadata-as-code sync, enrichment/discovery pipelines, and a candidate local-first architecture.
* [OKF vs Andrej vs Nate — Compare / Contrast](okf-andrej-nate-comparison.md) - frozen intermediary artifact; its reference content is now merged into the prior-art landscape. Kept for provenance.

# Working notes

* [working-notes.md](working-notes.md) - project direction, working assumptions, doc conventions (`type` vocabulary, layering), and open research threads.
