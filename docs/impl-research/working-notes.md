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
- **Real eventual audience:** enterprise rollout guidance for our workplace (mid-sized public co., ~3-4k FTEs) — get ahead of every employee rolling their own ad-hoc second brain.
- **Deployability is a first-class goal:** solutions must be usable by non-technical staff (e.g. GTM teams), not just engineers.

## Working assumptions

- **Format direction — _firm requirement_:** follow Google's Open Knowledge Format (OKF) as the baseline for knowledge files — markdown concept docs with YAML frontmatter and ordinary markdown links. The spec is vendored locally at [okf-spec.md](okf-spec.md) (OKF v0.1). (Upgraded from a ~90% working assumption to a requirement in increment `0006`. The persona-level framing — "the us-builder MUST conform to OKF" — and any conformance checklist are deferred to the Layer 2 persona increment.)
- **"Local-first" means local _data + infrastructure_, NOT local _models_.** Frontier cloud models (Anthropic / OpenAI) are the intended reasoning layer — specifically **Claude Enterprise** as the reference AI (approved + available to all staff at work). ⚠️ This _corrects_ a conflation in the research docs: `ob1-synthesis.md` leans Ollama-first and frames sensitivity gating as "never send to remote model" (#3, #15) — that's backwards from our actual stance. Local models stay an _option_, not the default.
- **No self-hosted services.** No Supabase / hosted Postgres / servers / Docker daemons that tech & security won't approve or that a non-technical user can't stand up. Storage, index, and infra stay local and simple. Derived stores (SQLite/DuckDB/FTS/vector) are views over files, never the source of truth.
- **Borrow format and patterns, not services** (e.g. from OKF / Google Knowledge Catalog).

## Doc conventions

### `type` frontmatter (OKF)

This folder is dogfooded as an OKF bundle (increment `0007`). Every concept doc
carries a non-empty `type` in YAML frontmatter — OKF's one hard rule. Values in
use:

- **`primary source - <medium>`** — external artifacts imported (near-)verbatim;
  the medium follows (`primary source - blog post`, `primary source - gist`,
  `primary source - specification`).
- **`AI-synthesis`** — docs the agent authored: surveys, recons, syntheses,
  audits, comparisons.
- **`working-notes`** — this file: project meta (direction, assumptions,
  conventions, threads).

`type` values are free-form and self-describing (OKF §4.1); add new descriptive
values as needed rather than forcing a fit. Concept identity is **path-derived**
(file path minus `.md`, per OKF §2) — no stable frontmatter `id`. Conformance is
checked by [`../../scripts/check-okf.sh`](../../scripts/check-okf.sh).

Exemptions (not bundle concepts, skipped by the check): the reserved
[`index.md`](index.md), and [`lens-WIP.md`](lens-WIP.md) (our unorganized opinion
working file).

### Layering (`reference` / `lens` / `source`) — informal

An older convention (increment `0006`) tagged each doc by layer to keep facts
separable from opinion:

- **`reference`** — decision/requirement-neutral domain map; describes forks, does not advocate.
- **`lens`** — opinionated: recommendations, verdicts, "what to steal," per-persona readouts.
- **`source`** — an imported external artifact we're studying.

This is now a **loose, informal** distinction, not a frontmatter field. The
classification of record is OKF `type` (above). The factual/opinion separation
still matters in practice — facts and decision-neutral analysis live in
[`prior-art-landscape.md`](prior-art-landscape.md); opinion/recommendations are
parked in [`lens-WIP.md`](lens-WIP.md), to be reorganized into a persona-structured
`recommendations-by-persona.md` later.

## Open threads to research

- OKF spec details vs. our needs: concept identity (path-derived — decided; revisit only if a stable `id` becomes necessary), conformance/permissiveness model.
- Local tooling stack: search (e.g. `qmd`, SQLite FTS5), graph/backlinks, viewer.
- Ingest/query/lint workflows and how much to encode in the agent schema.
- Provenance and guardrails for agent-written notes (citations, grounding, eval).
- ~~Prior art / existing tools survey~~ — **done**, see [prior-art-landscape.md](prior-art-landscape.md) (Clew `0005`; re-architected into Layer 1 in `0006`). Follow-ups it surfaced (opinion captured in [lens-WIP.md](lens-WIP.md)): (a) **borrow-vs-build spike on Basic Memory** — install + read its sync/schema-tool source, answer "why not fork/extend it?"; (b) **revisit the edit-in-place vs regenerate lean** (synthesis #3) — shipping market leans regenerate (llm_wiki, OB1); (c) **lead with provenance/trust** — the one wedge absent from every neighbor surveyed.
- **Layer 2 persona re-architecture** (deferred from `0006`): reorganize [lens-WIP.md](lens-WIP.md) into a persona-structured `recommendations-by-persona.md` (us / enterprise non-tech staff / enterprise IT-builder), each a short requirements profile + recommendation pointing into Layer 1 by anchor; add the "us-builder MUST conform to OKF" framing + any OKF conformance checklist.

## Ideas worth considering more:

###

- Atomicity as a universal design principle: Breaking complex concepts down into modular, single-variable components makes your thinking, writing, and coding incredibly reusable.
- **Networked over hierarchical thinking**: Moving away from rigid folders and embracing associative tags or direct links prevents information from getting trapped in artificial silos.
- **Writing to think, not just to record**: Treating notes as an active dialogue partner rather than a passive graveyard of text fundamentally alters how efficiently you synthesize the world around you.
  - [Nikko] This strikes me as particularly critical, at least while AI's are still bound by current Transformer based architectures where models can't _really_ do critical thinking or engage with causality (re: Yann Lecun's "Après moi, le déluge" quote describing the inadequacy of LLMs alone driving agentic systems.) Given those limitations, Humans have to be the key decision maker for anything of long lasting consequence (e.g. al type 1 decisions;) and the key quality checker for critical thinking of any consequential system. (amusingly, an assessment of which LLMs / current agentic systems would be poor at making ) - as such, it's both personally and societally important to minimize "cognitive drift"
