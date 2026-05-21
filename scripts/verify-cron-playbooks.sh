#!/usr/bin/env bash
# Drift detector for knishioka-pm cron jobs.
#
# Builds the canonical cron manifest from config/cron/jobs.yaml and compares
# it to either:
#   (a) the live registered cron jobs (`openclaw cron list --json`)
#   (b) a recorded snapshot JSON (for CI / offline use)
#
# Reports any divergence by job name. Exit code:
#   0  no drift detected (or offline build OK)
#   1  invalid CLI / build failure
#   2  drift detected
#
# Usage:
#   scripts/verify-cron-playbooks.sh                  # default: live mode
#   scripts/verify-cron-playbooks.sh --live           # explicit live mode
#   scripts/verify-cron-playbooks.sh --offline        # build-only (no openclaw call)
#   scripts/verify-cron-playbooks.sh --snapshot <path>  # compare to JSON snapshot
#
# CI use: --offline ensures config/cron/jobs.yaml parses and the manifest is
# self-consistent. --live additionally verifies the local registry matches the
# canonical source. The script never mutates the registry.
#
# Adapted from ds-pm (~/.openclaw/workspace-ds-pm/scripts/verify-cron-playbooks.sh).
# knishioka jobs are singletons with inline messages (no playbook files), so the
# comparison covers message_hash, schedule, delivery, and payload metadata.
set -euo pipefail

WORKSPACE_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
AGENT_ID="knishioka-pm"
MODE=live
SNAPSHOT_PATH=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --live) MODE=live; shift ;;
    --offline) MODE=offline; shift ;;
    --snapshot) MODE=snapshot; SNAPSHOT_PATH="$2"; shift 2 ;;
    -h|--help) sed -n '1,/^set -euo/p' "$0" | sed 's/^# \?//'; exit 0 ;;
    *) echo "verify-cron-playbooks: unknown arg '$1'" >&2; exit 1 ;;
  esac
done

# Build the canonical manifest into a tmp file (never commits).
BUILD_DIR="$(mktemp -d)"
trap 'rm -rf "$BUILD_DIR"' EXIT
MANIFEST="$BUILD_DIR/manifest.json"

if ! python3 "$WORKSPACE_ROOT/scripts/build-cron-jobs.py" --output "$MANIFEST" >/dev/null 2>"$BUILD_DIR/build.err"; then
  echo "verify-cron-playbooks: BUILD FAILED" >&2
  cat "$BUILD_DIR/build.err" >&2
  exit 1
fi

if [[ "$MODE" == "offline" ]]; then
  N="$(python3 -c "import json,sys; print(len(json.load(open('$MANIFEST'))['jobs']))")"
  echo "verify-cron-playbooks: offline OK ($N jobs; manifest builds and is self-consistent)"
  exit 0
fi

# Acquire the comparison set.
case "$MODE" in
  live)
    if ! command -v openclaw >/dev/null 2>&1; then
      echo "verify-cron-playbooks: 'openclaw' not on PATH (use --offline for static check)" >&2
      exit 1
    fi
    REG="$BUILD_DIR/registered.json"
    if ! openclaw cron list --json >"$REG" 2>"$BUILD_DIR/openclaw.err"; then
      echo "verify-cron-playbooks: openclaw cron list FAILED" >&2
      cat "$BUILD_DIR/openclaw.err" >&2
      exit 1
    fi
    ;;
  snapshot)
    if [[ ! -f "$SNAPSHOT_PATH" ]]; then
      echo "verify-cron-playbooks: snapshot file not found: $SNAPSHOT_PATH" >&2
      exit 1
    fi
    REG="$SNAPSHOT_PATH"
    ;;
esac

# Compare manifest jobs to registered knishioka-pm jobs by name.
MANIFEST="$MANIFEST" REG="$REG" AGENT_ID="$AGENT_ID" python3 <<'PYEOF'
import json
import hashlib
import os
import sys

