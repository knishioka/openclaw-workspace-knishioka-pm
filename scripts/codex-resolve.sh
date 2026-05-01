#!/usr/bin/env bash
# codex-resolve: Wrapper that injects workspace Codex playbook into the prompt
# before invoking `codex exec` for a given Issue.
#
# Why: the focus-task cron previously called `codex exec` directly with just
# `/resolve-issue #N`. Codex only reads the target repo's CLAUDE.md / AGENTS.md,
# so the workspace AGENTS.md (PR Description Standards / Codex Prompting
# Guidelines) never reached Codex. This wrapper prepends docs/codex-playbook.md
# to the prompt, giving Codex the workspace policy without per-repo duplication.
#
# Usage:
#   scripts/codex-resolve.sh <owner/repo> <issue_number> [--dry-run]
#   scripts/codex-resolve.sh --dry-run <owner/repo> <issue_number>
#
# Example:
#   scripts/codex-resolve.sh --dry-run knishioka/kanji-practice 48
#   scripts/codex-resolve.sh knishioka/math-worksheet 51
#
# Exit codes:
#   0   codex exec succeeded (or dry-run completed)
#   2   bad arguments / repo not found in config/repos.yaml
#   3   local repo path missing
#   4   docs/codex-playbook.md missing
#   124 codex exec timed out (15min)
#   *   codex exec exit code passthrough
#
# Dependencies: bash, gh, codex, gtimeout (GNU coreutils). jq is not required
# here (kept for future structured-summary output). yq is not required because
# the path convention is uniform; repos.yaml is validated with grep.

set -euo pipefail

# --- Locate workspace root (parent of this script's dir) ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
REPOS_YAML="${WORKSPACE_ROOT}/config/repos.yaml"
PLAYBOOK="${WORKSPACE_ROOT}/docs/codex-playbook.md"

# Local checkout convention (matches docs/codex-playbook.md "ローカルリポパス")
LOCAL_REPO_BASE="${LOCAL_REPO_BASE:-/Users/ken/Developer/private}"

# Codex timeout (seconds). Matches playbook's "codex exec のタイムアウト: 15分".
CODEX_TIMEOUT="${CODEX_TIMEOUT:-900}"

usage() {
  sed -n '2,20p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
}

# --- Parse args (positional + --dry-run anywhere) ---
DRY_RUN=0
POS=()
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    -h|--help) usage; exit 0 ;;
    --*) echo "Error: unknown flag: $arg" >&2; usage >&2; exit 2 ;;
    *) POS+=("$arg") ;;
  esac
done

if [ "${#POS[@]}" -ne 2 ]; then
  echo "Error: expected 2 positional args (<owner/repo> <issue_number>), got ${#POS[@]}" >&2
  usage >&2
  exit 2
fi

OWNER_REPO="${POS[0]}"
ISSUE_NUMBER="${POS[1]}"

if ! [[ "$OWNER_REPO" =~ ^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$ ]]; then
  echo "Error: <owner/repo> must look like 'owner/name', got: $OWNER_REPO" >&2
  exit 2
fi

if ! [[ "$ISSUE_NUMBER" =~ ^[0-9]+$ ]]; then
  echo "Error: <issue_number> must be a positive integer, got: $ISSUE_NUMBER" >&2
  exit 2
fi

REPO_NAME="${OWNER_REPO##*/}"

# --- Validate the repo is configured (public or private list) ---
if [ ! -f "$REPOS_YAML" ]; then
  echo "Error: $REPOS_YAML not found" >&2
  exit 2
fi

# repos.yaml entries look like:   - name: foo
# This grep matches a YAML mapping key "name" with our exact REPO_NAME value
# under either `repos:` or `private_repos:` (both share the same path prefix
# per docs/codex-playbook.md).
if ! grep -E "^[[:space:]]*-?[[:space:]]*name:[[:space:]]*${REPO_NAME}[[:space:]]*$" \
     "$REPOS_YAML" >/dev/null; then
  echo "Error: '$REPO_NAME' not found in $REPOS_YAML (repos: or private_repos:)" >&2
  exit 2
fi

