---
type: "recommendation - SPS colleague (staff + builder)"
title: "Second brains at SPS: start here"
description: "For an SPS colleague exploring second brains: the mental model (what an LLM-wiki / open-brain / second-brain is and how the approaches differ), your options ranked simplest to most capable, and a concrete getting-started recipe. Policy is pointed to, not restated."
date: "2026-07-02"
---

# Second brains at SPS: start here

> **Tier 3 · opinion · provisional (2026-07-02).** This doc is a starting point and a set of mental
> models for understanding the options and differentiators across the many approaches to an
> LLM-wiki / second-brain / open-brain. When you experiment with your own second-brain system,
> refer back to the [SPS AI policy](https://spscommerce.sharepoint.com/sites/aiatsps/SitePages/AI%20at%20SPS.aspx)
> for what data may and may not be passed into Claude. Deeper analysis and the underlying sources
> live in [Tier 2](../analysis/prior-art-landscape.md) and [Tier 1](../index.md).

## What a "second brain" actually is

Normally an LLM answers from your raw documents at query time (RAG): it re-reads and re-derives
what it needs each session, and little or nothing accumulates. The goal of any of these
second-brain systems is to change that. The LLM builds and maintains a persistent, interlinked set
of markdown notes that sits between you and your raw sources; you feed it material and ask
questions, and it does the filing, summarizing, cross-linking, and contradiction-flagging. The
synthesis is compiled for you and kept current, so knowledge compounds instead of being
rediscovered each time ([seed idea, Karpathy](../sources/andrej-wiki-gist.md)).

The names you'll hear are the same idea from different angles; don't get hung up on branding:

- **"LLM wiki":** the workflow and philosophy; an AI-maintained living wiki you curate ([Karpathy gist](../sources/andrej-wiki-gist.md)).
- **"Open Brain":** one specific product built on the idea (Postgres + MCP, cloud-hosted) ([Nate B. Jones](../sources/nate-post-open-brain.md)). Useful to learn from, but not recommended for SPS use because it relies on third-party cloud databases (Supabase and similar).
- **"AI second brain":** a GTM leader's real working setup, an Obsidian vault plus Claude Code ([Kieran Flanagan](../sources/kieran-ai-second-brain.md)). Potentially the closest published example of what might work well for many SPS staff; we don't yet know what fits which people or departments best.
- **"PKM" (personal knowledge management):** the broad category all of these sit in.

## The forks that change your experience

Four choices separate the approaches; knowing where you sit on each is most of the mental model.
Only the third-party-cloud line is a firm SPS constraint. The rest are trade-offs to experiment
with, and the right answer will differ by person, role, and department.

| Fork | Options | Trade-offs |
|---|---|---|
| **Where truth lives** | Plain **files** vs. a **local database** (SQLite/DuckDB) | Both are viable. Files are the most portable and tool-agnostic and need no setup; a local DB can pay off for scale or fast structured queries. The firm line isn't files-vs-DB, it's **local vs third-party cloud**: keep the source of truth on your device or approved storage, not in a hosted service like Supabase. |
| **Does the AI maintain it?** | AI **edits the notes** (living wiki) vs. you **store & search** them (RAG) | A maintained wiki compounds but needs a good operating loop; a store-and-search pile is simpler but doesn't build on itself. This is also the difference between the setups below. |
| **On new info** | **Regenerate** the page vs. **edit in place** | Both have pros and cons: regenerate keeps a page internally consistent; edit-in-place keeps a living narrative and its history. Worth experimenting with for your workflow. |
| **Note size** | Human-readable **concept pages** vs. small extracted **atoms** | Concept pages are what you'll read and curate; atoms can retrieve better and suit some workflows or departments. Start page-level unless you have a reason not to. |

Full taxonomy (13 axes) and the tool-by-tool survey: [prior-art landscape](../analysis/prior-art-landscape.md).

## Your options at SPS, simplest to most capable

Everyone already has Claude Enterprise with Projects and per-user memory. That baseline is
deliberately not enough on its own: you don't control what gets synthesized, how it's structured,
or when it refreshes, which is exactly why the setups below exist. The real question is how much of
the maintenance loop you want the AI to run, and where.

1. **Claude Code + a local markdown vault (the Kieran pattern).** Claude Code reads and writes your
   actual files on disk: it files new material into the right note, updates entity pages, adds
   links, and flags contradictions. This is the living-wiki loop; the AI maintains the brain and
   you curate and direct. This is what most people mean by "a second brain that works."
2. **Add Obsidian as the viewer.** Point Obsidian at the same folder for graph view, backlinks, and
   browsing while the agent edits (see the Obsidian note below before you install it).
3. **Add local search / MCP / scripts.** When you want deterministic search (grep / SQLite FTS) or
   want to reach the brain from other projects and chats, add a local-only MCP server over the
   files, plus lint passes for orphans and contradictions.

> **Obsidian at SPS, before you install it:** Security has flagged Obsidian's sync features. Per
> current guidance (provisional; confirm with Security GRC), **Obsidian Sync and iCloud/cloud vault
> sync are not approved and must stay off**; do not enable either. Obsidian as a local viewer over
> files in approved storage is the safe shape; its cloud sync is not.

## Getting started: a concrete starter (option 1)

You don't need our tooling (there isn't any yet; this is research). Here's the shape to stand up
today with Claude Code and a folder:

