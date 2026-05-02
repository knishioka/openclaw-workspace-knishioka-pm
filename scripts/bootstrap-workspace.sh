#!/usr/bin/env bash
# bootstrap-workspace: workspace 環境 preflight + リポ clone 状況チェック
#
# Why: 新マシンや障害復旧時、12+ 監視リポを手作業で clone するのは事故の元。
# このスクリプトは workspace レベルの init 相当として、依存ツールの存在確認と
# config/repos.yaml に列挙された全リポの clone 状況を一括レポートする。
# `--apply` で未 clone リポを自動 clone し、重複 clone (~/Developer 直下) は
# 警告のみ (削除は Issue #17 / 手動レビュー前提)。
#
# Usage:
#   scripts/bootstrap-workspace.sh                 # dry-run 人間向けレポート
#   scripts/bootstrap-workspace.sh --json          # dry-run 構造化出力
#   scripts/bootstrap-workspace.sh --apply         # 未 clone を実 clone
#   scripts/bootstrap-workspace.sh --apply --json  # apply + JSON
#
# Exit codes:
#   0   success (dry-run 完走、または --apply で全 clone 成功)
#   2   依存ツール不足
#   3   config/repos.yaml が読めない
#   4   --apply 中に gh repo clone が失敗
#
# Dependencies: bash >= 4, gh >= 2.30, codex >= 0.124, jq, yq, gtimeout
# (gtimeout は codex-resolve.sh と揃えた preflight。本スクリプト自体は使わない。)

set -euo pipefail

# --- Locate workspace root ----------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
REPOS_YAML="${WORKSPACE_ROOT}/config/repos.yaml"

# Local checkout convention (matches docs/codex-playbook.md "ローカルリポパス")
LOCAL_REPO_BASE="${LOCAL_REPO_BASE:-${HOME}/Developer/private}"
DEVELOPER_BASE="${DEVELOPER_BASE:-${HOME}/Developer}"

usage() {
  awk 'NR==1{next} /^[^#]/{exit} {sub(/^# ?/,""); print}' "${BASH_SOURCE[0]}"
}

# --- Parse args ---------------------------------------------------------------
APPLY=0
JSON=0
for arg in "$@"; do
  case "$arg" in
    --apply) APPLY=1 ;;
    --json)  JSON=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Error: unknown arg: $arg" >&2; usage >&2; exit 2 ;;
  esac
done

# --- Dependency checks --------------------------------------------------------
# `sort -V` で semver 比較。macOS の sort も対応 (coreutils なし)。
ver_ge() {
  # ver_ge A B → A >= B なら 0
  [ "$1" = "$2" ] && return 0
  printf '%s\n%s\n' "$2" "$1" | sort -CV >/dev/null 2>&1
}

extract_version() {
  # tool 名から "X.Y.Z" 形式の最初のバージョンを抽出
  local tool="$1" out=""
  case "$tool" in
    gh)
      # "gh version 2.91.0 (...)"  -> 2.91.0
      out="$(gh --version 2>/dev/null | head -n 1 | awk '{print $3}')"
      ;;
    codex)
      # "codex-cli 0.125.0" -> 0.125.0
      out="$(codex --version 2>/dev/null | awk '{print $NF}')"
      ;;
  esac
  printf '%s' "$out"
}

DEPS_MISSING=()

check_dep() {
  local name="$1" min_ver="${2:-}" ver=""
  if ! command -v "$name" >/dev/null 2>&1; then
    DEPS_MISSING+=("${name}: not found in PATH")
    return
  fi
  if [ -z "$min_ver" ]; then
    return
  fi
  ver="$(extract_version "$name")"
  if [ -z "$ver" ]; then
    DEPS_MISSING+=("${name}: version unparseable (need >= ${min_ver})")
    return
  fi
  if ! ver_ge "$ver" "$min_ver"; then
    DEPS_MISSING+=("${name}: ${ver} (need >= ${min_ver})")
  fi
}

check_dep gh    2.30
check_dep codex 0.124
check_dep jq
check_dep yq
check_dep gtimeout

# bash 自体のバージョンチェック (script は bash で動いているので $BASH_VERSINFO が使える)
if (( ${BASH_VERSINFO[0]:-0} < 4 )); then
  DEPS_MISSING+=("bash: ${BASH_VERSION:-unknown} (need >= 4)")
fi