# --- Resolve local repo path ---
REPO_PATH="${LOCAL_REPO_BASE}/${REPO_NAME}"

if [ ! -d "$REPO_PATH" ]; then
  if [ "$DRY_RUN" -eq 1 ]; then
    echo "Warning: $REPO_PATH does not exist (dry-run continues)" >&2
  else
    echo "Error: local checkout not found at $REPO_PATH" >&2
    exit 3
  fi
fi

# --- Read playbook ---
if [ ! -f "$PLAYBOOK" ]; then
  echo "Error: $PLAYBOOK not found" >&2
  exit 4
fi

PLAYBOOK_CONTENT="$(cat "$PLAYBOOK")"

# --- Build final prompt ---
# The playbook is injected as workspace policy context, then a Goals+Constraints
# style instruction (per "Codex Prompting Guidelines") points Codex at the
# repo's own /resolve-issue skill while binding it to the workspace policy.
PROMPT="$(cat <<EOF
# Workspace Policy Context (knishioka-pm AGENTS.md)

Below is the workspace-level Codex playbook. It is the source of truth for
verification expectations, PR description format (Japanese, structured), and
prompting style. Follow it strictly.

---

${PLAYBOOK_CONTENT}

---

# Task

/resolve-issue #${ISSUE_NUMBER}

【目標】
- Issue #${ISSUE_NUMBER} (${OWNER_REPO}) を解決し、検証 + 日本語PR本文整形まで完走させた上で draft PR を作成する。

【制約】
- 上記 "Auto-Resolve via Codex" / "PR Description Standards" / "Codex Prompting Guidelines" に従うこと。
- workspace 側 (knishioka-pm) のファイルは編集対象ではない。対象リポ ${OWNER_REPO} のみ変更する。
- 自己修正コミットは最大3回まで。それでも失敗が残ったら隠さず ❌ で PR 本文に明示する。

【検証】
- リポ標準のチェック (build / lint / format / typecheck / test) を順に実行。失敗 0 が "good" の定義。
- 該当しないコマンドはスキップ (埋め草で書かない)。

【出力】
- draft PR を 1 本作成する。本文は workspace AGENTS.md "PR Description Standards" のテンプレに従い、日本語で記述する。
EOF
)"

# --- Dry-run: print prompt and exit ---
if [ "$DRY_RUN" -eq 1 ]; then
  printf '%s\n' "$PROMPT"
  exit 0
fi

# --- Real run: invoke codex exec with timeout ---
if ! command -v codex >/dev/null 2>&1; then
  echo "Error: 'codex' CLI not found in PATH" >&2
  exit 2
fi

# Prefer GNU timeout; fall back to coreutils-prefixed name on macOS without alias.
if command -v gtimeout >/dev/null 2>&1; then
  TIMEOUT_BIN="gtimeout"
elif command -v timeout >/dev/null 2>&1; then
  TIMEOUT_BIN="timeout"
else
  echo "Warning: no 'timeout' / 'gtimeout' found; running codex without external timeout" >&2
  TIMEOUT_BIN=""
fi

# Log only the repo *name* and issue number — never the prompt body, since the
# repo (and via it, the playbook) may be private. Codex itself logs to its own
# session files; that is its own boundary, not ours.
echo "[codex-resolve] start repo=${OWNER_REPO} issue=${ISSUE_NUMBER} timeout=${CODEX_TIMEOUT}s" >&2

START_EPOCH="$(date +%s)"
set +e
if [ -n "$TIMEOUT_BIN" ]; then
  "$TIMEOUT_BIN" "$CODEX_TIMEOUT" \
    codex exec -C "$REPO_PATH" --full-auto "$PROMPT"
else
  codex exec -C "$REPO_PATH" --full-auto "$PROMPT"
fi
EXIT_CODE=$?
set -e
END_EPOCH="$(date +%s)"
DURATION=$((END_EPOCH - START_EPOCH))

echo "[codex-resolve] end repo=${OWNER_REPO} issue=${ISSUE_NUMBER} exit=${EXIT_CODE} duration_sec=${DURATION}" >&2

exit "$EXIT_CODE"
