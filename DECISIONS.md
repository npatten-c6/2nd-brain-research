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

## sps-guide rewrite (post-review feedback)

The first draft restated SPS's own context back to the reader (Claude Enterprise setup, the
data-classification matrix, MCP governance) — all covered elsewhere, so it landed flat. Rewritten
to lead with what the reader *doesn't* have: (1) the mental model — what a second brain is + the 4
forks (files-vs-DB truth, AI-maintains-vs-store&search, regenerate-vs-edit-in-place, page-vs-atom);
(2) options ranked simplest→capable with the crisp #1-vs-#2 distinction (does the AI maintain your
files or just read copies); (3) a concrete getting-started recipe (vault + `index.md`/`log.md`,
agent `CLAUDE.md`/Skill instructions, the loop, grow-when-it-hurts). Governance demoted to short
pointers. Removed: Copilot (distraction), the data-classification matrix (→ 1-line + AI-at-SPS
SharePoint link), Claude Enterprise setup restating, MCP how-to restating. Local-only MCP over own
files reframed as plainly fine (was hedged as a gray zone).

## SPS policy claims to verify (claim → source → owner)

1. Org direction consolidating on Claude Enterprise; app-level inference = Claude on AWS Bedrock → planning input + ai-agents guardrail (Bedrock golden path, "Claude" not explicit) → **Enterprise AI & Analytics / ACE Engineering**.
2. Data-classification rules for a personal AI-maintained vault (what "reviewed use" means for Confidential) → [AI at SPS](https://spscommerce.sharepoint.com/sites/aiatsps/SitePages/AI%20at%20SPS.aspx) + `/guardrails/data-classification` (std v10.0, 2025-09-25) → **Security GRC**.
3. "Essentially no prior internal PKM material (one stale 2019 page)" → our 2026-06/07 searches; not exhaustive → deeper Confluence sweep.

_(Dropped from the earlier list as no longer load-bearing in the reoriented guide: the connector/registry governance detail, MCP-allowlist-not-yet-deployed, device-trust page, retention-review — all real, but they belong to the AI-at-SPS/governance owners and aren't what this guide is for. Copilot/Cursor sunset question removed entirely per feedback.)_

## Open gaps

- 0008 (Basic Memory recon) still to execute — lands as `sources/basic-memory-recon.md` per updated note; borrow-vs-build verdict then updates for-us-builders.
- OKF conformance checklist for the us-builder persona — still open (working-notes).
- Personal-local-MCP governance gray zone + Obsidian approval status — open questions routed in sps-guide.
- Persona-review residual (accepted): sps-guide is near its length ceiling; internal precedent is plumbing-precedent (MCP intake), not second-brain precedent — nobody at SPS has run one yet, which is the point of the repo.
- 12 shipping-tool entries in prior-art-landscape not re-verified since 2026-06-18 (flagged inline).