if (( ${#DEPS_MISSING[@]} > 0 )); then
  if (( JSON )); then
    printf '%s\n' "${DEPS_MISSING[@]}" \
      | jq -R . \
      | jq -s '{deps: {ok: false, missing: .}, repos: [], summary: {error: "deps_missing"}}'
  else
    echo "❌ Missing or outdated dependencies:" >&2
    for m in "${DEPS_MISSING[@]}"; do echo "  - $m" >&2; done
  fi
  exit 2
fi

# --- Load config/repos.yaml ---------------------------------------------------
if [ ! -f "$REPOS_YAML" ]; then
  echo "Error: $REPOS_YAML not found" >&2
  exit 3
fi

# yq で .repos と .private_repos を結合し、JSONL に流す
# ここで失敗すると yaml が壊れているか yq が想定外の挙動 → exit 3
REPOS_JSONL=""
if ! REPOS_JSONL="$(yq -o=json '.repos + .private_repos' "$REPOS_YAML" 2>/dev/null \
                    | jq -c '.[] | {owner, name, status: (.status // null)}' 2>/dev/null)"; then
  echo "Error: failed to parse $REPOS_YAML (yq/jq error)" >&2
  exit 3
fi

if [ -z "$REPOS_JSONL" ]; then
  echo "Error: $REPOS_YAML produced no repos (.repos / .private_repos が空?)" >&2
  exit 3
fi

# --- Iterate repos ------------------------------------------------------------
TOTAL=0
PRESENT=0
MISSING_CT=0
DUPLICATE_CT=0
APPLIED=0
CLONE_ERRORS=0

# 結果を JSONL で蓄積 (最終出力で集計)
RESULTS_FILE="$(mktemp -t bootstrap-workspace.XXXXXX)"
trap 'rm -f "$RESULTS_FILE"' EXIT

while IFS= read -r repo_json; do
  [ -z "$repo_json" ] && continue
  TOTAL=$((TOTAL + 1))

  owner="$(jq -r '.owner' <<< "$repo_json")"
  name="$(jq  -r '.name'  <<< "$repo_json")"
  status="$(jq -r '.status // ""' <<< "$repo_json")"

  expected_path="${LOCAL_REPO_BASE}/${name}"
  duplicate_path="${DEVELOPER_BASE}/${name}"

  present=false
  if [ -d "${expected_path}/.git" ]; then
    present=true
    PRESENT=$((PRESENT + 1))
  fi

  duplicate_at=""
  # private 配下と Developer 直下が別パスで、かつ Developer 直下にも .git があれば重複
  if [ "$expected_path" != "$duplicate_path" ] && [ -d "${duplicate_path}/.git" ]; then
    duplicate_at="$duplicate_path"
    DUPLICATE_CT=$((DUPLICATE_CT + 1))
  fi

  if $present; then
    action="skip"
  else
    MISSING_CT=$((MISSING_CT + 1))
    if (( APPLY )); then
      if [ "${status}" = "abandoned" ] || [ "${status}" = "on-hold" ]; then
        # 放棄/保留中のリポは --apply でも自動 clone しない (idempotent + 安全)
        action="skip-status"
      elif gh repo clone "${owner}/${name}" "${expected_path}" -- --depth=1 >/dev/null 2>&1; then
        APPLIED=$((APPLIED + 1))
        action="cloned"
      else
        CLONE_ERRORS=$((CLONE_ERRORS + 1))
        action="clone-failed"
      fi
    else
      action="would-clone"
    fi
  fi

  jq -nc \
    --arg owner "$owner" \
    --arg name "$name" \
    --arg status "$status" \
    --arg path "$expected_path" \
    --argjson present "$present" \
    --arg duplicate_at "$duplicate_at" \
    --arg action "$action" \
    '{
       owner: $owner,
       name: $name,
       status: (if $status == "" then null else $status end),
       path: $path,
       present: $present,
       duplicate_at: (if $duplicate_at == "" then null else $duplicate_at end),
       action: $action
     }' >> "$RESULTS_FILE"
done <<< "$REPOS_JSONL"

MODE="dry-run"
(( APPLY )) && MODE="apply"

# --- Emit output --------------------------------------------------------------
if (( JSON )); then
  jq -s \
    --arg mode "$MODE" \
    --argjson total       "$TOTAL" \
    --argjson present     "$PRESENT" \
    --argjson missing     "$MISSING_CT" \
    --argjson duplicates  "$DUPLICATE_CT" \
    --argjson applied     "$APPLIED" \
    --argjson errors      "$CLONE_ERRORS" \
    '{
       deps: {ok: true},
       mode: $mode,
       repos: .,
       summary: {
         total: $total,
         present: $present,
         missing: $missing,
         duplicates: $duplicates,
         applied: $applied,
         clone_errors: $errors
       }
     }' "$RESULTS_FILE"
else
  echo "Workspace bootstrap report (mode: ${MODE})"
  echo "  total=${TOTAL} present=${PRESENT} missing=${MISSING_CT} duplicates=${DUPLICATE_CT} applied=${APPLIED} errors=${CLONE_ERRORS}"
  echo

  while IFS= read -r line; do
    [ -z "$line" ] && continue
    name="$(jq -r '.name' <<< "$line")"
    action="$(jq -r '.action' <<< "$line")"
    duplicate_at="$(jq -r '.duplicate_at // ""' <<< "$line")"
    case "$action" in
      skip)         icon="✅" ; msg="present" ;;
      would-clone)  icon="📥" ; msg="missing (would clone with --apply)" ;;
      cloned)       icon="✨" ; msg="cloned" ;;
      clone-failed) icon="❌" ; msg="clone failed" ;;
      skip-status)  icon="⏭" ; msg="skipped (abandoned / on-hold)" ;;
      *)            icon="?"  ; msg="$action" ;;
    esac
    printf '  %s %-32s  %s\n' "$icon" "$name" "$msg"
    if [ -n "$duplicate_at" ]; then
      printf '    ⚠️  duplicate clone at %s (Issue #17 で整理予定)\n' "$duplicate_at"
    fi
  done < "$RESULTS_FILE"
fi

# clone 失敗があれば exit 4
if (( APPLY )) && (( CLONE_ERRORS > 0 )); then
  exit 4
fi

exit 0
