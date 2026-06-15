#!/usr/bin/env bash
# codex-preflight: cheap, fail-fast check that Codex is usable BEFORE the
# focus-task cron spends tokens selecting/creating a GitHub Issue.
#
# Why this exists:
#   focus-task historically created the GitHub Issue first (step 7) and only hit
#   the `codex login status` guard later inside codex-resolve.sh (step 10). When
#   the ChatGPT-subscription token had expired (it does so periodically and the
#   non-interactive cron environment can't re-auth), the job left an ORPHAN open
#   Issue with `auto_resolve: failed` and the whole run went `error` — after
#   already burning the cloud tokens for issue selection. Seen on #193, #35, #164.
#
#   Running this at the very top of the playbook turns "create orphan + error"
#   into "skip cleanly + report", saving both tokens and manual cleanup.
#
# Exit codes:
#   0  Codex is logged in via ChatGPT subscription — safe to proceed.
#   5  Codex auth is NOT usable (expired / API-key / missing) — caller should
#      SKIP issue creation and auto-resolve for this run.
#
# Usage (from the focus-task playbook, step 0):
#   if ! bash scripts/codex-preflight.sh; then
#     # skip Issue creation + auto-resolve; report "Codex auth down — skipped"
#   fi

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ ! -f "${SCRIPT_DIR}/lib/require-codex-subscription.sh" ]; then
  echo "ABORT: lib/require-codex-subscription.sh missing — cannot verify Codex auth." >&2
  exit 5
fi

# shellcheck source=lib/require-codex-subscription.sh
source "${SCRIPT_DIR}/lib/require-codex-subscription.sh"

if require_codex_subscription; then
  echo "OK: Codex logged in via ChatGPT subscription — focus-task may auto-resolve."
  exit 0
fi

echo "SKIP: Codex auth unusable — focus-task should skip Issue creation this run." >&2
echo "Fix:  codex logout && codex login   # interactive ChatGPT OAuth" >&2
exit 5
