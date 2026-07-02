---
type: "recommendation - enterprise IT/builder persona"
title: "Recommendations — Enterprise IT / platform builder"
description: "For the team standing up a sanctioned second-brain option org-wide: what to package, what to gate, and the governance surface that decides success."
date: "2026-07-02"
---

# Recommendations — Enterprise IT / platform builder

> **Tier 3 · opinion.** For the IT/platform person asked "can we roll out a second-brain option
> for staff?" Evidence: [prior-art landscape](../analysis/prior-art-landscape.md). Reorganized
> from [`lens-WIP.md`](lens-WIP.md) (increment `0009`). At SPS, the concrete instantiation —
> actual approval tracks, owners, and toggles — is [the SPS guide](sps-guide.md).
>
> _Freshness:_ verdicts as of the 2026-06-18 survey; re-verify tool status before committing.

## Framing: you are packaging an approval, not picking an architecture

The [staff persona's](for-enterprise-staff.md) bar (minutes-install, approved storage, sanctioned
AI, no bespoke infra review) is the product spec. The surveyed tools that are architecturally
closest to "right" (files-as-truth + LLM-maintained + MCP) all fail that bar _today_ on install
friction — which makes the IT move packaging, not building from scratch:

- **Near-term:** bless a config, don't build — e.g. Obsidian + a vetted plugin config, or the
  sanctioned AI's native file/project features, with a documented "keep it markdown, keep it in
  approved storage" convention.
- **Medium-term:** a **managed local MCP server** (Basic Memory-shaped) packaged for one-click
  deployment (MDM), connected to the sanctioned AI as a governed connector. This is the "best fit
  in spirit" option promoted to viable by IT doing the packaging.
- **Don't** stand up multi-user servers holding personal notes (Khoj-style org hosting): it
  converts a personal-files problem into a data-custody + auth + retention project, and the
  surveyed self-host options aren't worth that cost.

## The governance surface that decides success

Whatever you pick, these are the gates that make or break the rollout (they, not features, are
where surveyed rollouts stall):

- **Connector/MCP approval model** — who approves a new tool surface on the sanctioned AI, per-use
  vs standing approval, allowlists. Local MCP means device-management (MDM) deployment questions.
- **Data classification** — which classes of notes may touch which AI; personal knowledge bases
  accumulate mixed-classification content by nature, so the guidance has to be written for that.
- **Prompt-injection posture** — an LLM that reads files it also writes is an injection surface;
  ingest hardening exists in the surveyed code ([OB1 recon](../sources/ob1-ingestion-recon.md))
  but policy has to require it.
- **Identity + licensing** — SSO-gated model access, seat cost at org scale, quota behavior.
- **Exit story** — plain-markdown data means the tool can be swapped without a migration project;
  make that a hard requirement.

## What to watch

- **The unsolved gap** (staff doc, last section) is real across the whole survey — if a vendor or
  internal build closes it, the packaging calculus changes.
- **Provenance/trust for LLM-authored notes** is absent from every surveyed neighbor and is
  exactly what an enterprise reviewer will eventually ask for ("who wrote this claim, from
  what?"). Prefer tools/builds that carry citations + review gates
  ([our wedge](for-us-builders.md#the-wedge-to-lead-with)).
