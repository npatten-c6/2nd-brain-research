---
type: "recommendation - enterprise non-technical staff persona"
title: "Recommendations — Enterprise non-technical staff"
description: "What a non-technical employee (e.g. GTM) can realistically run today: the install + approval bar, which surveyed tools clear it, and what to avoid."
date: "2026-07-02"
---

# Recommendations — Enterprise non-technical staff

> **Tier 3 · opinion.** For (and about) the employee who wants a second brain but won't stand up
> infrastructure. Evidence: [prior-art landscape](../analysis/prior-art-landscape.md) (deployment
> axes + tool entries). Reorganized from [`lens-WIP.md`](lens-WIP.md) (increment `0009`). At SPS?
> Start with [the SPS guide](sps-guide.md) instead — it instantiates this for our actual approval
> process and sanctioned AI.
>
> _Freshness:_ verdicts as of the 2026-06-18 survey; tool capabilities and licensing change
> weekly — re-verify before recommending to a team.

## The bar that actually decides

Architecture quality does not pick the winner here; the **install + approval bar** does:

1. A non-technical employee can install it in minutes (no server, no Docker, no API plumbing).
2. Data stays in local/approved files or approved storage.
3. It runs on the company's sanctioned AI (for us: Claude Enterprise) — not a random vendor key.
4. Security/IT can say yes without a bespoke review of self-hosted infrastructure.

## Verdicts (2026-06-18 survey)

- **Most realistic today: Obsidian + AI plugins** (e.g. Smart Connections). Install an app, point
  at a model. Weakest on "the LLM maintains the wiki," strongest on adoptability. Note the
  editor itself is local files — the plugin's model wiring is the part needing approval.
- **Best fit in spirit: a managed/one-click local MCP server behind the sanctioned AI**
  (Basic Memory-shaped). Files on disk, no DB server — but MCP setup is still too technical for
  this persona without IT packaging it. This is a "watch + push IT" option, not self-serve today.
- **Plain files + the sanctioned AI's own file/project features** — the zero-approval floor.
  No compounding wiki, but nothing to install and nothing new for security to review.
- **Out for self-serve:** anything needing a server or Docker (Khoj self-host, agent-memory
  stacks like Mem0/Letta/Cognee), single-dev desktop apps with their own API-key wiring
  (nashsu/llm_wiki — also GPL-3), and cloud-hosted options where notes leave approved storage.

Per-tool readout (as of 2026-06-18; tool entries with evidence in the
[landscape](../analysis/prior-art-landscape.md)):

| Tool | Deployable by non-tech staff? | What it needs | Verdict for enterprise rollout |
|---|---|---|---|
| **Sanctioned AI + local MCP server** (e.g. Basic Memory) | 🟡 Medium | Local MCP server; connect from the AI client. Files on disk, no DB server. | **Best fit in spirit** — but MCP setup is still technical; needs one-click/managed install to clear the bar. |
| **Obsidian + plugins** (Smart Connections, Copilot) | ✅ High | Install Obsidian + a plugin; point at a model. | **Most realistic for broad staff** today. Weakest on "LLM maintains the wiki," strongest on adoptability. |
| **nashsu/llm_wiki** | ✅ High (single user) | Desktop app install; bring an API key. | Good adoptability as an app; but individual desktop tool, GPL-3, regenerate-model — not an org-sanctioned platform. |
| **Khoj (self-host)** | ❌ Low | Server + DB, Docker; or cloud (data leaves). | Self-host fails no-infra; cloud fails data-residency. Org-hosted = a real IT project. |
| **AnythingLLM (desktop)** | ✅ High (desktop) / ❌ (Docker) | Desktop one-click + bundled vector DB; multi-user is Docker. | Desktop edition is staff-deployable; but document-RAG chat, not a compounding wiki. |
| **Mem0 / Letta / Cognee** | ❌ Low | Python, infra, vector/graph DBs. | Building blocks for builders, not end-user tools. |
| **sqlite-memory** | ❌ Low | Dev tool (SQL ext / CLI). | Infra/plumbing, not an end-user product. |

## What to tell this persona

- Start with the lowest-friction sanctioned option; build the **capture habit** before the tooling
  ([claims audit](../analysis/nate-post-claims-audit.md) — the habit, not the stack, is the
  compounding part; "no curation needed" is marketing).
- Keep notes as plain markdown files in approved storage from day one — every credible tool in
  this space can adopt a folder of markdown later; proprietary formats are the lock-in to avoid.
- Don't paste sensitive data into unapproved tools; classification rules apply to your notes too
  (at SPS: see the [data-classification → AI matrix](sps-guide.md#data-classification--what-may-go-in-a-second-brain)).

## The unsolved gap (for whoever builds/buys next)

An _LLM-maintained living wiki_ that a non-technical employee installs in minutes, runs on the
sanctioned enterprise AI, keeps data in local/approved files, and needs zero server — nothing
surveyed clears all four. That gap is what to track (and what [our build track](for-us-builders.md)
aims at).
