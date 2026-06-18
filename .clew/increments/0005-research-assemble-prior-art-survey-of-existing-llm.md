---
id: 5
status: backlog
tags:
- research
created_at: 2026-06-18T13:47:48Z
updated_at: 2026-06-18T13:47:48Z
---
## Requirements & the 'Why'

We've deeply studied three *reference designs* (OKF / Andrej's LLM Wiki / Nate's Open Brain) but never surveyed the **shipping tools** that solve the same value prop: a local-first, LLM-managed personal knowledge base where an LLM does the bookkeeping and knowledge compounds. This is a genuine blind spot.

**Goal of this increment:** do broad, *verified* internet research and assemble a durable prior-art doc at `docs/impl-research/existing-tools-prior-art.md`. Outcome we want: (1) know what already exists, (2) identify our closest neighbors and whether to borrow-vs-build, (3) harvest concrete patterns/techniques worth stealing, (4) confirm whether our specific niche (files-as-truth + local-only + OKF + LLM-maintained living wiki) is actually unoccupied.

**Context to read first** (don't re-derive what we already concluded):
- `docs/impl-research/research-index.md` — catalog + working assumptions (files-as-truth, OKF, local-only).
- `docs/impl-research/okf-andrej-nate-comparison.md` — the comparison axes/forks this survey must map onto.
- `docs/impl-research/ob1-synthesis.md` — our engineering decisions + open forks.
- `docs/impl-research/nate-post-claims-audit.md` — the skeptical-reading lens. **Apply it.**

## Lens / what we care about (use these as the comparison axes)

Map every tool onto the same axes we already use in `okf-andrej-nate-comparison.md` so results slot in:
source-of-truth (files / DB / hybrid) · knowledge unit & granularity · synthesis model (edit-in-place / regenerate / none) · retrieval (FTS / vector / graph / hybrid / context-dump) · local vs cloud + local-model support · agent interface (MCP / CLI / plugin / API) · capture style (curate vs ambient) · provenance/trust handling · maturity & is-it-alive.

## Verification discipline (hard requirements — learned from the Gemini run)

The prior Gemini survey failed by giving **zero citations** and confabulating (fake quotes, invented dates, coarse tool-lumping, "MCP is dominant"). Do not repeat that. Rules:
- **Every factual claim carries a primary-source link** (repo README, official docs, source code, changelog). Blog/listicle = secondary, allowed only to point at primaries.
- **Mark each tool entry `verified` / `partial` / `unverified`.** Default unverified until seen at source.
- **Prefer primary over commentary.** Quote real text; never synthesize a "representative" quote.
- **Note recency** (last release / last commit) — flag abandoned projects.
- **Separate substance from hype.** Apply the claims-audit verdict tags where useful.
- When uncertain, say so. A short verified list beats a long speculative one.

## Recommended approach & effort tiering (don't boil the ocean)

Two-tier depth:
- **Tier 1 — deep-dive (top 3-5 closest neighbors):** fetch the actual repo/docs, fill the full per-tool schema, write a borrow-vs-build paragraph. **Khoj is the priority** (looks like our closest neighbor: local markdown + DB index + multi-client + local models). Spend most of the budget here.
- **Tier 2 — light entries (everyone else):** one-paragraph + filled schema row from primary sources, no deep code reading.

Suggested workflow: WebSearch to find candidates/primaries -> WebFetch the primary source per tool -> fill schema -> only deep-read code for Tier 1. Consider spawning `Explore`/research subagents to parallelize Tier-2 fact-gathering if useful. Budget: aim for a solid, citeable survey, not exhaustive — quality and verification over count.

## Seed candidates (verify each; add/cut freely)

From the Gemini run (UNVERIFIED leads — confirm they exist and match before trusting):
Khoj · Mem0 · Letta (MemGPT lineage) · Cognee · Reor · AnythingLLM · Obsidian Smart Connections · Obsidian Copilot.
Also actively look for ones it missed: Logseq + AI, Basic Memory, Notion AI, Mem.ai, GraphRAG-based PKM builds, "agentic memory" research, Zettelkasten/Roam-lineage LLM tools, and notable DIY/blog builds.

## Recommended output doc structure (`existing-tools-prior-art.md`)

1. **Header** — purpose, date, links to companion docs, a "verification legend."
2. **TL;DR** — 5-10 bullets: biggest takeaways, closest neighbors, is-our-niche-open verdict.
3. **Comparison table** — all tools x the lens axes above (same shape as `okf-andrej-nate-comparison.md`).
4. **Per-tool entries** — Tier 1 deep, Tier 2 light. Each: link · category · what-it-is · schema fields · maturity/activity · **what to steal** · **what to avoid/limitations** · verification status.
5. **Closest neighbors / borrow-vs-build** — focused analysis (esp. Khoj): what they got right, where they diverge from local-first/files-as-truth, what we'd do differently.
6. **Patterns worth stealing (cross-tool)** — concrete techniques (e.g. RRF hybrid, inbox/staging write gate, memory merge/invalidate logic, graph caching) tied back to our open forks/agenda.
7. **Gaps / is our niche open** — where nothing does what we want; risks to our thesis.
8. **Sources** — flat list of every primary link used.

## Acceptance criteria

- [ ] `existing-tools-prior-art.md` created and linked in `research-index.md` (+ retire/realize the "verify Khoj et al." open thread).
- [ ] >= 8 tools captured; Tier-1 deep-dive on the 3-5 closest neighbors (Khoj included).
- [ ] Every factual claim cites a primary-source link; each tool marked verified/partial/unverified.
- [ ] Results mapped onto our existing comparison axes (slot into the comparison doc's frame).
- [ ] Explicit borrow-vs-build readout for the closest neighbor(s).
- [ ] "Is our niche open?" verdict + concrete patterns-to-steal list tied to our agenda.

## Tasks

- [ ] Read the four context docs above; lock the per-tool schema from the comparison axes.
- [ ] Build/confirm the candidate list (verify seeds exist; hunt for missed ones).
- [ ] Tier-1 deep-dives (Khoj first) from primary sources.
- [ ] Tier-2 light entries from primary sources.
- [ ] Assemble the doc per the structure above (table + entries + neighbors + patterns + gaps).
- [ ] Cross-link from research-index.md; update the open-threads section.
- [ ] Self-check against verification discipline before marking done.
