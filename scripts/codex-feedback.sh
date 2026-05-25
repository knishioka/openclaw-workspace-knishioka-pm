#!/usr/bin/env bash
# codex-feedback: One-shot wrapper that invokes `codex exec /resolve-feedback`
# for a single PR after gemini-code-assist has had time to post its review.
#
# Why: focus-task creates a draft PR, then schedules an `openclaw cron` one-shot
# at +5min that triggers a new isolated agent session. That session calls this
# script to (a) verify gemini-code-assist actually posted something, (b) run
# /resolve-feedback against the PR branch, and (c) append an audit record to
# monitoring/pr-feedback-tracker.jsonl. Tracker commit + push is handled by the
# cron one-shot agent prompt, not here.
#
# Usage:
#   scripts/codex-feedback.sh <owner/repo> <pr_number> [--dry-run]
#
# Exit codes:
#   0   succeeded (codex exec ok, or no-op because no gemini feedback)
#   2   bad arguments
#   3   local repo path missing
#   5   codex subscription auth guard refused to spawn
#   124 codex exec timed out
#   *   codex exec exit code passthrough
#
# Side effects:
#   - cd to local repo and `gh pr checkout` the PR branch
#   - append a JSONL record to monitoring/pr-feedback-tracker.jsonl
#   - on failure, best-effort WhatsApp alert via openclaw message send
#
# Dependencies: bash, gh, codex, jq (preferred) or grep fallback, gtimeout

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TRACKER="${WORKSPACE_ROOT}/monitoring/pr-feedback-tracker.jsonl"

if [ -f "${SCRIPT_DIR}/lib/require-codex-subscription.sh" ]; then
  # shellcheck source=lib/require-codex-subscription.sh
  source "${SCRIPT_DIR}/lib/require-codex-subscription.sh"
  require_codex_subscription || exit 5
fi

LOCAL_REPO_BASE="${LOCAL_REPO_BASE:-${HOME}/Developer/private}"
CODEX_TIMEOUT="${CODEX_FEEDBACK_TIMEOUT:-600}"

usage() {
  awk 'NR==1{next} /^[^#]/{exit} {sub(/^# ?/,""); print}' "${BASH_SOURCE[0]}"
}

# --- Parse args ---
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
  echo "Error: expected 2 positional args (<owner/repo> <pr_number>), got ${#POS[@]}" >&2
  usage >&2
  exit 2
fi

OWNER_REPO="${POS[0]}"
PR_NUMBER="${POS[1]}"

if ! [[ "$OWNER_REPO" =~ ^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$ ]]; then
  echo "Error: <owner/repo> must look like 'owner/name', got: $OWNER_REPO" >&2
  exit 2
fi

if ! [[ "$PR_NUMBER" =~ ^[0-9]+$ ]]; then
  echo "Error: <pr_number> must be a positive integer, got: $PR_NUMBER" >&2
  exit 2
fi

REPO_NAME="${OWNER_REPO##*/}"
REPO_PATH="${LOCAL_REPO_BASE}/${REPO_NAME}"

NOW_ISO() { date -u +%Y-%m-%dT%H:%M:%SZ; }

append_tracker() {
  # Args: action [extra_json_fields...]
  # Always emits {pr, repo, ran_at, action, ...}
  local action="$1"; shift
  local extra="$*"
  mkdir -p "$(dirname "$TRACKER")"
  if [ -n "$extra" ]; then
    printf '{"pr":%s,"repo":"%s","ran_at":"%s","action":"%s",%s}\n' \
      "$PR_NUMBER" "$OWNER_REPO" "$(NOW_ISO)" "$action" "$extra" >> "$TRACKER"
  else
    printf '{"pr":%s,"repo":"%s","ran_at":"%s","action":"%s"}\n' \
      "$PR_NUMBER" "$OWNER_REPO" "$(NOW_ISO)" "$action" >> "$TRACKER"
  fi
}

alert_failure() {
  # Best-effort WhatsApp ping; never fails the script.
  local msg="$1"
  if [ -n "${KNISHIOKA_ALERT_TO:-}" ] && command -v openclaw >/dev/null 2>&1; then
    openclaw message send --channel whatsapp --target "${KNISHIOKA_ALERT_TO}" \
      --text "$msg" >/dev/null 2>&1 || true
  fi
}

# --- Verify PR is open ---
PR_STATE="$(gh pr view -R "$OWNER_REPO" "$PR_NUMBER" --json state -q .state 2>/dev/null || echo "")"
if [ "$PR_STATE" != "OPEN" ]; then
  echo "[codex-feedback] PR ${OWNER_REPO}#${PR_NUMBER} not OPEN (state=${PR_STATE:-unknown}); skipping" >&2
  append_tracker "skipped" "\"reason\":\"pr_not_open\",\"pr_state\":\"${PR_STATE:-unknown}\""
  exit 0
fi

# --- Count gemini-code-assist feedback (inline comments + summary reviews) ---
GEMINI_LOGIN_PREFIX="gemini-code-assist"
INLINE=$(gh api "repos/${OWNER_REPO}/pulls/${PR_NUMBER}/comments" \
  --jq "[.[] | select(.user.login | startswith(\"${GEMINI_LOGIN_PREFIX}\"))] | length" 2>/dev/null || echo 0)
