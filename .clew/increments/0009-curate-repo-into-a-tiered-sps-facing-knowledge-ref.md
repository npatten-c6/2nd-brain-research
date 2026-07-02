---
id: 9
status: in_progress
tags:
- research
created_at: 2026-07-02T16:00:17Z
updated_at: 2026-07-02T16:19:18Z
---
## Requirements & the 'Why'

Tighten and re-curate this repo into **the one-stop reference for SPS colleagues starting to
explore local-first / LLM-managed second-brain / open-brain / personal-wiki approaches** — so
they don't each redo the research from scratch.

**Root-cause why (the north star — hand this to the executing session, not just the rules).**
The repo must make two questions cheap to answer for any reader, forever:

1. **"Where did this claim come from?"** — _provenance_. Every assertion traces to a specific
   artifact (and, for a repo we assessed rather than vendored, a specific commit).
2. **"Is it still true, and how do I check?"** — _freshness_. A reader can tell whether a source
   has moved on, and knows how to refresh it.

Everything below serves those two questions. That is why we separate evidence from analysis from
recommendation, why proxies are commit-pinned, and why SPS policy claims are cited and dated.

**The core move: a 3-tier epistemic ladder** (decided with the human; see _Soft recommendations_
for the shape). Evidence → analysis → recommendation, made legible so a newcomer who has done zero
research can tell what kind of thing they're reading before they open it.

**Audience reframe.** The docs were written for "us" (the researchers). The primary reader is now an
SPS colleague exploring this space. "Us" becomes _one persona_, no longer the default reader.

## How to read this increment (firm vs. soft)

Guidance here is split deliberately. **Share the root-cause _why_ with yourself as you work** — it
travels further than any rule.

- **Firm invariants** — the small set of things that make this repo trustworthy. State each _with_
  its why. They are **firm-but-rebuttable**: don't drift past them casually, but if you have a
  genuinely strong reason that serves the _why_ better, do the better thing and record it in the
  decision summary.
- **Soft recommendations** — the specific _how_ (folder names, field names, wording, structure).
  These are the human's current preference, decided in the planning session, but you own the
  mechanics. If a better mechanism serves the same why, take it and note the deviation.

## Firm invariants (rebuttable only for strong, why-serving reasons)

1. **The 3-tier separation exists and is legible at a glance.**
   _Why:_ a stranger's trust depends on being able to tell evidence from analysis from
   recommendation _before_ reading. That separability is the repo's core credibility.
2. **Tier-1 sources stay faithful and carry no advocacy; "proxy" sources are commit-pinned and
   citation-anchored.**
   _Why:_ the provenance question. A claim is only a _source_ if it traces to a specific artifact
   at a specific version — otherwise it's analysis wearing a source's clothes.
3. **Every claim is traceable to where it came from, in some form.**
   _Why:_ both questions. No orphan assertions; analysis cites the sources it rests on, so a reader
   (or a future refresh) can find the blast radius when a source changes.
4. **Nothing is fabricated. SPS policy/approval claims are cited, dated, and route to the owning
   team — never asserted as definitive.**
   _Why:_ freshness + the repo is worse than useless if it misleads on what's allowed at SPS.
   Policy is point-in-time and team-owned; the guide's job is to point, not to rule.

## Soft recommendations (the decided shape — you own the mechanics)

### Tier model — 3 tiers, "proxy" is a flagged source (not its own tier)

