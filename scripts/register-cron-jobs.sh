#!/usr/bin/env bash
# Apply the canonical cron manifest (build/cron/manifest.json) to the local
# openclaw cron registry for the knishioka-pm agent.
#
# STATE-PRESERVING: unlike the ds-pm register script (which rm's + re-add's),
# this matches manifest jobs to live jobs BY NAME and patches them in place
# with `openclaw cron edit <id>`. Editing keeps the job id, so nextRun /
# lastRun / consecutiveErrors state is preserved (Issue #37 constraint:
# "既存ジョブの state を破壊しない / schedule-identity を変えない"). Only jobs
# that do not yet exist are created with `openclaw cron add`. Existing jobs are
# never removed.
#
# Usage:
#   scripts/register-cron-jobs.sh                      # apply default manifest
#   scripts/register-cron-jobs.sh --manifest <path>    # apply alternate manifest
#   scripts/register-cron-jobs.sh --dry-run            # print plan, change nothing
#
# Exit codes:
#   0  success (or no-op when --dry-run)
#   1  invalid CLI / manifest
#   2  one or more openclaw operations failed
set -euo pipefail

WORKSPACE_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
AGENT_ID="knishioka-pm"
MANIFEST="${WORKSPACE_ROOT}/build/cron/manifest.json"
DRY_RUN=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --manifest)
      MANIFEST="$2"
      shift 2
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    -h | --help)
      sed -n '1,/^set -euo/p' "$0" | sed 's/^# \?//'
      exit 0
      ;;
    *)
      echo "register-cron-jobs: unknown arg '$1'" >&2
      exit 1
      ;;
  esac
done

if [[ ! -f "$MANIFEST" ]]; then
  echo "register-cron-jobs: manifest not found at $MANIFEST" >&2
  echo "  Run scripts/build-cron-jobs.py first (or pass --manifest <path>)" >&2
  exit 1
fi

if ! command -v openclaw > /dev/null 2>&1; then
  echo "register-cron-jobs: 'openclaw' CLI not on PATH" >&2
  exit 1
fi

# Refuse to apply a manifest with unresolved ${ENV} references — that would
# register a literal "${KNISHIOKA_ALERT_TO}" as a delivery target. Rebuild with
# the env var exported (see docs/cron.md).
UNRESOLVED="$(python3 -c "import json,sys;print(','.join(json.load(open(sys.argv[1])).get('unresolved_env') or []))" "$MANIFEST")"
if [[ -n "$UNRESOLVED" ]]; then
  echo "register-cron-jobs: manifest has unresolved env var(s): $UNRESOLVED" >&2
  echo "  export them and re-run scripts/build-cron-jobs.py before registering" >&2
  exit 1
fi

