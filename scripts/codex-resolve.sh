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
#
# Exported env vars (consumed by the focus-task cron prompt to enrich
# monitoring/issue-tracker.jsonl):
#   LINT_AVAILABLE       "true" | "false"
#   LINT_SKIPPED_REASON  "no_lint_configured" | "command_not_found" | ""
#                        (empty when LINT_AVAILABLE=true)
#   PLAYBOOK_VERSION     YYYY-MM-DD from docs/codex-playbook.md (or "unknown")

set -euo pipefail

# --- Locate workspace root (parent of this script's dir) ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
REPOS_YAML="${WORKSPACE_ROOT}/config/repos.yaml"
PLAYBOOK="${WORKSPACE_ROOT}/docs/codex-playbook.md"

# Local checkout convention (matches docs/codex-playbook.md "ローカルリポパス")
LOCAL_REPO_BASE="${LOCAL_REPO_BASE:-${HOME}/Developer/private}"

# Codex timeout (seconds). Matches playbook's "codex exec のタイムアウト: 15分".
CODEX_TIMEOUT="${CODEX_TIMEOUT:-900}"

usage() {
  # Print the leading header comment block (after the shebang) up to the first
  # non-comment line. Auto-extends as the header grows; no hardcoded line range.
  awk 'NR==1{next} /^[^#]/{exit} {sub(/^# ?/,""); print}' "${BASH_SOURCE[0]}"
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
# Escape dots in REPO_NAME so a name like "foo.bar" matches only "foo.bar"
# in the ERE, not "fooXbar". Other allowed chars in the validation regex
# (alnum / underscore / hyphen) are not ERE metacharacters in this position.
REPO_NAME_RE="${REPO_NAME//./\\.}"
if ! grep -E "^[[:space:]]*-?[[:space:]]*name:[[:space:]]*${REPO_NAME_RE}[[:space:]]*$" \
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

# --- Detect lint availability for the target repo ---
# Heuristic only — used to inject an explicit "lint not installed → skip, do
# not install" directive into the Codex prompt and to surface the result via
# LINT_AVAILABLE / LINT_SKIPPED_REASON for downstream tracking
# (issue-tracker.jsonl). Reasons map to the set documented in
# docs/codex-playbook.md: "no_lint_configured" or "command_not_found".
detect_lint_available() {
  local repo_path="$1"

  if [ ! -d "$repo_path" ]; then
    LINT_AVAILABLE="false"
    LINT_SKIPPED_REASON="no_lint_configured"
    return
  fi

  # Node: package.json with a scripts.lint key (no jq dependency).
  if [ -f "${repo_path}/package.json" ]; then
    if grep -qE '"lint"[[:space:]]*:' "${repo_path}/package.json"; then
      LINT_AVAILABLE="true"
      LINT_SKIPPED_REASON=""
      return
    fi
    LINT_AVAILABLE="false"
    LINT_SKIPPED_REASON="no_lint_configured"
    return
  fi

  # Python: try uv first, then poetry. ruff is the conventional linter per
  # docs/codex-playbook.md "検証コマンドの自動検出". Heuristic check via
  # pyproject.toml so this stays side-effect free (no dep sync, no install).
  if [ -f "${repo_path}/pyproject.toml" ]; then
    if grep -qE '(^|[^a-zA-Z_])ruff([^a-zA-Z_]|$)' "${repo_path}/pyproject.toml"; then
      if command -v uv >/dev/null 2>&1 || command -v poetry >/dev/null 2>&1; then
        LINT_AVAILABLE="true"
        LINT_SKIPPED_REASON=""
        return
      fi
      LINT_AVAILABLE="false"
      LINT_SKIPPED_REASON="command_not_found"
      return
    fi
    LINT_AVAILABLE="false"
    LINT_SKIPPED_REASON="no_lint_configured"
    return
  fi

  # No supported manifest detected (Rust / Go / shell / docs-only repos, etc.).
  LINT_AVAILABLE="false"
  LINT_SKIPPED_REASON="no_lint_configured"
}

LINT_AVAILABLE="false"
LINT_SKIPPED_REASON=""
detect_lint_available "$REPO_PATH"
export LINT_AVAILABLE LINT_SKIPPED_REASON

# --- Extract playbook_version from `<!-- version: YYYY-MM-DD -->` marker ---
# The marker is the first line of docs/codex-playbook.md by convention.
# If absent or malformed, log a warning and use "unknown" so downstream tracking
# is never blocked. We do NOT fail the run on a missing version.
# Portable across macOS BSD grep / GNU grep — no gawk match() arrays.
PLAYBOOK_VERSION_LINE="$(head -n 1 "$PLAYBOOK")"
PLAYBOOK_VERSION="$(printf '%s\n' "$PLAYBOOK_VERSION_LINE" \
  | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}' \
  | head -n 1 || true)"
if [ -z "$PLAYBOOK_VERSION" ] \
   || ! printf '%s\n' "$PLAYBOOK_VERSION_LINE" | grep -qE '<!--[[:space:]]*version:[[:space:]]*[0-9]{4}-[0-9]{2}-[0-9]{2}[[:space:]]*-->'; then
  echo "Warning: no '<!-- version: YYYY-MM-DD -->' marker on line 1 of $PLAYBOOK" >&2
  PLAYBOOK_VERSION="unknown"
fi
export PLAYBOOK_VERSION

# --- Build conditional lint-absent directive ---
# When detection says lint is unavailable, prepend an explicit block to the
# /resolve-issue task so Codex cannot interpret the generic "lint コマンドが
# 解決できない場合 ... install しない" rule as advisory. Empty string when
# lint is available.
if [ "$LINT_AVAILABLE" = "false" ]; then
  LINT_DIRECTIVE="$(cat <<EOF

【Lint 未導入の明示指示 (override)】
- このリポは lint コマンドが解決できなかった (LINT_SKIPPED_REASON=${LINT_SKIPPED_REASON})。
- lint は **実行せず**、ESLint / Ruff / golangci-lint 等を **新規 install しない**。
- 動作確認テーブルの Lint 行は \`⚠️ n/a (Linter未導入)\` を記録する (\`✅\` で塗らない / 行を消さない)。
- PR 本文に「Linterが未導入のため lint をスキップ」を 1 行残す。
- issue-tracker.jsonl 記録時は lint_available=false / lint_skipped_reason="${LINT_SKIPPED_REASON}" / verification.lint="n/a" にする。
- 詳細は "Lint 不在リポの扱い" 節を参照。
EOF
)"
else
  LINT_DIRECTIVE=""
fi

# --- Build final prompt ---
# The playbook is injected as workspace policy context, then a Goals+Constraints
# style instruction (per "Codex Prompting Guidelines") points Codex at the
# repo's own /resolve-issue skill while binding it to the workspace policy.
PROMPT="$(cat <<EOF
# Workspace Policy Context (knishioka-pm AGENTS.md)

Below is the workspace-level Codex playbook. It is the source of truth for
verification expectations, PR description format (Japanese, structured), and
prompting style. Follow it strictly.

Playbook version: ${PLAYBOOK_VERSION}

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
- lint コマンドが解決できない場合 (npm run lint が Missing script / バイナリ不在) は **install しない**。
  動作確認テーブルに ⚠️ n/a で記録し、PR 本文に「Linterが未導入のため lint をスキップ」を 1 行残す。
  詳細は "Lint 不在リポの扱い" 節を参照。

【検証】
- リポ標準のチェック (build / lint / format / typecheck / test) を順に実行。失敗 0 が "good" の定義。
- 該当しないコマンドはスキップ (埋め草で書かない)。

【出力】
- draft PR を 1 本作成する。本文は workspace AGENTS.md "PR Description Standards" のテンプレに従い、日本語で記述する。
- issue-tracker.jsonl への記録時に以下を含める (cron 側が capture):
  - playbook_version: "${PLAYBOOK_VERSION}"
  - lint_available: ${LINT_AVAILABLE}
  - lint_skipped_reason: $(if [ "$LINT_AVAILABLE" = "false" ]; then printf '"%s"' "$LINT_SKIPPED_REASON"; else printf 'null'; fi)
${LINT_DIRECTIVE}
EOF
)"

# --- Dry-run: print prompt and exit ---
if [ "$DRY_RUN" -eq 1 ]; then
  # Emit playbook_version / lint_* on stderr so cron / wrappers can capture
  # them the same way they will in real runs (see start-log on the real-run
  # path below).
  echo "[codex-resolve] dry-run repo=${OWNER_REPO} issue=${ISSUE_NUMBER} playbook_version=${PLAYBOOK_VERSION}" >&2
  echo "[codex-resolve] LINT_AVAILABLE=${LINT_AVAILABLE}" >&2
  echo "[codex-resolve] LINT_SKIPPED_REASON=${LINT_SKIPPED_REASON}" >&2
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
echo "[codex-resolve] start repo=${OWNER_REPO} issue=${ISSUE_NUMBER} playbook_version=${PLAYBOOK_VERSION} lint_available=${LINT_AVAILABLE} lint_skipped_reason=${LINT_SKIPPED_REASON:-none} timeout=${CODEX_TIMEOUT}s" >&2

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
