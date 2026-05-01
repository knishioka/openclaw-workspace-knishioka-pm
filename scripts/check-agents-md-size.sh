#!/usr/bin/env bash
# Check AGENTS.md file sizes against workspace policy.
#
# Policy: keep AGENTS.md focused. Tune via env vars.
#   WARN_LINES   default 250  (>= warn)
#   FAIL_LINES   default 500  (>= fail)
#   SOFT_FAIL    default 0    (set 1 → never exit non-zero, just warn)
#
# Targets every tracked file named AGENTS.md (root or nested).
set -euo pipefail

WARN_LINES="${WARN_LINES:-250}"
FAIL_LINES="${FAIL_LINES:-500}"
SOFT_FAIL="${SOFT_FAIL:-0}"

cd "$(git rev-parse --show-toplevel)"

# `mapfile` is Bash 4+, so use a while-read loop for macOS /bin/bash (3.2).
# `:(glob)**/AGENTS.md` matches root + any nested AGENTS.md in one pattern;
# without :(glob) magic, `**/AGENTS.md` does NOT include the root path.
files=()
while IFS= read -r f; do
  files+=("$f")
done < <(git ls-files ':(glob)**/AGENTS.md' 2>/dev/null | sort -u)

if [[ ${#files[@]} -eq 0 ]]; then
  echo "no AGENTS.md files tracked; nothing to check"
  exit 0
fi

fail=0
warn=0
for f in "${files[@]}"; do
  [[ -f "$f" ]] || continue
  lines=$(wc -l < "$f" | tr -d ' ')
  if (( lines >= FAIL_LINES )); then
    echo "FAIL: $f has $lines lines (>= $FAIL_LINES)"
    fail=$((fail + 1))
  elif (( lines >= WARN_LINES )); then
    echo "WARN: $f has $lines lines (>= $WARN_LINES, < $FAIL_LINES)"
    warn=$((warn + 1))
  else
    echo "OK:   $f ($lines lines)"
  fi
done

echo "---"
echo "checked ${#files[@]} file(s): ${fail} fail, ${warn} warn"

if (( fail > 0 )) && [[ "$SOFT_FAIL" != "1" ]]; then
  exit 1
fi
exit 0