REVIEWS=$(gh api "repos/${OWNER_REPO}/pulls/${PR_NUMBER}/reviews" \
  --jq "[.[] | select(.user.login | startswith(\"${GEMINI_LOGIN_PREFIX}\"))] | length" 2>/dev/null || echo 0)
TOTAL=$((INLINE + REVIEWS))

echo "[codex-feedback] start repo=${OWNER_REPO} pr=${PR_NUMBER} gemini_inline=${INLINE} gemini_reviews=${REVIEWS} timeout=${CODEX_TIMEOUT}s" >&2

if [ "$TOTAL" -eq 0 ]; then
  echo "[codex-feedback] no gemini-code-assist feedback found; tracker=nothing_to_do" >&2
  append_tracker "nothing_to_do" "\"comments_found\":0"
  exit 0
fi

if [ "$DRY_RUN" -eq 1 ]; then
  echo "[codex-feedback] DRY RUN: would resolve ${TOTAL} feedback items (${INLINE} inline + ${REVIEWS} reviews)" >&2
  exit 0
fi

# --- Local repo prep ---
if [ ! -d "$REPO_PATH" ]; then
  echo "Error: local checkout not found at $REPO_PATH" >&2
  append_tracker "failed" "\"reason\":\"local_repo_missing\",\"comments_found\":${TOTAL}"
  exit 3
fi

cd "$REPO_PATH"
git fetch origin --quiet
gh pr checkout "$PR_NUMBER" -R "$OWNER_REPO"

# --- Build prompt ---
PROMPT="$(cat <<EOF
/resolve-feedback

【目標】
- PR ${OWNER_REPO}#${PR_NUMBER} の gemini-code-assist (AI レビュアー) によるレビューコメントを解決する。
- 検出された inline コメントを classify (fixed/outdated/valid) し、valid のものは実装で対応する。
- 解決後は PR ブランチに push し、PR は **draft のまま維持** する (Ken の手動 ready 化を待つ)。

【制約】
- workspace 側 (knishioka-pm) のファイルは編集対象外。${OWNER_REPO} のみ変更。
- gemini-code-assist 以外のレビュアー (人間 / 他Bot) のコメントは触らない。
- draft → ready 化は禁止 (\`gh pr ready\` を呼ばない)。
- 自己修正コミットは最大3回。失敗が残ったらコメントに「未対応」と返信して終了。
- リポ標準の build / lint / format / typecheck / test は push 前に必ず実行する。

【出力】
- 適用したコメント数 / outdated / valid_skipped の件数を最後に 1 行サマリで返す。
EOF
)"

# --- Run codex with timeout ---
if ! command -v codex >/dev/null 2>&1; then
  echo "Error: 'codex' CLI not found in PATH" >&2
  append_tracker "failed" "\"reason\":\"codex_cli_missing\",\"comments_found\":${TOTAL}"
  exit 2
fi

TIMEOUT_BIN=""
if command -v gtimeout >/dev/null 2>&1; then
  TIMEOUT_BIN="gtimeout"
elif command -v timeout >/dev/null 2>&1; then
  TIMEOUT_BIN="timeout"
fi

START_EPOCH="$(date +%s)"
set +e
if [ -n "$TIMEOUT_BIN" ]; then
  "$TIMEOUT_BIN" "$CODEX_TIMEOUT" codex exec -C "$REPO_PATH" --full-auto "$PROMPT"
else
  codex exec -C "$REPO_PATH" --full-auto "$PROMPT"
fi
EXIT_CODE=$?
set -e
END_EPOCH="$(date +%s)"
DURATION=$((END_EPOCH - START_EPOCH))

# --- Hygiene: switch back to default branch (best-effort) ---
DEFAULT_BRANCH="$(gh repo view "$OWNER_REPO" --json defaultBranchRef -q '.defaultBranchRef.name' 2>/dev/null || echo "main")"
git checkout "$DEFAULT_BRANCH" >/dev/null 2>&1 || true

# --- Classify outcome ---
if [ "$EXIT_CODE" -eq 0 ]; then
  ACTION="applied"
elif [ "$EXIT_CODE" -eq 124 ]; then
  ACTION="timeout"
else
  ACTION="failed"
fi

append_tracker "$ACTION" \
  "\"comments_found\":${TOTAL},\"inline\":${INLINE},\"reviews\":${REVIEWS},\"duration_sec\":${DURATION},\"exit_code\":${EXIT_CODE}"

echo "[codex-feedback] end repo=${OWNER_REPO} pr=${PR_NUMBER} exit=${EXIT_CODE} duration_sec=${DURATION} action=${ACTION}" >&2

if [ "$ACTION" = "failed" ] || [ "$ACTION" = "timeout" ]; then
  alert_failure "⚠️ codex-feedback ${ACTION}: ${OWNER_REPO}#${PR_NUMBER} (exit=${EXIT_CODE}, ${DURATION}s)"
fi

exit "$EXIT_CODE"
