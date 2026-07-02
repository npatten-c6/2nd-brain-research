# Writing & Style Conventions

Conventions for authoring and editing docs in this project. Consult before
writing or revising any `docs/` or root markdown. **Living doc**; it grows as
preferences surface.

> **Provenance:** seeded by comparing an agent's first draft of
> `docs/impl-research/prior-art-landscape.md` against the human's revisions
> (increment `0006`); extended in `0009` from the human's inline edits to the
> SPS guide (`recommendations/sps-guide.md`). The human edits were a partial,
> directional sample, so the principles below capture the _intent_, not a
> finished rulebook.

## Voice & framing

- **Lead with the concept; name the specific tool/instance as an example.** Make
  the general category the subject and cite the concrete thing as an example,
  not the other way around.
  - Prefer: `**_Format spec_.** e.g. **OKF**: "knowledge as markdown + frontmatter…"`
  - Avoid: `**OKF = a file _format spec_.**`
  - Why: keeps the taxonomy primary and instances secondary (essential for
    Tier-2 analysis docs; see the tier convention in
    [`working-notes.md`](docs/impl-research/working-notes.md)).
- **Plain, descriptive headings over clever/rhetorical ones.**
  - Prefer: `Formats, workflows, and full implementations`
  - Avoid: `The space has three *kinds* of thing, not three competitors`
- **Cut rhetorical flourish and jargon.** Say it directly. Drop set-piece
  phrases ("apples-to-apples is a category error", "the uncomfortable finding")
  in favor of a plain statement of the fact.
- **Skip the "not X, it's Y" setup.** The contrastive build ("the real question
  isn't A, it's B"; "it's not a bug, it's a feature") manufactures emphasis and
  reads as marketing. State the point directly. Prefer "for SPS use, keep storage
  local or on an approved service" over "the firm line isn't files-vs-DB, it's
  local vs cloud".
- **Avoid insider shorthand.** Terms like "the shipping market leans X" assume
  the reader tracks the field; write for a colleague who doesn't.
- **Write for the reader's task, not about the document.** Cut meta-narration
  about what the doc is or isn't doing ("this doc deliberately does not
  re-explain X", "this is the big one", "the key thing here"). It reads as filler
  or self-promotion; state the thing and let the reader judge its weight.
- **Calibrate certainty to what we actually know, and to how varied the audience
  is.** For a broad reader base (different people, roles, departments), present
  options with honest pros and cons and reserve firm prescriptions for where a
  real constraint makes the call (e.g. SPS policy). Avoid over-strong steers
  stated as universal ("the thing to not copy", "start page-level, full stop");
  say what the trade-off is and where it is genuinely firm. Hedge claims about
  "what works at SPS": mostly we don't know yet.
- **Give the concrete reason, not a verdict, and make sure it's the real one.**
  "Not recommended because it relies on third-party cloud databases (Supabase)"
  beats "not the shape to copy". Getting the reason right matters: the objection
  to Open Brain is third-party cloud hosting, not database-as-truth (a _local_
  SQLite/DuckDB can be fine).
- **Don't overstate absolutes.** "little or nothing", not "nothing"; "compiled
  for you", not "compiled once". Precision earns trust with a skeptical reader.
- **Don't pad with the null option.** Don't present as advice something the
  reader already has and that is known to be insufficient (e.g. "just use
  Projects + auto-memory"); name it as the baseline and say why the real work
  exists.
- **Lead with the value; demote caveats to a one-line aside.** Explain why a
  thing is useful first, then put the safety or policy caveat in a parenthetical
  or a short follow-on, not the headline.
- **Write SPS / policy claims as provisional.** Cite the source, date it, route
  to the owning team, and point to the canonical page rather than restating
  policy; never assert policy or approval status as definitive. (Matches the org
  guardrails and firm invariant 4 in increment `0009`.)
- **Direct, matter-of-fact voice is welcome.** First-person-plural describing the
  research ("In research we've found…") is fine in Tier-2 analysis docs as long
  as it stays _descriptive_ (observation, not advocacy). Opinion belongs in
  Tier-3 recommendation docs.

## Structure

- **Don't encode metadata in titles.** Keep the H1 clean; layer tags, status, and
  scope live in the subtitle/blockquote, frontmatter, or the index, not the
  headline. (`Prior-Art Landscape`, not `Prior-Art Landscape (Reference, Layer 1)`.)
- **Keep the 3-tier ladder honest** (`sources/` = evidence, `analysis/` =
  decision-neutral analysis, `recommendations/` = opinion). Facts and
  decision-neutral analysis go in Tier 2; opinion, verdicts, and recommendations
  go in Tier 3; verbatim external artifacts and commit-pinned proxy assessments
  go in Tier 1. (Defined in [`working-notes.md`](docs/impl-research/working-notes.md).)
- **Preserve intermediary artifacts.** When a doc is superseded/merged, keep the
  original (banner it as frozen) for provenance/lineage rather than deleting it.
- **`docs/impl-research/` is an OKF bundle; give every concept doc `type`
  frontmatter.** A new `.md` there needs a YAML frontmatter block with a non-empty
  `type` (OKF's one hard rule). Use the tier-aligned vocabulary
  (`primary source - <medium>`, `proxy source - <kind>`, `analysis - <kind>`,
  `recommendation - <persona>`, `working-notes`) or add a descriptive value; see
  [`working-notes.md`](docs/impl-research/working-notes.md) → Doc conventions. Add
  `title` + `description` too. Run `scripts/check-okf.sh` to verify.

## Markdown formatting

Observed conventions (no repo formatter config yet; these match a Prettier-on-save
editor setup, so keep them consistent if you hand-write):

- **No em dashes (`—`).** Use a semicolon, colon, comma, parentheses, or a new
  sentence instead. Standing preference for this repo's prose. (Existing docs
  still contain em dashes from earlier increments; sweep them opportunistically
  when you touch a file.)
- **Prefer standard markdown links `[text](path.md)` over Obsidian
  `[[wikilinks]]`.** Standard links are OKF's convention and the most reliably
  followed by agents and tools; Obsidian renders them fine too.
- _Italic_ uses `_underscores_`; **bold** uses `**asterisks**`.
- Tables are column-aligned (padded) for readable source diffs.
- Blank line before a list.
- One sentence/idea per line is fine; let it wrap.
