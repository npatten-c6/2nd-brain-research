#!/usr/bin/env bash
# OKF v0.1 conformance check for docs/impl-research/ (see okf-spec.md §9).
#
# Verifies every non-reserved, non-exempt .md file in the bundle has a parseable
# YAML frontmatter block whose first key region contains a non-empty `type`.
# Reserved (OKF) and deliberately-exempt files are skipped by name.
set -euo pipefail

BUNDLE="$(cd "$(dirname "$0")/../docs/impl-research" && pwd)"

# OKF reserved filenames (§3.1) + our documented exemptions (see working-notes.md).
SKIP=("index.md" "log.md" "lens-WIP.md")

fail=0
for f in "$BUNDLE"/*.md; do
  base="$(basename "$f")"
  for s in "${SKIP[@]}"; do
    [[ "$base" == "$s" ]] && continue 2
  done

  if [[ "$(head -1 "$f")" != "---" ]]; then
    echo "FAIL $base — no opening frontmatter '---'"
    fail=1
    continue
  fi

  # Frontmatter = lines after the opening '---' up to the next '---'.
  fm="$(awk 'NR==1 {next} /^---[[:space:]]*$/ {exit} {print}' "$f")"
  if ! grep -qE '^type:[[:space:]]*[^[:space:]]' <<<"$fm"; then
    echo "FAIL $base — missing or empty 'type'"
    fail=1
    continue
  fi

  echo "ok   $base"
done

if [[ $fail -eq 0 ]]; then
  echo "OKF conformance: PASS"
else
  echo "OKF conformance: FAIL"
  exit 1
fi
