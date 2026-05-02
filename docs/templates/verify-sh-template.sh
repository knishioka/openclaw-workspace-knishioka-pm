#!/usr/bin/env bash
# verify.sh — per-repo verification entrypoint (template).
#
# 役割:
#   build / lint / format / typecheck / test を一括で実行し、
#   人間 / Codex / CI どれが叩いても同じ結果が返るようにする。
#
# 使い方:
#   ./scripts/verify.sh           # 人間可読 (text)
#   ./scripts/verify.sh --json    # 構造化結果 (CI / Codex 用)
#
# 出力契約 (--json):
#   {"build":"pass|fail|n/a","lint":"...","format":"...","typecheck":"...","test":"...","failures":[{"step":"lint","cmd":"...","exit":1}]}
#   - 値は "pass" | "fail" | "n/a" のいずれか。
#   - lint/formatter 等が未導入のリポは "n/a" を返す (Issue #19 と整合)。
#   - failures[] には fail だった step だけを順番通りに格納。
#
# Exit code:
#   0  全 step pass / n/a
#   1  1 つ以上 fail
#   2  環境エラー (依存ツール不在で実行できない等)
#
# 言語別の埋め方 (該当言語のブロックだけ残し、他は削除する):
#   Node (npm/pnpm):
#     BUILD_CMD="npm run build"; LINT_CMD="npm run lint"
#     FORMAT_CMD="npm run format -- --check"; TYPECHECK_CMD="npm run typecheck"
#     TEST_CMD="npm test --silent"
#   Python (uv):
#     BUILD_CMD=""  # ライブラリでなければ n/a
#     LINT_CMD="uv run ruff check ."; FORMAT_CMD="uv run ruff format --check ."
#     TYPECHECK_CMD="uv run mypy ."; TEST_CMD="uv run pytest -q"
#   Python (poetry):
#     LINT_CMD="poetry run ruff check ."; FORMAT_CMD="poetry run ruff format --check ."
#     TYPECHECK_CMD="poetry run mypy ."; TEST_CMD="poetry run pytest -q"
#   Rust:
#     BUILD_CMD="cargo build --locked"; LINT_CMD="cargo clippy --all-targets -- -D warnings"
#     FORMAT_CMD="cargo fmt --check"; TYPECHECK_CMD=""  # cargo build に内包
#     TEST_CMD="cargo test --locked"
#   Go:
#     BUILD_CMD="go build ./..."; LINT_CMD="golangci-lint run"
#     FORMAT_CMD="test -z \"$(gofmt -l .)\""; TYPECHECK_CMD="go vet ./..."
#     TEST_CMD="go test ./..."
#
# このテンプレは workspace `docs/templates/verify-sh-template.sh` が SSOT。
# リポ独自のロジック (例: docker compose 起動) を足すなら、各 step 関数の中に閉じ込める。

set -euo pipefail

# ------------------------------------------------------------------
# 1. リポ別に書き換える領域 (ここから)
# ------------------------------------------------------------------

BUILD_CMD=""      # 例: "npm run build". 空なら n/a。
LINT_CMD=""       # 例: "npm run lint"
FORMAT_CMD=""     # 例: "npm run format -- --check"
TYPECHECK_CMD=""  # 例: "npm run typecheck"
TEST_CMD=""       # 例: "npm test --silent"

# ------------------------------------------------------------------
# 1. リポ別に書き換える領域 (ここまで)
# ------------------------------------------------------------------

JSON_MODE=0
[[ "${1:-}" == "--json" ]] && JSON_MODE=1

declare -A RESULT
FAILURES_JSON=""
ANY_FAIL=0

log_text() {
  if [[ $JSON_MODE -eq 0 ]]; then
    printf '%s\n' "$1"
  fi
}

run_step() {
  local name="$1" cmd="$2"
  if [[ -z "$cmd" ]]; then
    RESULT[$name]="n/a"
    log_text "$(printf '  %-10s n/a' "$name")"
    return 0
  fi
  log_text "$(printf '  %-10s running: %s' "$name" "$cmd")"
  local exit_code=0
  bash -c "$cmd" >/tmp/verify-"$name".log 2>&1 || exit_code=$?
  if [[ $exit_code -eq 0 ]]; then
    RESULT[$name]="pass"
    log_text "$(printf '  %-10s ✅ pass' "$name")"
  else
    RESULT[$name]="fail"
    ANY_FAIL=1
    local sep=""
    [[ -n "$FAILURES_JSON" ]] && sep=","
    FAILURES_JSON+="${sep}{\"step\":\"$name\",\"exit\":$exit_code}"
    log_text "$(printf '  %-10s ❌ fail (exit=%d) — see /tmp/verify-%s.log' "$name" "$exit_code" "$name")"
  fi
}

log_text "verify.sh: starting"

run_step build     "$BUILD_CMD"
run_step lint      "$LINT_CMD"
run_step format    "$FORMAT_CMD"
run_step typecheck "$TYPECHECK_CMD"
run_step test      "$TEST_CMD"

if [[ $JSON_MODE -eq 1 ]]; then
  printf '{"build":"%s","lint":"%s","format":"%s","typecheck":"%s","test":"%s","failures":[%s]}\n' \
    "${RESULT[build]}" "${RESULT[lint]}" "${RESULT[format]}" "${RESULT[typecheck]}" "${RESULT[test]}" \
    "$FAILURES_JSON"
fi

if [[ $ANY_FAIL -eq 1 ]]; then
  exit 1
fi
exit 0
