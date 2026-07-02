# 2nd-brain-research

Research on **local-first, LLM-managed second brains** — personal knowledge wikis where an AI
does the bookkeeping and knowledge compounds — written so an SPS colleague exploring this space
doesn't have to redo the research from scratch.

Docs are tiered so you can tell **evidence** from **analysis** from **recommendation** before you
read: Tier 1 sources are external artifacts (verbatim, or commit-pinned "proxy" assessments),
Tier 2 is decision-neutral analysis built on them, Tier 3 is opinion. Every claim traces to a
source; every doc is dated.

## Where to go

- **"Just tell me what to do at SPS."** →
  [`docs/impl-research/recommendations/sps-guide.md`](docs/impl-research/recommendations/sps-guide.md)
  — sanctioned stack, data-classification rules, connector governance, what clears the bar today.
- **"I want to weigh it myself."** → Tier 2 analysis, starting with the
  [prior-art landscape](docs/impl-research/analysis/prior-art-landscape.md) (design-space map +
  tool survey); recommendations per persona live in
  [`recommendations/`](docs/impl-research/recommendations/).
- **"Show me the raw sources."** → Tier 1 in
  [`sources/`](docs/impl-research/sources/) — the Karpathy LLM-wiki gist, Nate's "Open Brain"
  post, the OKF spec, Kieran's second-brain writeup, and our commit-pinned repo assessments.
- **Full catalog + conventions:** [`docs/impl-research/index.md`](docs/impl-research/index.md) ·
  [`working-notes.md`](docs/impl-research/working-notes.md).

## Working in this repo

Format: the bundle is dogfooded as [OKF](docs/impl-research/sources/okf-spec.md) (markdown +
YAML frontmatter + links); run `scripts/check-okf.sh` after adding docs. Style:
[`style.md`](style.md). Work tracking: Clew (see [`AGENTS.md`](AGENTS.md)).
