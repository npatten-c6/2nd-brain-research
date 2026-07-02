#!/usr/bin/env bash
# OKF v0.1 conformance check for docs/impl-research/ (see okf-spec.md §9).
#
# Verifies every non-reserved, non-exempt .md file in the bundle has a parseable
# YAML frontmatter block whose first key region contains a non-empty `type`.
# Reserved (OKF) and deliberately-exempt files are skipped by name.
set -euo pipefail

BUNDLE="$(cd "$(dirname "$0")/../docs/impl-research" && pwd)"

# OKF reserved filenames (§3.1). No exemptions — every concept doc (including
# those in the tier subfolders sources/ analysis/ recommendations/) needs `type`.
SKIP=("index.md" "log.md")

fail=0
while IFS= read -r f; do
  base="$(basename "$f")"
  skip=0
  for s in "${SKIP[@]}"; do
    [[ "$base" == "$s" ]] && skip=1
  done
  [[ $skip -eq 1 ]] && continue
  rel="${f#"$BUNDLE"/}"

  if [[ "$(head -1 "$f")" != "---" ]]; then
    echo "FAIL $rel — no opening frontmatter '---'"
    fail=1
    continue
  fi

  # Frontmatter = lines after the opening '---' up to the next '---'.
  fm="$(awk 'NR==1 {next} /^---[[:space:]]*$/ {exit} {print}' "$f")"
  if ! grep -qE '^type:[[:space:]]*[^[:space:]]' <<<"$fm"; then
    echo "FAIL $rel — missing or empty 'type'"
    fail=1
    continue
  fi

  echo "ok   $rel"
done < <(find "$BUNDLE" -name '*.md' | sort)

if [[ $fail -eq 0 ]]; then
  echo "OKF conformance: PASS"
else
  echo "OKF conformance: FAIL"
  exit 1
fi
