---
id: 8
status: backlog
tags:
- research
created_at: 2026-06-21T15:01:52Z
updated_at: 2026-06-21T15:01:52Z
---
## Requirements & the 'Why'

**Gap this fills.** Our three primary sources are all short/conceptual (an idea gist, a persuasive post, a format spec). Every implementation-depth artifact we hold is about **OB1**, which is DB-as-truth + cloud-coupled — the *inverse* of our stance. We have **no in-depth artifact of a real tool that made our bets**: files-as-truth, local-first, LLM-managed markdown. **Basic Memory** is the closest neighbour surveyed and the #1 flagged borrow-vs-build follow-up.

**Output.** ONE neutral, research-only teardown — `docs/impl-research/basic-memory-recon.md` — that functions as our **source-of-record** for Basic Memory so future work need not re-read the repo.

**Repo on disk:** `~/Projects/basic-memory/` (freshly cloned).

**Taxonomy note — updated 2026-07-02 by increment `0009` (supersedes the original note below).**
The "AI-synthesis that functions as a source" straddle this note wrestled with now has a real
home: the **proxy source** tier. The output doc should land at
`docs/impl-research/sources/basic-memory-recon.md` with `type: "proxy source - repo assessment"`,
the standard proxy banner, and the provenance block (`source_repo`, `source_ref` = pinned commit,
`assessed_date`, `assessed_by`, `proxy_for`) — see `docs/impl-research/working-notes.md` → Doc
conventions → Proxy source discipline, and `docs/impl-research/proxy-source-refresh.md` for the
refresh procedure it should stay compatible with. Everything else in this increment (neutrality
mandate, subsystem decomposition, citation discipline) stands as written; the commit-pin +
file:line requirements below are exactly the proxy discipline.

_Original note (kept for lineage):_ This is `type: AI-synthesis` — we author it; it is decision-neutral. It is **not literally a primary source** (the repo is). It *functions* as one by being commit-pinned, citation-anchored (file:line on every claim), and verbatim where it matters (schema, frontmatter contract). Optional add-on, not required: vendor a tiny verbatim slice (DB schema + frontmatter contract only) as a separate thin `primary source` doc.

**Neutrality mandate (the load-bearing constraint).** Describe Basic Memory *on its own terms*. **NO advocacy:** no "what to steal," no "we should," no borrow-vs-build verdict, no fit-to-us framing, no comparison to our design, no recommendations. Those are deferred to a later `lens` increment. (This narrows the original open-thread framing, which bundled the "why not fork it?" verdict in — that verdict is explicitly out of scope here.)

## Brief for the executing session (start here)

1. **Read first:** this increment; `docs/impl-research/okf-spec.md` (format), `index.md` + `working-notes.md` (our conventions + `type` vocab), `style.md`. Skim `ob1-ingestion-recon.md` **only** as a structural template for a neutral recon — not for verdicts. Our `lens-WIP.md` / `ob1-synthesis.md`: concepts/vocabulary OK as a lens for *what to look for*; judgments are off-limits to import.
2. **Pin provenance first.** Record `git -C ~/Projects/basic-memory rev-parse HEAD`, the branch, and clone date in a vendor-banner block at the top of the new doc (mirror `okf-spec.md`'s banner).
3. **Explore with read-only sub-agents in parallel, decomposed by SUBSYSTEM (not directory).** Suggested cuts — adapt to what's actually there:
   - Source of truth & file format — where canonical data lives, frontmatter/identity contract.
   - Sync engine — files <-> DB/index, write-back, file-watching, conflict/rebuild.
   - Parsing / ingestion — markdown + frontmatter parsing, entity/relation extraction, links.
   - Storage / derived stores — DB schema (verbatim), FTS/vector/graph, migrations.
   - Retrieval / search / graph / backlinks.
   - Agent interface — MCP server, tools exposed, contracts.
   - CLI / UX / install / packaging / deployment.
   - Provenance / versioning / identity / history (if present).
4. **Each sub-agent returns a focused WRITTEN finding**, not file dumps: component, responsibility, key files as `path:line`, core data structures (verbatim snippets of schema/types/frontmatter), control flow, external deps, notable design choices — stated neutrally, every claim cited to `path:line`.
5. **Main session synthesises** into the single doc: a component-map table + per-subsystem sections. Quote only load-bearing snippets verbatim. Separate **"stated intent" (README/docs)** from **"observed implementation" (code)**. Flag uncertain/aspirational/unmerged code honestly (cf. OB1's entity-wiki on unmerged PRs).
6. Note versions: language/runtime, key deps + lockfile, and an "as-of commit" caveat.

## Neutrality guardrails (tone Definition of Done)

- No "should / recommend / steal / borrow / better / worse / win"; no first-person-plural about *us*.
- Every evaluative-sounding statement is either (a) Basic Memory's own stated claim (attributed) or (b) a falsifiable fact cited to code.
- Final pass: grep the doc for advocacy words and neutralise.
- Does **not** answer "why not fork/extend it?" — deferred to a later `lens` increment.

## Acceptance criteria

- [ ] `docs/impl-research/sources/basic-memory-recon.md` created; OKF-conformant frontmatter (`type: "proxy source - repo assessment"`, `title`, `description`, provenance block); commit-pinned proxy banner. _(Path + type updated by `0009`.)_
- [ ] Component-map table + per-subsystem sections covering at least: source-of-truth/file format, sync, parsing/ingestion, storage/schema, retrieval/graph, agent/MCP interface, CLI/deploy.
- [ ] Load-bearing structures captured verbatim (DB schema, frontmatter contract) with `path:line` citations.
- [ ] "Stated intent" vs "observed implementation" separated; aspirational/unmerged parts flagged.
- [ ] Neutrality pass done (no advocacy; borrow-vs-build explicitly deferred).
- [ ] `index.md` updated with the new entry; `scripts/check-okf.sh` passes.
- [ ] `working-notes.md` open thread (a) updated: neutral recon done; borrow-vs-build verdict still pending in `lens`.

## Tasks

- [ ] Pin provenance (commit SHA, branch, clone date).
- [ ] Fan out subsystem recon via read-only sub-agents.
- [ ] Synthesise neutral teardown (component map + per-subsystem sections + verbatim load-bearing excerpts).
- [ ] Verify: spot-check 3-5 claims back to code; flag uncertainty.
- [ ] Neutrality pass (advocacy-word grep).
- [ ] Wire into bundle (frontmatter, index.md, check-okf.sh) + update working-notes open thread.
