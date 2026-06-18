# Writing & Style Conventions

Conventions for authoring and editing docs in this project. Consult before
writing or revising any `docs/` or root markdown. **Living doc** — it grows as
preferences surface.

> **Provenance:** seeded by comparing an agent's first draft of
> `docs/impl-research/prior-art-landscape.md` against the human's revisions
> (increment `0006`). The human edits were a partial, directional sample — the
> principles below capture the _intent_, not a finished rulebook.

## Voice & framing

- **Lead with the concept; name the specific tool/instance as an example.** Make
  the general category the subject and cite the concrete thing as an example —
  not the other way around.
  - Prefer: `**_Format spec_.** e.g. **OKF** — "knowledge as markdown + frontmatter…"`
  - Avoid: `**OKF = a file _format spec_.**`
  - Why: keeps the taxonomy primary and instances secondary (essential for
    `reference`/Layer-1 docs; see the layering convention in
    [`working-notes.md`](docs/impl-research/working-notes.md)).
- **Plain, descriptive headings over clever/rhetorical ones.**
  - Prefer: `Formats, workflows, and full implementations`
  - Avoid: `The space has three *kinds* of thing — not three competitors`
- **Cut rhetorical flourish and jargon.** Say it directly. Drop set-piece
  phrases ("apples-to-apples is a category error", "the uncomfortable finding")
  in favor of a plain statement of the fact.
- **Direct, matter-of-fact voice is welcome.** First-person-plural describing the
  research ("In research we've found…") is fine in `reference` docs as long as it
  stays _descriptive_ — observation, not advocacy/recommendation. (Opinion belongs
  in `lens` docs.)

## Structure

- **Don't encode metadata in titles.** Keep the H1 clean; layer tags, status, and
  scope live in the subtitle/blockquote, frontmatter, or the index — not the
  headline. (`Prior-Art Landscape`, not `Prior-Art Landscape — Reference (Layer 1)`.)
- **Keep the `reference` / `lens` / `source` separation honest.** Facts and
  decision-neutral analysis in `reference`; opinion, verdicts, and recommendations
  in `lens`; verbatim external artifacts in `source`. (Defined in
  [`working-notes.md`](docs/impl-research/working-notes.md).)
- **Preserve intermediary artifacts.** When a doc is superseded/merged, keep the
  original (banner it as frozen) for provenance/lineage rather than deleting it.
- **`docs/impl-research/` is an OKF bundle — give every concept doc `type`
  frontmatter.** A new `.md` there needs a YAML frontmatter block with a non-empty
  `type` (OKF's one hard rule). Use the established vocabulary (`primary source -
  <medium>`, `AI-synthesis`, `working-notes`) or add a descriptive value; see
  [`working-notes.md`](docs/impl-research/working-notes.md) → Doc conventions. Add
  `title` + `description` too. Run `scripts/check-okf.sh` to verify.

## Markdown formatting

Observed conventions (no repo formatter config yet; these match a Prettier-on-save
editor setup — keep them consistent if you hand-write):

- _Italic_ uses `_underscores_`; **bold** uses `**asterisks**`.
- Tables are column-aligned (padded) for readable source diffs.
- Blank line before a list.
- One sentence/idea per line is fine; let it wrap.
