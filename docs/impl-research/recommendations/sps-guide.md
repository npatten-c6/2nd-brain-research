---
type: "recommendation - SPS colleague (staff + builder)"
title: "Second brains at SPS — start here"
description: "For an SPS colleague exploring second brains: the mental model (what an LLM-wiki / open-brain / second-brain actually is and how the approaches differ), your options ranked simplest-to-most-capable, and a concrete getting-started recipe. Governance is pointed to, not restated."
date: "2026-07-02"
---

# Second brains at SPS — start here

> **Tier 3 · opinion · ⚠️ provisional (2026-07-02).** This gives you the _mental model_ and a
> _getting-started path_ — the things not already documented elsewhere. It deliberately does **not**
> re-explain Claude Enterprise, MCP, or AI policy; those live in
> [AI at SPS](https://spscommerce.sharepoint.com/sites/aiatsps/SitePages/AI%20at%20SPS.aspx) and the
> developer guardrails, and are pointed to below. Evidence for the claims here lives in
> [Tier 2 analysis](../analysis/prior-art-landscape.md) and [Tier 1 sources](../index.md).

## What a "second brain" actually is

Normally an LLM answers from raw documents at query time (RAG): it re-reads and re-derives
everything on every question, and nothing accumulates. A **second brain** flips that — the LLM
**builds and maintains a persistent, interlinked set of markdown notes** that sits between you and
your raw sources. You feed it material and ask questions; it does the filing, summarizing,
cross-linking, and contradiction-flagging. The knowledge is compiled once and kept current, so it
_compounds_ instead of being rediscovered each time ([the seed idea, Karpathy](../sources/andrej-wiki-gist.md)).

The names you'll hear are the same idea from different angles — don't get hung up on branding:

- **"LLM wiki"** — the workflow/philosophy: an AI-maintained living wiki you curate ([Karpathy gist](../sources/andrej-wiki-gist.md)).
- **"Open Brain"** — one specific *product* built on the idea: Postgres + MCP, cloud-hosted ([Nate B. Jones](../sources/nate-post-open-brain.md)). Useful to learn from; **not** the shape we'd copy (see forks below).
- **"AI second brain"** — a GTM leader's actual working setup: an Obsidian vault + Claude Code ([Kieran Flanagan](../sources/kieran-ai-second-brain.md)). The closest published example to what works at SPS.
- **"PKM" (personal knowledge management)** — the broad category all of these sit in.

## The forks that change your experience

Four choices separate the approaches. Knowing where you sit on each is the whole mental model:

| Fork | Options | What we lean, and why |
|---|---|---|
| **Where truth lives** | Plain **files** you own vs. a **database/app** | **Files.** Portable, no infra to stand up, and the notes outlive any tool. (Open Brain is DB-as-truth + cloud — the thing to *not* copy.) |
| **Does the AI maintain it?** | AI **edits the notes** (living wiki) vs. you just **store & search** them (RAG) | This is the big one. A maintained wiki compounds; a pile of notes you retrieve from doesn't. It's also the difference between the two SPS options below. |
| **On new info** | **Regenerate** the page fresh vs. **edit in place** | Open question — the shipping market leans regenerate; edit-in-place keeps a living narrative. Try either. |
| **Note size** | Human-readable **concept pages** vs. tiny extracted **atoms** | Start page-level; it's what you'll actually read and curate. |

Full taxonomy (13 axes) and the tool-by-tool survey: [prior-art landscape](../analysis/prior-art-landscape.md).

## Your options at SPS — simplest to most capable

Everyone already has Claude Enterprise, so the real question is *how much of the maintenance loop
you want the AI to run*. These stack — start at the top, grow down only when you feel the limit.

1. **Chat + Projects (claude.ai / desktop).** Keep notes as markdown files; pull them into a
   Project and ask questions; Claude's per-user memory accumulates across chats. **Store &
   retrieve** — Claude reads your notes but does **not** edit them; you copy things in and out.
   Zero setup, good for non-builders and for trying the idea.
2. **Claude Code + a local markdown vault (the Kieran pattern).** Claude Code reads **and writes**
   your actual files on disk — it files new material into the right note, updates entity pages,
   adds links, flags contradictions. This is the **living-wiki loop**: the AI maintains the brain,
   you curate and direct. This is what most people mean by "a second brain that works."
3. **+ Obsidian as the viewer.** Point Obsidian at the same folder for graph view, backlinks, and
   browsing while the agent edits. Optional read-UI over option 1 or 2.
4. **+ local search / MCP / scripts.** When you want deterministic search (grep / SQLite FTS) or
   want other local tools to query the brain, add a **local-only MCP server** over the files
   (loopback/stdio on your own machine — see constraints). Add lint passes for orphans/contradictions.

**So what's the difference between #1 and #2?** Whether the AI *maintains* your files or just
*reads copies* of them. In #1 your notes are uploaded snapshots and Claude's memory is the only
thing that grows; in #2 Claude edits your real markdown in place, so the vault itself is the
compounding artifact. #1 is a searchable pile; #2 is a living wiki.

## Getting started — a concrete starter (option 2)

You don't need our tooling (there isn't any yet — this is research). Here's the shape to stand up
today with Claude Code + a folder:

