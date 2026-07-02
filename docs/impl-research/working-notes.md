---
type: "working-notes"
title: "Implementation Research — Working Notes"
description: "Project direction, working assumptions, doc conventions, and open research threads for the impl-research bundle. The catalog of docs lives in index.md."
---

# Implementation Research — Working Notes

Project direction, working assumptions, and open threads for the local-first,
LLM-managed personal wiki / second brain / "open brain" research. The catalog of
research docs is the bundle [`index.md`](index.md).

## Project direction

- **Exploratory, not a product.** Goal is to understand the space and experiment ourselves — not to build or sell into it.
- **Output = recommendations.** Navigate it for ourselves first, then guide others.
- **Primary reader (reframed in increment `0009`):** an SPS colleague starting to explore this
  space — the repo is the one-stop reference so they don't each redo the research. "Us" (the
  researchers) is now _one persona_ ([`for-us-builders.md`](recommendations/for-us-builders.md)),
  no longer the default reader. The review lens for the primary reader is the
  [SPS AI Builder persona](sources/sps-ai-builder-persona.md).
- **Deployability is a first-class goal:** solutions must be usable by non-technical staff (e.g. GTM teams), not just engineers.

## Working assumptions

- **Format direction — _firm requirement_:** follow Google's Open Knowledge Format (OKF) as the baseline for knowledge files — markdown concept docs with YAML frontmatter and ordinary markdown links. The spec is vendored locally at [okf-spec.md](sources/okf-spec.md) (OKF v0.1). (Upgraded from a ~90% working assumption to a requirement in increment `0006`. The persona-level framing — "the us-builder MUST conform to OKF" — and any conformance checklist are deferred to the Layer 2 persona increment.)
- **"Local-first" means local _data + infrastructure_, NOT local _models_.** Frontier cloud models (Anthropic / OpenAI) are the intended reasoning layer — specifically **Claude Enterprise** as the reference AI (approved + available to all staff at work). ⚠️ This _corrects_ a conflation in the research docs: `ob1-synthesis.md` leans Ollama-first and frames sensitivity gating as "never send to remote model" (#3, #15) — that's backwards from our actual stance. Local models stay an _option_, not the default.
- **No self-hosted services.** No Supabase / hosted Postgres / servers / Docker daemons that tech & security won't approve or that a non-technical user can't stand up. Storage, index, and infra stay local and simple. Derived stores (SQLite/DuckDB/FTS/vector) are views over files, never the source of truth.
- **Borrow format and patterns, not services** (e.g. from OKF / Google Knowledge Catalog).

## Doc conventions

### The 3-tier epistemic ladder (increment `0009`)

Every concept doc lives in one of three tier folders, so a newcomer can tell what kind of thing
they're reading _before_ opening it — evidence vs analysis vs recommendation:

- **`sources/` — Tier 1, evidence.** External artifacts. Each is **primary** (verbatim copy;
  don't edit the body, re-import to update) or **proxy** (our commit-pinned assessment standing
  in for an artifact we didn't vendor). Tier-1 docs carry no advocacy.
- **`analysis/` — Tier 2, derived analysis.** Maps, audits, syntheses built on Tier 1.
  Decision-neutral: describes forks and trade-offs, cites the sources it rests on, does not
  advocate a choice.
- **`recommendations/` — Tier 3, opinion.** Per-persona recommendations and guides
  (us-builder / enterprise non-tech staff / enterprise IT-builder, plus the SPS-specific guide).
  Judgment lives here; evidence is linked (Tier 1/2), not restated. Each guide should be
  self-contained enough to drop into an agent's context and be useful on its own.

Bundle meta stays at the bundle root: [`index.md`](index.md) (catalog), this file, and
[`proxy-source-refresh.md`](proxy-source-refresh.md).

**Proxy source discipline.** Every proxy carries (a) a banner — _assessment of the artifact, not
the artifact; verify against source before relying_ — and (b) a provenance block in frontmatter:
`source_repo` (or `source` for non-repo proxies), `source_ref` (commit SHA), `assessed_date`,
`assessed_by`, `proxy_for` (+ `assessment_history` once refreshed). Findings cite `path:line`
into the source repo; stated intent (README/docs) stays separate from observed implementation
(code). Refresh procedure: [`proxy-source-refresh.md`](proxy-source-refresh.md).

This supersedes the informal `reference`/`lens`/`source` layering from increment `0006`
(reference → analysis; lens → recommendations; source → sources, split primary/proxy).

### `type` frontmatter (OKF)

This folder is dogfooded as an OKF bundle (increment `0007`). Every concept doc
carries a non-empty `type` in YAML frontmatter — OKF's one hard rule. `type` is the
machine-readable classification of record and stays in sync with the tier folder:

- **`primary source - <medium>`** — Tier 1 primary (`- blog post`, `- gist`, `- specification`).
- **`proxy source - <kind>`** — Tier 1 proxy (`- repo assessment`, `- persona synthesis`).
- **`analysis - <kind>`** — Tier 2 (`- landscape survey`, `- synthesis`, `- claims audit`,
  `- comparison (frozen intermediary)`).
- **`recommendation - <persona>`** — Tier 3.
- **`working-notes`**, **`process note`**, **`superseded working file`** — bundle meta and
  frozen intermediaries.

`type` values are free-form and self-describing (OKF §4.1); add new descriptive
values as needed rather than forcing a fit. Concept identity is **path-derived**
(file path minus `.md`, per OKF §2) — no stable frontmatter `id`; moving a file is a concept
rename, so fix inbound links when you move one. Conformance is checked by
[`../../scripts/check-okf.sh`](../../scripts/check-okf.sh), which recurses the tier folders;
only the OKF-reserved `index.md`/`log.md` are skipped (the former `lens-WIP.md` exemption is
gone — it's a frontmattered frozen file now).

## Open threads to research

- OKF spec details vs. our needs: concept identity (path-derived — decided; revisit only if a stable `id` becomes necessary), conformance/permissiveness model.
- Local tooling stack: search (e.g. `qmd`, SQLite FTS5), graph/backlinks, viewer.
- Ingest/query/lint workflows and how much to encode in the agent schema.
- Provenance and guardrails for agent-written notes (citations, grounding, eval).
- ~~Prior art / existing tools survey~~ — **done**, see [prior-art-landscape.md](analysis/prior-art-landscape.md) (Clew `0005`; re-architected into Layer 1 in `0006`). Follow-ups it surfaced: (a) **borrow-vs-build spike on Basic Memory** — neutral code recon planned as increment `0008` (its output lands as a Tier-1 proxy source; the borrow-vs-build _verdict_ then updates [for-us-builders.md](recommendations/for-us-builders.md)); (b) **revisit the edit-in-place vs regenerate lean** (synthesis #3) — shipping market leans regenerate (llm_wiki, OB1); (c) ~~lead with provenance/trust~~ — adopted as the wedge in [for-us-builders.md](recommendations/for-us-builders.md).
- ~~**Layer 2 persona re-architecture**~~ (deferred from `0006`) — **done in `0009`**: [lens-WIP.md](recommendations/lens-WIP.md) reorganized into per-persona Tier-3 docs ([us-builders](recommendations/for-us-builders.md) / [enterprise staff](recommendations/for-enterprise-staff.md) / [enterprise IT](recommendations/for-enterprise-it.md)) plus the SPS-specific [sps-guide.md](recommendations/sps-guide.md); "us-builder MUST conform to OKF" captured in that persona's requirements profile. An OKF conformance _checklist_ remains open.
- **SPS guide upkeep:** [sps-guide.md](recommendations/sps-guide.md) is provisional by design — its SPS policy claims are dated and need periodic re-verification against the DSOL Confluence pages and developer-docs guardrails; open questions are tracked in the guide itself.

## Ideas worth considering more:

###

- Atomicity as a universal design principle: Breaking complex concepts down into modular, single-variable components makes your thinking, writing, and coding incredibly reusable.
- **Networked over hierarchical thinking**: Moving away from rigid folders and embracing associative tags or direct links prevents information from getting trapped in artificial silos.
- **Writing to think, not just to record**: Treating notes as an active dialogue partner rather than a passive graveyard of text fundamentally alters how efficiently you synthesize the world around you.
  - [Nikko] This strikes me as particularly critical, at least while AI's are still bound by current Transformer based architectures where models can't _really_ do critical thinking or engage with causality (re: Yann Lecun's "Après moi, le déluge" quote describing the inadequacy of LLMs alone driving agentic systems.) Given those limitations, Humans have to be the key decision maker for anything of long lasting consequence (e.g. al type 1 decisions;) and the key quality checker for critical thinking of any consequential system. (amusingly, an assessment of which LLMs / current agentic systems would be poor at making ) - as such, it's both personally and societally important to minimize "cognitive drift"
