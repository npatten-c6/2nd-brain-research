# Increment 0009 — Decision summary

Branch `curate/0009-tiered-sps-reference`, 2026-07-02. Terse by design; details in the increment file.

## Structural decisions

- Tier folders under `docs/impl-research/`: `sources/` (T1) · `analysis/` (T2) · `recommendations/` (T3); `index.md`, `working-notes.md`, `proxy-source-refresh.md` stay bundle meta.
- T1 primary: andrej-wiki-gist, nate-post-open-**brain** (typo renamed), kieran-ai-second-brain (renamed from long clipping title + given `type`), okf-spec. T1 proxy: ob1-ingestion-recon, knowledge-catalog-patterns, sps-ai-builder-persona.
- T2: prior-art-landscape, ob1-synthesis, nate-post-claims-audit, okf-andrej-nate-comparison (frozen). T3: sps-guide + for-us-builders / for-enterprise-staff / for-enterprise-it + lens-WIP (frozen lineage).
- `type` synced to tiers: `primary source - *` / `proxy source - *` / `analysis - *` / `recommendation - *`; `check-okf.sh` recurses subfolders; lens-WIP exemption removed.
- OB1 proxy refreshed `2a15199` → `671b923` (88 commits): assessed pipeline unchanged; addendum catalogs new subsystems; downstream freshness notes added (no verdict flips). Repeatable procedure: `proxy-source-refresh.md`.
- README = thin intent-routed front door (SPS guide / weigh-it-yourself / raw sources); catalog not duplicated.
- Persona review (in-character SPS AI Builder): **6/6 PASS**; its polish items applied (tables inlined into live persona docs, Layer→Tier vocab, typo rename, `date:` frontmatter on T2).

## Deviations from the increment (each: what → why)

- knowledge-catalog-patterns links repointed to GitHub pinned @ `ba17dd5` → local clone is gone; relative links were already dead (provenance why).
- Both repo-assessment proxies keep braided "local-first adaptation" analysis, flagged in their banners as T2 material → honest labeling beats an expensive split; content predates the taxonomy.
- lens-WIP kept (frozen, frontmattered) instead of deleted → style.md preserve-intermediaries rule; its two big tables now *inlined* in successors after the persona review flagged the frozen file as load-bearing.
- T3 docs are "self-contained judgment + linked evidence," not strictly fact-free pointers → resolves the increment's own single-file-vs-tiers tension in favor of droppability (persona checklist #1).
- 0008 reconciled by updating its taxonomy note in place (original preserved) → coordinate-don't-rewrite instruction.

## SPS policy claims to verify (claim → source → owner)

1. **Copilot/Cursor sunset vs. live docs — the planning input and developer docs disagree** (docs still offer Copilot licenses; TAD FAQ treats Copilot/Cursor/Claude Code as parallel) → `/ai/tools` fetched 2026-07-02 vs. 0009 anchor facts → **Enterprise AI & Analytics**.
2. Data-classification → AI matrix (Internal = SPS-licensed AI only; Confidential = reviewed+logged; Restricted = no AI; no customer-data training) → `/guardrails/data-classification` (std v10.0, 2025-09-25) → **Security**.
3. Connector governance: registry + Track A/B intake, SECGRC triggers, per-use connector approval (no always-allow), Local-MCP method gated by MDM/IT → DSOL 780120502 (2026-06-23) + 769063006 (2026-07-01) → **Enterprise AI & Analytics**.
4. Claude Code managed settings / MCP allowlist **not yet deployed** (local MCP currently unconstrained — treated as a window, not policy) → DSOL 769063006 → **Enterprise AI & Analytics**.
5. Device trust (Jamf/InTune required; unmanaged denied) → DSOL 769813768 (**2026-05-29 — oldest page, most likely stale**) → **AI Enablement / Cyber Eng & Defense**.
6. Claude memory on per-user; retention unlimited **pending Legal/Compliance review** → DSOL 780118458 (2026-07-02) → **Enterprise AI & Analytics / Legal**.
7. "Essentially no prior internal PKM material (one stale 2019 page)" → our 2026-06/07 searches; not exhaustive → deeper Confluence sweep.
8. App-level inference = Claude on AWS Bedrock → ai-agents guardrail confirms Bedrock golden path but not "Claude" explicitly → **ACE Engineering / SECOPS**.

## Open gaps

- 0008 (Basic Memory recon) still to execute — lands as `sources/basic-memory-recon.md` per updated note; borrow-vs-build verdict then updates for-us-builders.
- OKF conformance checklist for the us-builder persona — still open (working-notes).
- Personal-local-MCP governance gray zone + Obsidian approval status — open questions routed in sps-guide.
- Persona-review residual (accepted): sps-guide is near its length ceiling; internal precedent is plumbing-precedent (MCP intake), not second-brain precedent — nobody at SPS has run one yet, which is the point of the repo.
- 12 shipping-tool entries in prior-art-landscape not re-verified since 2026-06-18 (flagged inline).
