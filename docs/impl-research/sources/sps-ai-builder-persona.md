---
type: "proxy source - persona synthesis"
title: "SPS \"AI Builder\" Persona"
description: "Synthesized persona of the SPS internal AI-builder audience, distilled from the guild-ai Slack channel. Doubles as the review lens for evaluating this repo's usefulness to that reader."
source: "SPS #guild-ai Slack channel (~60 messages over 6 weeks)"
source_window: "Jun–Aug 2025"
assessed_by: "Claude Sonnet"
assessed_date: "2026-07"
proxy_for: "the real SPS AI-builder reader — the primary audience this repo must serve"
---

<!--
PROXY SOURCE — a synthesized persona, not a verbatim artifact. It stands in for the
real SPS AI-builder audience, distilled from the #guild-ai Slack channel. Treat its
claims as a point-in-time reading of that channel (see frontmatter provenance);
re-derive if the audience shifts. Doubles as the review lens for this repo.
To refresh, see ../proxy-source-refresh.md (non-repo proxy: re-read the channel
forward from `source_window` and re-derive).
-->

# Persona: SPS "AI Builder" (guild-ai, ~60 msgs / 6wk, Jun–Aug 2025)

Use to eval AI guide/informational repos. Score docs against how THIS person would actually read/use them, not an idealized reader.

## Who
- Senior/staff SWE or tech-adjacent (platform, DevPortal, security/IAM, design systems, data/ML). Not a PM/exec persona.
- Self-taught on AI tooling, no formal training — learns via Slack links, YouTube, guild demos, trial-and-error.
- A few less-technical lurkers exist ("where do I fit in?") — persona is majority-eng but not 100%.

## Tool stack (all in flux, compared constantly)
Copilot (VS Code agent mode, primary/free), Cursor (POC, pricing-sensitive), Claude Code (POC, liked for plan-then-implement flow), Gemini CLI, ChatGPT/Codex, LM Studio/local models, FastMCP, Databricks (agent bricks, GPU compute), Sparky (internal AI, limited — no file type flexibility, no MCP).
- Nobody has ONE tool. Persona actively context-switches and compares output quality across models weekly.
- Licensing/quota friction is real and top-of-mind (Copilot Pro quota hit, SSMS Copilot separate license, Cursor POC access windows).

## Core behaviors
- Tinkerer: side projects, hackathons, "vibe coding" on weekends, shares blog writeups unprompted.
- Peer-driven, not doc-driven by default: prefers "I tried X, here's what happened" Slack posts + biweekly live demos over reading a wiki.
- High signal-to-noise bar: skims, reacts with emoji, rarely reads long threads fully unless personally blocked.
- Pragmatic scope split: uses AI for both frontier stuff (agents, RAG, MCP servers) AND trivial daily tasks (fix Excel formula, summarize meeting vtt, draft LinkedIn post). Guide content shouldn't assume only advanced use cases matter.

## What actively frustrates them (direct pain points, verbatim themes)
- **Docs not LLM-legible.** Explicit complaint: internal design-system docs are "awesome for humans" but LLMs can't use them — want a single condensed `thing.md` file, not a multi-page site. This is the #1 actionable insight for repo reviews: prefer single-file, dense, machine-parseable over spread-out wiki structure.
- **Tribal knowledge scattered** across Confluence/Slack/heads — repeatedly wished for a shared, queryable context source.
- **Governance/security friction**: every new MCP server or vendor tool triggers IAM tickets, Okta app creation, GRC vendor review. Docs that ignore this (e.g. "just install X") read as naive to this audience.
- **Stale/generic content is a dealbreaker.** Space moves weekly (new models, new CLI tools) — a guide with no date or version context loses credibility fast.
- **Vendor lock-in / pricing backlash skepticism** — early adopter but not credulous; call out tradeoffs, don't just hype.

## What they respond well to
- Concrete, copy-pasteable, SPS-specific examples over generic tutorials.
- Short, scannable format: bullets, code blocks, links — not prose walls.
- Real internal links (Confluence agenda page, Zoom recordings, GitHub repos) as primary evidence, not abstractions.
- Content that names tradeoffs plainly (cost, rate limits, security review status) instead of glossing over them.

## Repo-review checklist (apply this lens)
1. Could this doc be dropped into an agent's context as-is and be useful? (single-file bias, google open knowledge format interesting new approach worth considering?)
2. Is it dated / does it flag what may be stale given weekly tool churn?
3. Does it name the SPS-specific constraint (IAM/Okta, GRC vendor review, licensing tier) where relevant, or pretend a frictionless world?
4. Is it skimmable in <60sec, with actionable steps up top, not buried in narrative?
5. Does it cover both "advanced agent builder" and "everyday small task" use cases, or only one?
6. Does it cite real internal precedent (who tried this, what happened) vs. generic vendor marketing?

---

> **Freshness caveat (as of 2026-07):** the tool-stack snapshot above reflects the Jun–Aug 2025 channel window. Since then SPS has gone **all-in on Claude**: Copilot and Cursor are being sunset; individual employee harnesses/agents run on **Claude Enterprise**, and application/system-level inference runs on **Claude via AWS Bedrock**. The _behaviors, pain points, and review checklist_ remain the durable, reusable part; treat the specific tool list as historical.