manifest = json.load(open(os.environ["MANIFEST"]))
registered = json.load(open(os.environ["REG"]))
agent_id = os.environ["AGENT_ID"]


def msg_hash(s):
    return hashlib.sha256((s or "").rstrip().encode("utf-8")).hexdigest()


reg_by_name = {
    j["name"]: j
    for j in registered.get("jobs", [])
    if j.get("agentId") == agent_id
}
manifest_by_name = {j["name"]: j for j in manifest["jobs"]}

issues = []

# (1) names in manifest but not registered.
for n in sorted(set(manifest_by_name) - set(reg_by_name)):
    issues.append(("missing", n, "manifest defines this job but it is not registered"))

# (2) names registered but not in manifest.
for n in sorted(set(reg_by_name) - set(manifest_by_name)):
    issues.append(("extra", n, f"registered {agent_id} job not in manifest (manual? candidate for cleanup)"))

for name, mj in manifest_by_name.items():
    rj = reg_by_name.get(name)
    if rj is None:
        continue
    payload = rj.get("payload") or {}
    if isinstance(payload, str):
        payload = {"message": payload}

    # (3) message hash divergence.
    reg_hash = msg_hash(payload.get("message", ""))
    if reg_hash != mj["message_hash"]:
        issues.append((
            "message-drift",
            name,
            f"message_hash differs (built={mj['message_hash'][:12]}.. registered={reg_hash[:12]}..)",
        ))

    # (4) schedule divergence.
    msch = mj["schedule"]
    rsch = rj.get("schedule") or {}
    if msch.get("kind") != rsch.get("kind"):
        issues.append(("schedule-kind", name, f"built={msch.get('kind')} registered={rsch.get('kind')}"))
    elif msch.get("kind") == "cron":
        if msch.get("expr") != rsch.get("expr"):
            issues.append(("schedule", name, f"cron expr: built={msch.get('expr')!r} registered={rsch.get('expr')!r}"))
        if msch.get("tz") and rsch.get("tz") and msch["tz"] != rsch["tz"]:
            issues.append(("schedule-tz", name, f"tz: built={msch['tz']!r} registered={rsch['tz']!r}"))

    # (5) delivery divergence (mode/channel/to).
    md = mj.get("delivery") or {}
    rd = rj.get("delivery") or {}
    for key, rkey in (("mode", "mode"), ("channel", "channel"), ("to", "to")):
        mv = md.get(key)
        rv = rd.get(rkey)
        if mv is None and rv is None:
            continue
        if mv != rv:
            issues.append(("delivery", name, f"{key}: built={mv!r} registered={rv!r}"))

    # (6) payload metadata divergence (thinking/timeout/model).
    if mj.get("thinking") is not None and mj["thinking"] != payload.get("thinking"):
        issues.append(("thinking", name, f"built={mj['thinking']!r} registered={payload.get('thinking')!r}"))
    if mj.get("timeout_seconds") is not None and mj["timeout_seconds"] != payload.get("timeoutSeconds"):
        issues.append(("timeout", name, f"built={mj['timeout_seconds']!r} registered={payload.get('timeoutSeconds')!r}"))
    if mj.get("model") is not None and mj["model"] != payload.get("model"):
        issues.append(("model", name, f"built={mj['model']!r} registered={payload.get('model')!r}"))

if not issues:
    print(f"verify-cron-playbooks: no drift ({len(manifest_by_name)} jobs match registered)")
    sys.exit(0)

by_kind = {}
for kind, name, msg in issues:
    by_kind.setdefault(kind, []).append((name, msg))

print(f"verify-cron-playbooks: DRIFT ({len(issues)} issues across {len(by_kind)} categories)")
for kind in sorted(by_kind):
    print(f"  [{kind}] ({len(by_kind[kind])})")
    for name, msg in by_kind[kind]:
        print(f"    - {name}: {msg}")
print()
print("Hint: re-run scripts/register-cron-jobs.sh after rebuild to sync.")
sys.exit(2)
PYEOF
