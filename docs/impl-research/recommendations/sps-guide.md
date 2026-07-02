---
type: "recommendation - SPS colleague (staff + builder)"
title: "Second brains at SPS — start here"
description: "Provisional guide for SPS colleagues: what's sanctioned, what the real constraints are (data classification, connector governance, device trust), which second-brain approaches clear the SPS bar today, and who owns the answers."
date: "2026-07-02"
---

# Second brains at SPS — start here

> **Tier 3 · opinion · ⚠️ provisional.** Written 2026-07-02 from the SPS Developer MCP (developer
> docs + DSOL Confluence). This is a **working understanding, not policy** — every SPS claim below
> is dated and cites its source; the governance surface changes weekly, so verify anything
> load-bearing against the cited page and the owning team before acting. Corrections welcome —
> this guide is meant to be iterated with input from the teams named below.
>
> Self-contained by design: you can paste this one file into an agent's context and act on it.
> Evidence and deeper analysis live in [Tier 2](../analysis/prior-art-landscape.md) /
> [Tier 1](../index.md) — linked, not required.

## TL;DR — what to actually do

**Everyday use (no build, no approvals):**

1. Use **Claude Enterprise** — sign in with SPS SSO (claude.ai with your `@spscommerce.com`
   account; personal accounts can't attach corporate connectors — verified-domain restriction,
   [Decision Log](https://atlassian.spscommerce.com/wiki/spaces/DSOL/pages/780118458), 2026-06-17).
   Projects, chat, file uploads, web search, artifacts, and per-user **memory** are enabled
   (Decision Log, as of 2026-07-01).
2. Keep your notes as **plain markdown files** in approved storage (OneDrive/SharePoint per the
   [data-classification guardrail](https://developer.docs.spscommerce.com/guardrails/data-classification)).
   Markdown is the exit story: every credible tool in this space can adopt a folder of markdown
   later.
3. Respect the **data-classification → AI matrix** ([below](#data-classification--what-may-go-in-a-second-brain))
   — it governs what may go in your notes and which AI may touch them.
4. Small tasks count. The same setup handles "fix this Excel formula," "summarize this meeting
   transcript," and "draft this post" — don't wait for an advanced use case.

**Builder use (Claude Code + local files — the Kieran pattern, SPS edition):**

1. Request **Claude Code** access via the standard IAM ticket desk; sign-in is SSO via MySPS
   (Okta); support lives in **#claude-users**
   ([developer docs](https://developer.docs.spscommerce.com/ai/tools/claude-code), fetched
   2026-07-02). The docs don't say whether any separate Okta app step is involved — ask in
   #claude-users if your request stalls.
2. Point it at a local folder of markdown notes — the
   [Kieran worked example](../sources/kieran-ai-second-brain.md) (Obsidian vault + Claude Code)
   is the closest published shape to what works here: files-as-truth, sanctioned AI, no new vendor.
3. Auto-permissions mode is security-approved (with bypass mode disabled org-wide); local MCP
   servers are **currently unconstrained** by managed settings — but treat that as point-in-time,
   not a blessing ([below](#connector--mcp-governance-the-approval-reality)).
4. Anything beyond personal files — a shared system, a new connector, a vendor tool — enters the
   **Claude Platform intake process**. Budget for it; don't route around it.

## The sanctioned stack (as of 2026-07, provisional)

- **Claude Enterprise is the governed enterprise AI.** SPS runs a dedicated org with SSO/domain
  capture, SCIM, restricted org creation, a contractual no-training clause, and a full
  decision log of admin settings — the governance surface lives in the **DSOL** Confluence space
  (_Claude Enterprise — Decision Log_, page 780118458, v4 2026-07-02; _Organizational Settings &
  Admin Reference_, 769063006, updated 2026-07-01). Owner: **Enterprise AI & Analytics** (platform
  owner); security posture: **AI Enablement / Cyber Engineering & Defense**.
- **Application/system-level inference runs on AWS Bedrock** — the AI-agents guardrail's golden
  path deploys agents to Atlas EKS / Bedrock with SECOPS approval per agent
  ([/guardrails/ai-agents](https://developer.docs.spscommerce.com/guardrails/ai-agents),
  fetched 2026-07-02). Your personal second brain is *not* this path; an org-deployed knowledge
  service would be.
- **⚠️ Unresolved — Copilot/Cursor status.** Our planning input (2026-07) says SPS is
  consolidating on Claude with Copilot and Cursor being sunset; the developer docs still document
  Copilot as live and requestable ("SPS Commerce provides Copilot licenses for eligible
  developers," [/ai/tools](https://developer.docs.spscommerce.com/ai/tools), fetched 2026-07-02),
  and the TAD FAQ treats Copilot/Cursor/Claude Code as parallel tools. One of these is stale.
  **Confirm with Enterprise AI & Analytics before planning around either version.** This guide
  assumes the Claude-consolidation direction but nothing below depends on it.

## Data classification — what may go in a second brain

The [data-classification guardrail](https://developer.docs.spscommerce.com/guardrails/data-classification)
(standard v10.0, approved 2025-09-25; fetched 2026-07-02) is the single most load-bearing
constraint on a second brain, because notes accumulate mixed-classification content by nature:

| Your note contains…                                            | Classification | AI allowed                                                    |
| -------------------------------------------------------------- | -------------- | ------------------------------------------------------------- |
| Public material (published docs, public specs)                  | Public         | Any AI, incl. free public tools                                |
| Ordinary work notes, procedures, project docs                   | Internal       | **SPS-licensed AI only** (Claude Enterprise qualifies)         |
| Customer data, pricing, contracts, strategy, financials         | Confidential   | Approved AI **with legal + security review of the use**; no DeepSeek |
| PII/PHI/PCI (SSNs, payroll, health, card data)                  | Restricted     | **No AI, period**                                              |

Practical readings (ours, not policy — confirm edge cases with Security):

- A personal second brain on Claude Enterprise is fine for **Public + Internal** content.
- **Confidential** content in an AI-touched knowledge base needs the use case reviewed and logged
  ("Logged as an approved AI use case" — guardrail, Do/AI Usage). Don't quietly accumulate
  customer specifics in a vault an AI reads.
- **Restricted never goes in.** Interesting precedent: the surveyed second-brain code already
  implements this shape — OB1 regex-gates `restricted` content out of cloud paths
  ([OB1 recon §6](../sources/ob1-ingestion-recon.md)); whatever you build should too.
- **Never use customer data to train AI models** (guardrail, hard rule).

## Connector / MCP governance (the approval reality)

Docs that say "just install X" are naive here. The actual surface, as of the cited dates:

- **Every system connected to Claude Enterprise is governed** through the _Claude Platform —
  Connection Registry_ (DSOL page 780120502, updated 2026-06-23): one row per system, risk tiers
  (High = write access / sensitive data / big blast radius), **Track A** intake for new systems,
  **Track B** for new methods/config changes, SECGRC review always required for High-tier and any
  Custom Remote MCP, annual revalidation. Unregistered systems must register (Application SOP for
  vendor apps, Tech Registry for SPS-built) before intake proceeds. Requests go to the Claude
  Platform Jira project.
- **Per-use connector approval is deliberate:** _"Always allow for connectors: OFF — users cannot
  permanently approve connector tools; each use requires explicit approval. This reduces prompt
  injection risk"_ (Admin Reference, 769063006, 2026-07-01). Cowork's "act without asking" is
  likewise off. Expect the approval clicks; they're policy, not a bug.
- **Local MCP is a recognized method with its own gate:** the registry's "Extension / Local MCP"
  method requires **MDM deployment approval, IT coordination, and device-group scoping**; the one
  currently-enabled example is scoped _"via Local MCP — builders only"_ (Power BI row, registry,
  2026-06-23). Meanwhile Claude Code's server-managed settings (incl. MCP allow/deny lists) are
  **not yet deployed** (Admin Reference; tracked as TECHSOL-342) — so today a builder can run
  local MCP servers unconstrained. Read that as a **window, not a policy**: the documented
  direction is a managed allowlist. Building a personal, local, files-only MCP server appears to
  sit in a gray zone between "your dev tooling" and "a governed connection" — **ask in
  #claude-users / the Claude Platform project before investing**, and expect the answer to move.
- **Prompt injection is the recurring rationale** across the decision log (Channels backlogged,
  ambient Slack mode off, always-allow off). An LLM-maintained wiki is itself an injection
  surface (the LLM reads files it also writes); if you build one, adopt the ingest hardening the
  surveyed code already uses (`<document>` wrapping, treat-as-data prompts —
  [OB1 recon §1](../sources/ob1-ingestion-recon.md)).
- **Device trust is rolling out:** Jamf (macOS) / InTune (Windows) enrollment required, unmanaged
  devices denied (Admin Controls & Feature Toggles, 769813768, 2026-05-29 — older page; confirm
  current state). Your second brain lives on an enrolled device or it doesn't talk to Claude.
- **New vendors trigger GRC vendor review** (registry prerequisite policy + Application SOP).
  That includes "harmless" note tools if they touch SPS data with AI.

## Which surveyed approaches clear the SPS bar

Judgment call against the constraints above (evidence: [prior-art landscape](../analysis/prior-art-landscape.md),
[deployability readout](for-enterprise-staff.md)):

| Approach                                                        | SPS verdict today (2026-07-02)                                                                                                                       |
| ---------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Plain markdown + Claude Enterprise** (projects/uploads/memory)  | ✅ Clears now. Zero new approvals. The floor everyone should start on.                                                                                  |
| **Local markdown vault + Claude Code** (Kieran pattern)           | ✅ Clears for builders now (IAM ticket for Claude Code). Files local, AI sanctioned, no new vendor.                                                     |
| **Obsidian (+ AI plugins) as the vault UI**                       | 🟡 Obsidian-as-editor over local files is likely fine as desktop software, but **verify its software-approval status** (GRC/IT) — and any *plugin that calls a model* is its own AI-tool question. Not in the connection registry as of 2026-06-23. |
| **Local MCP server over files** (Basic Memory-shaped)             | 🟡 Technically possible today (managed MCP settings not yet deployed); governance gray zone — Extension/Local MCP method exists with MDM/IT gates for governed systems. Ask before building; expect tightening. |
| **DB-as-truth cloud stacks** (OB1: Supabase + OpenRouter)         | ❌ New vendors + SPS data through unapproved AI endpoints = vendor review you will not enjoy. Also architecturally the wrong bet ([claims audit](../analysis/nate-post-claims-audit.md)). |
| **Self-hosted servers** (Khoj etc.)                               | ❌ Infra to stand up + custody of personal notes = an IT project, not a personal tool ([enterprise-IT readout](for-enterprise-it.md)).                  |

Tradeoffs to keep in view (nobody's marketing will volunteer these): Claude Enterprise spend is
tracked and capped at org level with member-visible analytics (Decision Log, 2026-07-01) — heavy
agentic workflows (Workflows feature: "up to 1,000 subagents, high token consumption") are watched
on a leadership dashboard; automated code review bills separately with configurable caps; retention
of Claude conversations is unlimited **pending a Legal/Compliance review** (Decision Log) — your
chat history is not ephemeral; and any tool you adopt is a bet on its survival — keep the exit
story (markdown files) non-negotiable.

## Internal precedent (who's tried what)

- **#guild-ai** — the practitioner community this repo's [review persona](../sources/sps-ai-builder-persona.md)
  is distilled from (Jun–Aug 2025 window): senior engineers building MCP servers, agents, and RAG
  experiments, alongside everyday-task users. The channel's standing complaints — docs that aren't
  LLM-legible, tribal knowledge scattered across Confluence/Slack, governance friction on every
  new tool — are the problems a second brain addresses.
- **#claude-users** — support channel for Claude Code ([developer docs](https://developer.docs.spscommerce.com/ai/tools/claude-code)).
- **SPS-built MCP servers already through governance** (registry, 2026-06-23: Developer MCP,
  Attributes, Fulfillment Monitor, System Automation, Brand & Messaging — all "Enabled") — proof
  the intake path works and the pattern to copy for anything shared.
- **Prior internal PKM/second-brain material: essentially none** (our 2026-06/07 searches found
  one stale 2019 page — provisional claim; a deeper Confluence sweep may surface more). This repo
  is the gap-filler; that's why it exists.

## Open questions to confirm (with owners)

1. **Copilot/Cursor sunset vs. live docs** — which is current? → Enterprise AI & Analytics.
2. **Personal local MCP over private files: dev tooling or governed connection?** Where's the
   line, and will the coming managed MCP allowlist have a personal-use lane? → Claude Platform /
   Enterprise AI & Analytics (#claude-users to start).
3. **Obsidian software-approval status** (and model-calling plugins specifically) → IT / Security GRC.
4. **Confidential-class notes in a personal AI-touched vault** — what does "logged as an approved
   AI use case" mean for an individual, practically? → Security GRC.
5. **Device-trust rollout state** (Jamf/InTune requirement — the 2026-05-29 page may be stale) → IT.
6. **Does the org want a packaged/blessed second-brain option** (the
   [enterprise-IT recommendation](for-enterprise-it.md)) rather than N ad-hoc personal ones? →
   Enterprise AI & Analytics. This repo's research is the input for that conversation.

## Provenance of every SPS claim above

| Claim                                                       | Source (all fetched 2026-07-02)                                        | Confirm with                    |
| ----------------------------------------------------------- | ----------------------------------------------------------------------- | -------------------------------- |
| Data-classification → AI matrix; no-AI-on-Restricted; no customer-data training | [/guardrails/data-classification](https://developer.docs.spscommerce.com/guardrails/data-classification) (standard v10.0, 2025-09-25) | Security                         |
| Connector registry, risk tiers, Track A/B, SECGRC triggers, Local-MCP method gates | DSOL 780120502 _Connection Registry_ (updated 2026-06-23)               | Enterprise AI & Analytics        |
| Feature toggles: memory on, always-allow off, bypass off, auto mode approved, retention pending review | DSOL 780118458 _Decision Log_ (v4, 2026-07-02) · DSOL 769063006 _Admin Reference_ (2026-07-01) | Enterprise AI & Analytics        |
| Managed settings / MCP allowlist not yet deployed (TECHSOL-342) | DSOL 769063006 (2026-07-01)                                              | Enterprise AI & Analytics        |
| Device trust (Jamf/InTune), SSO/domain capture, no-training clause | DSOL 769813768 _Admin Controls_ (2026-05-29 — oldest page here)          | AI Enablement / Cyber Eng & Defense |
| Claude Code access via IAM ticket; #claude-users             | [/ai/tools/claude-code](https://developer.docs.spscommerce.com/ai/tools/claude-code) | IT / IAM desk                    |
| Bedrock golden path + SECOPS approval for agents             | [/guardrails/ai-agents](https://developer.docs.spscommerce.com/guardrails/ai-agents) | SECOPS / ACE Engineering         |
| MCP build standards (naming, auth, reviews)                  | [/guardrails/mcp](https://developer.docs.spscommerce.com/guardrails/mcp) | Engineering Enablement           |
| Copilot documented live (vs. sunset direction)               | [/ai/tools](https://developer.docs.spscommerce.com/ai/tools)             | Enterprise AI & Analytics        |