1. **Make the vault.** A folder, ideally a `git` repo (so every AI edit is a reviewable diff).
   Back it up to **SharePoint/OneDrive** — that's the approved-storage + durability answer.
2. **Seed the structure** (this is the [OKF](../sources/okf-spec.md) shape — markdown + YAML
   frontmatter + plain links):
   - `index.md` — the map / entry point the agent keeps current.
   - `log.md` — a chronological capture stream (Karpathy's pattern).
   - concept notes (`people/`, `projects/`, `topics/…`) created as you go; link them with `[[wikilinks]]`.
3. **Write the agent's operating instructions** — this is the "skill" layer, and it's where the
   quality comes from. Put a `CLAUDE.md` in the vault (or the same text as a claude.ai **Project
   instruction** / **Skill**) telling the agent: _files are the source of truth; when I share a
   source, extract the key points and file them into the right note; create/update entity pages;
   keep links and `index.md` current; **flag contradictions** with existing notes; and **cite where
   each claim came from** so I can trust it._
4. **Run the loop.** Paste or point at a source → the agent files and links it → you review the
   diff / browse in Obsidian → ask questions that pull across notes. Sourcing and good questions
   are your job; the filing and bookkeeping are the agent's.
5. **Grow only when it hurts.** Add Obsidian for browsing, grep/FTS or a local MCP server for
   retrieval, a periodic "lint" chat for orphans/contradictions/stale claims. Start dumb, harden
   what you actually use.

**The one thing to get right: trust.** Because an LLM is writing these notes, make it cite sources
inline and keep edits reviewable (git diffs). Uncited AI-authored "knowledge" is the failure mode —
it's also the gap no surveyed tool closes well, so it's worth your attention
([why](for-us-builders.md#the-wedge-to-lead-with)).

Reading: [Kieran's writeup](../sources/kieran-ai-second-brain.md) (a real working setup) and the
[Karpathy gist](../sources/andrej-wiki-gist.md) (the pattern) are both short and worth 10 minutes.

## Constraints (the short version)

- **Data classification** — your notes inherit it. Public/Internal are fine on Claude Enterprise;
  keep Confidential out of an AI-maintained vault unless the use is reviewed; never put Restricted
  (PII/PHI/PCI) into any AI. The authoritative reference is
  [AI at SPS](https://spscommerce.sharepoint.com/sites/aiatsps/SitePages/AI%20at%20SPS.aspx) —
  follow it, we're not restating it here.
- **Local-only MCP over your own files is fine.** A loopback/stdio MCP server on your own machine,
  not exposed to the network, is just your dev tooling — no different from a local script. SPS
  connector/MCP *governance* is about wiring **vendors or shared systems** into Claude Enterprise
  (remote connectors), which is a different thing; if you go there, it's the Claude Platform intake
  process, not a personal-vault concern.
- **New vendor tools that touch SPS data trigger GRC review.** Staying on **files + Claude
  Enterprise** (options 1–2) avoids that entirely — which is a large part of why it's the
  recommendation.

## Provisional / to verify

This guide is early and meant to be iterated. Known-soft points, with who owns the answer:

- **Nobody at SPS has publicly run a second brain yet** — our 2026-06/07 searches found essentially
  no prior internal PKM material (one stale 2019 page). This repo is the starting point, not a
  report on established practice. (Verify via a deeper Confluence sweep.)
- **Org direction is consolidating on Claude Enterprise** (employee harnesses) with app-level
  inference on Claude via AWS Bedrock — as of 2026-07, per planning input; confirm current posture
  with **Enterprise AI & Analytics**.
- **Data-classification specifics for a personal AI-maintained vault** (what "reviewed use" means
  in practice for Confidential content) → **Security GRC**, anchored to
  [AI at SPS](https://spscommerce.sharepoint.com/sites/aiatsps/SitePages/AI%20at%20SPS.aspx).