- **Tier 1 — Sources.** Each marked **primary** (verbatim external artifact) _or_ **proxy** (our
  commit-pinned assessment standing in for a repo we didn't vendor).
  - Primary today: `andrej-wiki-gist.md`, `nate-post-open-brain.md`, `okf-spec.md`, the Kieran
    "AI Second Brain" post.
  - Proxy today: `knowledge-catalog-patterns.md`, `ob1-ingestion-recon.md`, and the in-flight
    Basic Memory recon (increment `0008`). These are the awkward "AI-synthesis that functions as a
    source" docs — the proxy tier is their real home.
- **Tier 2 — Derived Analysis.** `prior-art-landscape.md`, `nate-post-claims-audit.md`,
  `okf-andrej-nate-comparison.md`, `ob1-synthesis.md`.
- **Tier 3 — Recommendations / Guides.** `lens-WIP.md` reorganized into the planned per-persona
  recommendations, plus the new SPS guide (below).

(These placements are a starting read, not gospel — reclassify if the content says otherwise.)

### Encoding — physical folders **and** frontmatter (both)

- Physical folders so a newcomer sees the ladder at a glance, e.g. `sources/`, `analysis/`,
  `recommendations/` under `docs/impl-research/` (adapt names if clearer). Keep OKF `type`
  frontmatter in sync as the machine-readable classification of record.
- Cost to absorb: moving files re-points cross-links and changes OKF path-derived concept identity.
  This is a one-time cost and the repo is small — fix every link, and re-run `scripts/check-okf.sh`.
- `index.md` and `working-notes.md` stay bundle meta (not tiered concept docs).

### Proxy provenance rigor

Every proxy source should carry (recommended shape; mirror `okf-spec.md`'s vendor banner):

- A visible banner: _"Assessment of the code, not the code itself — verify against source before
  relying."_
- Frontmatter/provenance block: `source_repo` (URL), `source_ref` (commit SHA or version/tag),
  `assessed_date`, `assessed_by` (agent/model), and a one-line "what this is a proxy _for_."
- Discipline: findings cite `path:line` into the source repo where possible; separate the source's
  _stated intent_ from _observed implementation_. (This matches how `0008` already frames it.)

### SPS contextualization — a dedicated, provisional Tier-3 SPS guide

- A recommendations doc aimed squarely at an SPS colleague: what's realistic here (Claude Enterprise
  as the sanctioned AI, no self-hosted infra, security/approval realities), which surveyed approaches
  actually clear the SPS bar, and a "start here if you're at SPS" on-ramp. It's the concrete
  instantiation of the "enterprise non-tech staff" + "enterprise IT/builder" personas for our actual
  company.
- **Explicitly provisional.** The SPS Developer MCP is _incomplete context_; this guide will be
  iterated with input from others. Write it as **working understanding + open questions to confirm
  with the owning teams**, not confident assertions. Prefer "as of <date>, per <source>, our reading
  is… — confirm with <team>."
- **Guardrail (ties to firm invariant 4 and org policy):** cite SPS-sourced facts via the MCP, date
  them, flag uncertainty, and route readers to Security / IT / the Claude Enterprise admins. Do not
  present policy, compliance, or approval status as definitive.

**Anchor facts already found via the SPS Developer MCP (June–July 2026; verify + expand, don't trust
blindly):**

- Claude Enterprise is the sanctioned enterprise AI at SPS; Microsoft Copilot was put on hold in its
  favor. Governance surface lives mostly in the **DSOL** Confluence space:
  - _Claude Enterprise — Decision Log_ (DSOL, 780118458)
  - _Claude Capabilities: Organizational Settings & Admin Reference_ (DSOL, 769063006)
  - _Claude Platform — Connection Registry_ (DSOL, 780120502) — shows connector statuses incl.
    **"Enabled via Local MCP — builders only"** and dated "Approved" rows.
  - _Claude Enterprise — Admin Controls & Feature Toggles_ (769813768); _Enterprise Claude_ (IAM,
    769788468).
- Connector/MCP policy is specific and quotable, e.g. _"Auto-approve for connectors: OFF — users
  cannot permanently approve connector tools; each use requires explicit approval"_; inbound push
  from external MCP servers is flagged as a prompt-injection surface; org-wide MCP allowlists + spend
  controls exist.
- **Data-classification → AI-usage matrix** (developer docs, `/guardrails/data-classification#ai-usage`):
  Public → free public AI tools; Internal → SPS-licensed AI only; Confidential → approved AI with
  legal + security review (no DeepSeek); Restricted → no AI tools. This governs _what may go in a
  second brain and which AI may touch it_.
- MCP build guardrails (`/guardrails/mcp`), AI-agent guardrails (`/guardrails/ai-agents`), and an AI
  tools catalog (`/ai/tools`) exist.
- **SPS is all-in on Claude (as of 2026-07).** Individual employee harnesses/agents run on **Claude
  Enterprise**; application/system-level inference runs on **Claude via AWS Bedrock**. Copilot and
  Cursor are being **sunset** — so treat the older `/ai/tools` Cursor entries as stale, and don't
  frame the space as a multi-vendor bake-off. (This corrects the planning-session probe, which
  surfaced a Cursor usage policy that no longer reflects direction.)
- Internally, **almost no prior PKM/second-brain material exists** (one stale 2019 page) — the gap
  this repo fills is real.

### Audience & navigation — newcomer-first front door, personas underneath

- **Root `README.md` = the front door.** Thin: one paragraph on what this is / who it's for (an SPS
  colleague exploring second-brain approaches) + **intent-based routing**:
  - _"Just tell me what to do at SPS"_ → Tier-3 SPS guide
  - _"I want to weigh it myself"_ → Tier-2 analysis
  - _"Show me the raw sources"_ → Tier-1
  - Do **not** duplicate the catalog into the README.