1. **Make the vault.** A folder, ideally a `git` repo so every AI edit is a reviewable diff. Back
   it up to SharePoint or OneDrive for approved storage and durability.
2. **Seed the structure** (this is the [OKF](../sources/okf-spec.md) shape: markdown plus YAML
   frontmatter plus plain links):
   - `index.md`: the map and entry point the agent keeps current.
   - `log.md`: a chronological capture stream (Karpathy's pattern).
   - concept notes (`people/`, `projects/`, `topics/…`) created as you go, connected with ordinary
     markdown links. Use standard `[text](path.md)` links rather than Obsidian `[[wikilinks]]`:
     standard links are OKF's convention and the most reliably followed by agents and tools, and
     Obsidian renders them fine too.
3. **Write the agent's operating instructions**, the "skill" layer where the quality comes from.
   Put a `CLAUDE.md` in the vault (or the same text as a claude.ai Project instruction or Skill)
   telling the agent: files are the source of truth; when I share a source, extract the key points
   and file them into the right note; create and update entity pages; keep links and `index.md`
   current; flag contradictions with existing notes; and cite where each claim came from so I can
   trust it.
4. **Run the loop.** Paste or point at a source, the agent files and links it, you review the diff
   or browse in Obsidian, then ask questions that pull across notes. Sourcing and good questions
   are your job; the filing and bookkeeping are the agent's.
5. **Grow only when it hurts.** Add Obsidian for browsing, grep/FTS or a local MCP server for
   retrieval, and a periodic "lint" chat for orphans, contradictions, and stale claims. Start
   simple and harden what you actually use.

**The one thing to get right is trust.** Because an LLM is writing these notes, have it cite
sources inline and keep edits reviewable (git diffs). Uncited AI-authored "knowledge" is the
failure mode, and it's the gap no surveyed tool closes well, so it's worth your attention
([why](for-us-builders.md#the-wedge-to-lead-with)).

Reading: [Kieran's writeup](../sources/kieran-ai-second-brain.md) (a real working setup) and the
[Karpathy gist](../sources/andrej-wiki-gist.md) (the pattern) are both short and worth ten minutes.

## Constraints (the short version)

- **Data classification:** your notes inherit it. Public and Internal content is fine on Claude
  Enterprise; keep Confidential out of an AI-maintained vault unless the use is reviewed; never put
  Restricted content (PII/PHI/PCI) into any AI. The authoritative reference is
  [AI at SPS](https://spscommerce.sharepoint.com/sites/aiatsps/SitePages/AI%20at%20SPS.aspx);
  follow it.
- **A local MCP server is worth adding once you want reach.** Its value is querying your brain from
  other projects and chat sessions instead of always opening a session inside the vault repo.
  (Reminder: running your own localhost MCP server is fine; just don't expose it beyond your
  device.)
- **New vendor tools that touch SPS data trigger GRC review.** Staying on files plus Claude
  Enterprise (the setups above) avoids that entirely, which is a large part of why it's the
  recommendation.

## Provisional / to verify

This guide is early; there's no established internal practice yet, so treat it as a starting point
rather than a report on what's proven. Points to confirm with owners:

- **Obsidian sync guidance** (Sync and iCloud/cloud vault sync not approved) → Security GRC. Stated
  from internal knowledge (2026-07); confirm.
- **Data-classification specifics for a personal AI-maintained vault** (what "reviewed use" means
  in practice for Confidential content) → Security GRC, anchored to
  [AI at SPS](https://spscommerce.sharepoint.com/sites/aiatsps/SitePages/AI%20at%20SPS.aspx).
