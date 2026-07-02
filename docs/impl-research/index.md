---
okf_version: "0.1"
---

# Implementation Research

Research on local-first, LLM-managed personal wiki / second brain / "open brain"
systems. Docs are organized as a 3-tier epistemic ladder so you can tell what
kind of thing you're reading before you open it:

- **[`sources/`](sources/)** — Tier 1, evidence. External artifacts, either
  **primary** (verbatim copies) or **proxy** (our commit-pinned assessment of a
  repo/audience we didn't vendor — flagged with a banner + provenance block).
- **[`analysis/`](analysis/)** — Tier 2, derived analysis. Decision-neutral maps,
  audits, and syntheses built on Tier 1; cites what it rests on; no advocacy.
- **[`recommendations/`](recommendations/)** — Tier 3, opinion. Per-persona
  recommendations and guides; points into Tier 2 rather than restating facts.

Project direction, working assumptions, doc conventions, and open threads live in
[working-notes.md](working-notes.md).

## Tier 1 — Sources

Primary (verbatim external artifacts):

* [LLM Wiki (Karpathy gist)](sources/andrej-wiki-gist.md) - seed idea: an LLM incrementally builds and maintains a persistent, interlinked markdown wiki between you and raw sources, instead of re-deriving via RAG per query.
* [Nate B. Jones — "Open Brain" post](sources/nate-post-open-brian.md) - the raw persuasive artifact audited in the claims audit.
* [Kieran Flanagan — "AI Second Brain" post](sources/kieran-ai-second-brain.md) - a GTM leader's first-person account of an Obsidian-vault + Claude Code second brain.
* [Open Knowledge Format (OKF) v0.1 spec](sources/okf-spec.md) - vendored verbatim copy of the OKF v0.1 spec; our firm format requirement. Don't hand-edit — re-copy from upstream to update.

Proxy (our commit-pinned assessments standing in for artifacts we didn't vendor):

* [OB1 Ingestion / Capture / Dedup Recon](sources/ob1-ingestion-recon.md) - deep-dive on OB1's ingestion/capture/dedup pipeline: canonical spine, fingerprint + semantic dedup, job/dry-run model, importer family, prompt-injection hardening.
* [Knowledge Catalog repo patterns](sources/knowledge-catalog-patterns.md) - reusable patterns distilled from Google's Knowledge Catalog repo: OKF as minimal "knowledge as files", metadata-as-code sync, enrichment/discovery pipelines, and a candidate local-first architecture.
* [SPS "AI Builder" persona](sources/sps-ai-builder-persona.md) - synthesized persona of the SPS internal AI-builder audience (from the guild-ai Slack channel); doubles as this repo's review lens.

## Tier 2 — Derived analysis

* [Prior-Art Landscape](analysis/prior-art-landscape.md) - map of the design space: concept/architecture taxonomy (13 axes), the three reference approaches (OKF/Andrej/Nate) with master comparison, 12 shipping-tool instances, and decision-neutral domain observations.
* [OB1 Synthesis — Concept Chunks & Our Options](analysis/ob1-synthesis.md) - 18 concept chunks from Nate B. Jones's "Open Brain" with our local-first options for each; reframes DB-as-truth into files-as-truth + DB-as-derived-view.
* [Nate "Open Brain" Post — Claims Audit](analysis/nate-post-claims-audit.md) - claims audit of Nate's post vs. the code; scores each assertion and distills the durable ideas from the persuasion.
* [OKF vs Andrej vs Nate — Compare / Contrast](analysis/okf-andrej-nate-comparison.md) - frozen intermediary artifact; its reference content is now merged into the prior-art landscape. Kept for provenance.

## Tier 3 — Recommendations

* [Lens (WIP)](recommendations/lens-WIP.md) - frozen pre-0009 opinion holding file; content reorganized into the per-persona docs. Kept for provenance.

## Bundle meta

* [working-notes.md](working-notes.md) - project direction, working assumptions, doc conventions (`type` vocabulary, tiers), and open research threads.