- **`docs/impl-research/index.md`** stays the OKF bundle catalog; README points into it.
- Keep the three personas (us-experimenter / enterprise non-tech staff / enterprise IT-builder) as
  the _structure_ of Tier 3. "Us" survives as one persona.

### OB1 worked example — traceable refresh with downstream re-check

The OB1 repo has been updated and re-pulled to `~/Projects/OB1`. Use it as the worked example of a
_traceable refresh_:

1. Rebuild the OB1 proxy source at current HEAD (pin the new `source_ref`).
2. **Then check the blast radius** — the Tier-2 analysis built on the old OB1
   (`prior-art-landscape.md`, `ob1-synthesis.md`, `nate-post-claims-audit.md`) may now be partly
   stale; flag/re-check what changed. This is the payoff of traceability: the repo lets you _find_
   what's downstream instead of guessing.
3. Write a short, repeatable **"how to refresh a proxy source"** note (pull repo → read at HEAD →
   rebuild proxy → bump `source_ref` → re-check downstream analysis). Turns a one-off into a
   capability any SPS colleague can repeat.

### Relationship to increment `0008`

`0008` (neutral Basic Memory recon) is the first _creation_ of a proxy source; the OB1 rebuild is the
first _refresh_. Reconcile: `0008`'s output should land in the proxy tier with the proxy provenance
block, resolving its "AI-synthesis that functions as a source" straddle. Don't silently delete or
rewrite `0008` — coordinate (it can run under this taxonomy, or its taxonomy note updated to point
here).

### Review lens — the SPS AI Builder persona (goal-mode rubric)

Evaluate the result the way the **real primary reader** would, not an idealized one. The persona is
captured at [`sps-ai-builder-persona.md`](../../docs/impl-research/sources/sps-ai-builder-persona.md)
(synthesized from the SPS #guild-ai Slack channel; doubles as an _audience-proxy source_ — home it
in the proxy tier).

**Use it as a critique persona.** Near the end, run a review pass _in character as this persona_
(a dedicated review sub-agent, given the persona doc as its brief) that scores the repo against the
persona's 6-point checklist, then fix what it flags and re-run until it passes. This stands in for
the SPS AI-builder reader we can't put in the room.

The persona also **sharpens a real tension in our design**: it wants dense, single-file,
LLM-legible docs ("one `thing.md`, not a multi-page site"), while our tiers spread the corpus across
files. Resolve it, don't ignore it: the _tiers organize the corpus_, but **each Tier-3 guide should
be self-contained enough to drop into an agent's context and be useful on its own** (links out for
evidence, but doesn't _require_ the reader to hop tiers to act).