# Manifest job names.
mapfile -t MANIFEST_NAMES < <(python3 -c "import json,sys;print('\n'.join(j['name'] for j in json.load(open(sys.argv[1]))['jobs']))" "$MANIFEST")
if [[ ${#MANIFEST_NAMES[@]} -eq 0 ]]; then
  echo "register-cron-jobs: manifest has zero jobs" >&2
  exit 1
fi

# Live knishioka-pm jobs: name -> id.
REGISTERED_JSON="$(openclaw cron list --json)"
declare -A REGISTERED_BY_NAME
while IFS=$'\t' read -r jname jid; do
  [[ -n "$jname" ]] && REGISTERED_BY_NAME["$jname"]="$jid"
done < <(printf '%s' "$REGISTERED_JSON" | python3 -c "
import json,sys
data=json.load(sys.stdin)
for j in data.get('jobs',[]):
    if j.get('agentId')=='$AGENT_ID':
        print(f\"{j['name']}\t{j['id']}\")
")

# Report any live jobs not in the manifest (informational; never removed).
EXTRA=()
for name in "${!REGISTERED_BY_NAME[@]}"; do
  if ! printf '%s\n' "${MANIFEST_NAMES[@]}" | grep -Fxq -- "$name"; then
    EXTRA+=("$name")
  fi
done

echo "register-cron-jobs: manifest jobs    = ${#MANIFEST_NAMES[@]}"
echo "register-cron-jobs: live ${AGENT_ID}  = ${#REGISTERED_BY_NAME[@]}"
echo "register-cron-jobs: extras (kept)    = ${#EXTRA[@]}"
echo "register-cron-jobs: mode             = $([[ $DRY_RUN -eq 1 ]] && echo DRY-RUN || echo APPLY)"
if [[ ${#EXTRA[@]} -gt 0 ]]; then
  printf '  [extra-not-touched] %s\n' "${EXTRA[@]}"
fi
echo

# Emit the openclaw flag argv for EVERY job in a single python invocation
# (manifest parsed once). NUL framing is required because messages contain
# newlines, '$', and CJK text that would break eval/word-splitting.
#
# Stream layout per job: name, enabled("1"/"0"), argc, then <argc> flag tokens
# — all NUL-delimited. The count prefix lets bash slice each job's args back
# out unambiguously even though the args themselves may contain any byte except
# NUL. The leading subcommand (add) or id (edit) and the enable/disable flag are
# added by the bash caller, which is the side that knows whether the job exists.
emit_all_args() {
  MANIFEST="$MANIFEST" python3 << 'PY'
import json, os, sys

manifest = json.load(open(os.environ["MANIFEST"]))
out = []

for job in manifest["jobs"]:
    args = [
        "--agent", job["agent_id"],
        "--name", job["name"],
        "--description", job.get("description", ""),
        "--session", job["session_target"],
        "--wake", job["wake_mode"],
        "--message", job["message"],
    ]

    sched = job["schedule"]
    if sched.get("kind") == "cron":
        args += ["--cron", sched["expr"]]
        if sched.get("tz"):
            args += ["--tz", sched["tz"]]
    elif sched.get("kind") == "every":
        secs = int(sched["every_ms"] / 1000)
        args += ["--every", f"{secs}s"]

    # Payload metadata.
    if job.get("thinking"):
        args += ["--thinking", str(job["thinking"])]
    if job.get("timeout_seconds") is not None:
        args += ["--timeout-seconds", str(job["timeout_seconds"])]
    if job.get("model"):
        args += ["--model", str(job["model"])]

    # Delivery.
    d = job.get("delivery") or {}
    if d.get("channel"):
        args += ["--channel", d["channel"]]
    if d.get("to"):
        args += ["--to", d["to"]]
    if d.get("best_effort"):
        args += ["--best-effort-deliver"]
    if d.get("mode") == "announce":
        args += ["--announce"]
    else:
        args += ["--no-deliver"]

    # Failure alert.
    fa = job.get("failure_alert") or {}
    if fa:
        ms = int(fa.get("cooldown_ms", 0))
        if ms and ms % 3600000 == 0:
            cooldown = f"{ms // 3600000}h"
        elif ms and ms % 60000 == 0:
            cooldown = f"{ms // 60000}m"
        else:
            cooldown = f"{ms // 1000}s"
        args += [
            "--failure-alert",
            "--failure-alert-after", str(fa["after"]),
            "--failure-alert-channel", fa["channel"],
            "--failure-alert-to", fa["to"],
            "--failure-alert-cooldown", cooldown,
            "--failure-alert-mode", fa["mode"],
            "--failure-alert-account-id", fa["account_id"],
        ]

    out.append(job["name"])
    out.append("1" if job.get("enabled", True) else "0")
    out.append(str(len(args)))
    out.extend(args)

sys.stdout.write("\0".join(out))
PY
}

# Read the whole stream once, then walk it record by record.
mapfile -d '' -t TOKENS < <(emit_all_args)

FAILED=()

strip_failure_alert_args() {
  local out=()
  local skip_next=0
  local token
  for token in "$@"; do
    if [[ $skip_next -eq 1 ]]; then
      skip_next=0
      continue
    fi
    case "$token" in
      --failure-alert)
        ;;
      --failure-alert-after | --failure-alert-channel | --failure-alert-to | --failure-alert-cooldown | --failure-alert-mode | --failure-alert-account-id)
        skip_next=1
        ;;
      *)
        out+=("$token")
        ;;
    esac
  done
  # Guard: with an empty array, `printf '%s\0'` still fires once and emits a lone
  # NUL, which mapfile -d '' would read back as a single empty element (making
  # ${#arr[@]} == 1 instead of 0). Only print when there is something to print.
  [[ ${#out[@]} -gt 0 ]] && printf '%s\0' "${out[@]}"
}

extract_failure_alert_args() {
  local out=()
  local take_next=0
  local token
  for token in "$@"; do
    if [[ $take_next -eq 1 ]]; then
      out+=("$token")
      take_next=0
      continue
    fi
    case "$token" in
      --failure-alert)
        out+=("$token")
        ;;
      --failure-alert-after | --failure-alert-channel | --failure-alert-to | --failure-alert-cooldown | --failure-alert-mode | --failure-alert-account-id)
        out+=("$token")
        take_next=1
        ;;
    esac
  done
  # Guard: with an empty array, `printf '%s\0'` still fires once and emits a lone
  # NUL, which mapfile -d '' would read back as a single empty element (making
  # ${#arr[@]} == 1 instead of 0). Only print when there is something to print.
  [[ ${#out[@]} -gt 0 ]] && printf '%s\0' "${out[@]}"
}

lookup_live_job_id() {
  local job_name="$1"
  # NOTE: must use `python3 -c`, not a `<<'PY'` heredoc. A heredoc redirects the
  # program text onto stdin, which clobbers the piped `cron list --json` — then
  # `json.load(sys.stdin)` sees no data, the lookup returns empty, and newly
  # added jobs never get their failure alert applied (codex P1).
  openclaw cron list --json | JOB_NAME="$job_name" AGENT_ID="$AGENT_ID" python3 -c '
import json
import os
import sys

data = json.load(sys.stdin)
for job in data.get("jobs", []):
    if job.get("agentId") == os.environ["AGENT_ID"] and job.get("name") == os.environ["JOB_NAME"]:
        print(job["id"])
        break
'
}

i=0
while ((i < ${#TOKENS[@]})); do
  name="${TOKENS[i]}"
  ((i += 1))
  enabled="${TOKENS[i]}"
  ((i += 1))
  argc="${TOKENS[i]}"
  ((i += 1))
  args=("${TOKENS[@]:i:argc}")
  ((i += argc))
  id="${REGISTERED_BY_NAME[$name]:-}"
  alert_args=()

  if [[ -n "$id" ]]; then
    # Existing job: patch in place (preserves state). Reflect the manifest's
    # enabled flag rather than forcing --enable.
    enable_flag=$([[ "$enabled" == "1" ]] && echo "--enable" || echo "--disable")
    op=(openclaw cron edit "$id" "$enable_flag" "${args[@]}")
  else
    # New job: `add` defaults to enabled; pass --disabled when the manifest
    # says the job should be off.
    # `openclaw cron add` currently does not accept --failure-alert* flags
    # (edit does). Create first, then patch alerts once the job has an id.
    mapfile -d '' -t add_args < <(strip_failure_alert_args "${args[@]}")
    mapfile -d '' -t alert_args < <(extract_failure_alert_args "${args[@]}")
    op=(openclaw cron add "${add_args[@]}")
    [[ "$enabled" == "0" ]] && op+=(--disabled)
  fi

  if [[ $DRY_RUN -eq 1 ]]; then
    printf '+'
    printf ' %q' "${op[@]}"
    printf '\n'
  else
    if ! "${op[@]}" > /dev/null; then
      FAILED+=("$name")
    else
      if [[ -z "$id" && ${#alert_args[@]} -gt 0 ]]; then
        new_id="$(lookup_live_job_id "$name")"
        if [[ -n "$new_id" ]]; then
          if ! openclaw cron edit "$new_id" "${alert_args[@]}" > /dev/null; then
            FAILED+=("$name")
            continue
          fi
        fi
      fi
      echo "register-cron-jobs: $([[ -n "$id" ]] && echo edited || echo added) $name"
    fi
  fi
done

if [[ ${#FAILED[@]} -gt 0 ]]; then
  echo "register-cron-jobs: FAIL on ${#FAILED[@]} job(s):" >&2
  printf '  - %s\n' "${FAILED[@]}" >&2
  exit 2
fi

echo "register-cron-jobs: $([[ $DRY_RUN -eq 1 ]] && echo DRY-RUN done || echo applied) ${#MANIFEST_NAMES[@]} jobs"
