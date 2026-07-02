---
type: "process note"
title: "How to refresh a proxy source"
description: "Repeatable procedure for re-assessing a commit-pinned proxy source at a new upstream ref and re-checking the analysis built on it. Worked example: the OB1 refresh (2a15199 → 671b923, 2026-07-02)."
---

# How to refresh a proxy source

A **proxy source** (see [`working-notes.md`](working-notes.md) → Doc conventions) is our
commit-pinned assessment standing in for a repo or artifact we didn't vendor. It goes stale the
moment upstream moves. This is the procedure for refreshing one — and, because every claim in this
bundle is traceable, for finding exactly which downstream analysis to re-check instead of guessing.

## The procedure

1. **Pull upstream** and note the new ref: `git -C <clone> pull && git -C <clone> rev-parse HEAD`.
2. **Diff against the pinned ref** (the proxy's frontmatter `source_ref`):
   `git -C <clone> diff --stat <old_ref>..<new_ref>` + `git log --oneline <old_ref>..<new_ref>`.
   Pay attention to whether the files the proxy actually cites changed — an empty diff on those
   paths means the assessed facts likely hold verbatim.
3. **Re-verify the proxy's load-bearing claims at the new ref** (spot-check its `path:line`
   citations; re-read subsystems whose files changed). Keep the discipline: stated intent
   (README/docs) separate from observed implementation (code); neutral tone.
4. **Update the proxy doc:** bump `source_ref` and `assessed_date`, append to
   `assessment_history`, and add/extend a dated **refresh addendum** section — what changed,
   what's new, and which previously-written claims the new state stales or sharpens.
5. **Check the blast radius:** find every Tier-2/Tier-3 doc that cites the proxy
   (`grep -rl '<proxy-filename>' docs/impl-research/`) and re-read each dependent claim against
   the addendum. Add a dated freshness note where a claim is stale, sharpened, or merely
   re-confirmed — "re-verified, no change" is itself worth recording.
6. **Run the checks:** `scripts/check-okf.sh` + a link pass; commit the refresh as one unit so
   the ref bump and the downstream flags land together.

## Worked example — OB1 refresh, 2026-07-02

- Old pin `2a15199` (assessed 2026-06-18) → new HEAD `671b923`, 88 commits.
- Step 2 found `git diff --stat 2a15199..671b923 -- integrations/smart-ingest/ integrations/_shared/`
  **empty** — the assessed pipeline was untouched; the 88 commits were additive subsystems.
- Steps 3–4 produced the [refresh addendum in the OB1 recon](sources/ob1-ingestion-recon.md#refresh-addendum--what-changed-2a15199--671b923):
  spot-verified constants/thresholds at HEAD, catalogued the new subsystems, and listed the claims
  the new state stales ("chat-capture-centric", "one MCP server").
- Step 5's blast radius was three analysis docs — [`prior-art-landscape.md`](analysis/prior-art-landscape.md),
  [`ob1-synthesis.md`](analysis/ob1-synthesis.md), [`nate-post-claims-audit.md`](analysis/nate-post-claims-audit.md) —
  each now carries a dated freshness note (no verdicts flipped; two chunks understated).

## Notes

- If upstream isn't cloned locally, clone it fresh and verify the old `source_ref` exists in its
  history before diffing.
- For non-repo proxies (e.g. the [SPS AI Builder persona](sources/sps-ai-builder-persona.md),
  synthesized from a Slack channel), the analog of "diff" is re-reading the source window forward
  from `source_window`/`assessed_date` and re-deriving; the blast-radius step is identical.
- A refresh that finds "no change" is cheap and still valuable — it moves `assessed_date` forward,
  which is what a reader checking freshness actually looks at.