## Goal / definition of done (goal-mode — self-verifiable)

The goal is met when an SPS AI Builder landing cold can, **in under ~60 seconds**, tell what this is,
where to go for their need, and trust it. Concretely — these are outcome criteria you can check
yourself (and via the persona review):

- **Legible ladder:** a newcomer can tell evidence from analysis from recommendation before reading
  (firm invariant 1) — verified by the folder layout + front-door routing.
- **Droppable guides:** each Tier-3 guide is self-contained enough to paste into an agent's context
  and be useful (persona checklist #1); dense and skimmable, actionable steps up top (#4).
- **Dated & freshness-flagged:** every doc carries a date and flags what may be stale given weekly
  tool churn (#2; freshness why). Proxies are commit-pinned.
- **Names real SPS friction:** the SPS guide names actual constraints (IAM/Okta, GRC vendor review,
  MCP-connector approval model, data-classification → AI-usage matrix, Claude-Enterprise / Bedrock
  posture) rather than pretending a frictionless "just install X" world (#3).
- **Covers both ends of the use-case range:** advanced agent-builder _and_ everyday small tasks (#5).
- **Cites real internal precedent:** points to concrete SPS sources (Confluence pages, repos) over
  vendor marketing (#6); provenance traceable throughout (firm invariant 3).
- **Names tradeoffs plainly:** cost, rate limits, security-review status, lock-in — not hype.
- **Persona review passes:** the in-character review sub-agent signs off on all six checklist items
  (or remaining gaps are listed in the decision summary as known/open).
- **Mechanically clean:** `scripts/check-okf.sh` passes; no broken cross-links; `lens-WIP.md`
  reorganized into Tier 3; `0008` reconciled into the proxy tier.

## Execution protocol — autonomous, on a branch, end with a decision summary

**No human approval gates. Do not stop to ask.** Work end-to-end on a **new branch** off `main`
(e.g. `curate/0009-tiered-sps-reference`) so the human reviews the whole thing as a branch/PR and
iterates from there. Make the file moves, rebuild the OB1 proxy, write the SPS guide, rewrite the
README — all of it.

Two things replace the old sign-off gates:

- **SPS policy claims → provisional, not blocking.** Still honor firm invariant 4: write SPS
  policy/approval claims as _provisional_ (cited, dated, "confirm with <team>"), never as
  definitive. Instead of pausing, **list every such claim in the decision summary** so the human
  and owning teams can verify.
- **Firm-invariant rebuttals → note, don't block.** If you find a strong, why-serving reason to
  deviate from a firm invariant or a soft recommendation, just do the better thing and record it in
  the decision summary.

**End deliverable — a super-concise decision summary** (the last thing you output and/or a short
`DECISIONS.md` on the branch): terse bullets only, covering:

- Primary structural decisions (final tier folders, notable file→tier placements, any renames).
- Deviations from this increment's recommendations, each with a one-line why.
- **SPS policy claims to verify** (claim → source → owning team).
- Open questions / known gaps / anything the persona review still flags.

Keep it scannable in under a minute — that is itself a test of whether you internalized the audience.

**Read first:** this increment; `style.md`; `sps-ai-builder-persona.md` (the review lens);
`docs/impl-research/index.md` + `working-notes.md` (conventions + `type` vocab); `okf-spec.md`
(format + banner style); `lens-WIP.md` (the opinion to reorganize into Tier 3); `.clew/archive/0006-*.md`
(prior layering rationale); `0008` (proxy template). Follow `style.md` for all authoring.

## Acceptance criteria

All work lands on a **branch** (no human gates); the goal criteria above are the bar. Concretely:

- [ ] Work done on a new branch off `main`; ends with a super-concise **decision summary**
      (bullets + SPS-claims-to-verify + deviations + open gaps), scannable in <1 min.
- [ ] Repo reorganized into 3 legible tiers (folders + synced `type` frontmatter); every doc placed;
      `scripts/check-okf.sh` passes; all cross-links fixed.
- [ ] Tier-1 sources marked primary vs proxy; each proxy carries banner + provenance block
      (`source_repo`/`source`, `source_ref`, `assessed_date`, `assessed_by`, proxy-for).
- [ ] OB1 proxy rebuilt at current HEAD; downstream Tier-2 analysis re-checked/flagged; a reusable
      "how to refresh a proxy source" note exists.
- [ ] Dedicated, provisional SPS Tier-3 guide exists: self-contained/droppable, dated, cited + dated
      SPS facts, open questions, routes to owning teams; no policy asserted as definitive; names real
      SPS friction; covers advanced + everyday use cases.
- [ ] Root `README.md` is a thin, newcomer-first front door with intent-based routing; catalog not
      duplicated; three personas preserved as Tier-3 structure.
- [ ] `lens-WIP.md` reorganized into Tier-3 per-persona recommendations (fact-free pointers into
      Tier 2).
- [ ] Persona review pass run in-character; its 6-point checklist satisfied (or gaps listed in the
      decision summary); persona doc homed as an audience-proxy source.
- [ ] `0008` reconciled into the proxy tier (coordinated, not silently overwritten).
- [ ] `working-notes.md` updated: new tier convention documented; open threads reconciled.
- [ ] Firm invariants hold (or any rebuttal is recorded in the decision summary with its why).

## Tasks

- [x] Cut a branch off `main` (`curate/0009-tiered-sps-reference`).
- [x] Draft the tier folder layout + file→tier mapping; move files; fix all cross-links; sync `type`
      frontmatter; re-run `check-okf.sh`. _(Folders: `sources/` `analysis/` `recommendations/`;
      Kieran post renamed `kieran-ai-second-brain.md` + given `type`; check-okf now recurses.)_
- [x] Add proxy banners + provenance blocks to existing proxies; home the persona doc in the proxy tier.
      _(knowledge-catalog-patterns pinned to GitHub @ `ba17dd5` — the local clone was gone, so its
      relative links were already dead; braided-analysis caveat added to both repo-assessment proxies.)_
- [x] Rebuild OB1 proxy at HEAD; re-check downstream analysis; write the refresh note.
      _(`2a15199` → `671b923`, 88 commits: assessed pipeline byte-for-byte unchanged; additive
      subsystems catalogued in a refresh addendum; freshness notes added to prior-art-landscape,
      ob1-synthesis, nate-post-claims-audit — no verdict flips; `proxy-source-refresh.md` written.)_
- [x] Gather + cite SPS facts (SPS Developer MCP); write the provisional, self-contained SPS Tier-3
      guide. _(`recommendations/sps-guide.md`. ⚠️ Contradiction with this increment's anchor facts:
      developer docs still document Copilot as live/requestable; no sunset evidence on the fetched
      pages — written up as unresolved + routed to Enterprise AI & Analytics.)_
- [x] Reorganize `lens-WIP.md` into Tier-3 per-persona recommendations. _(`for-us-builders.md`,
      `for-enterprise-staff.md`, `for-enterprise-it.md`; lens-WIP frozen with superseded banner —
      kept per the preserve-intermediaries convention.)_
- [x] Rewrite root `README.md` as the newcomer-first front door.
- [x] Reconcile `0008` into the proxy tier (taxonomy note updated in place, original kept for
      lineage; output path now `sources/basic-memory-recon.md`); update `working-notes.md`
      conventions + open threads.
- [ ] Run the in-character persona review sub-agent against the 6-point checklist; fix flagged gaps;
      re-run until it passes (or gaps recorded). _(In flight.)_
- [ ] Write the decision summary; final pass: verify firm invariants + goal criteria; spot-check
      provenance/freshness on a few claims.
