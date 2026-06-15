#!/usr/bin/env python3
"""Build the canonical cron job manifest for knishioka-pm.

Reads ``config/cron/jobs.yaml`` (the source-of-truth for this workspace's
cron jobs) and emits a JSON manifest that ``scripts/register-cron-jobs.sh``
consumes when calling ``openclaw cron edit`` / ``openclaw cron add``.

The manifest is also what ``scripts/verify-cron-playbooks.sh`` compares
against the live ``openclaw cron list --json`` output, so committing
``config/cron/jobs.yaml`` makes every cron change reviewable in a PR and
detectable as drift if the live registry diverges.

Adapted from the ds-pm workspace (``~/.openclaw/workspace-ds-pm``). Unlike
ds-pm, knishioka-pm has no per-project templates and no playbook files: all
jobs are singletons whose full prompt lives inline in ``message``. Each job
carries per-job ``delivery`` and payload metadata (``thinking``,
``timeout_seconds``, ``model``) because these differ across the 5 jobs.
A ``playbook`` field is still supported (optional) for forward-compat.

Output (default ``build/cron/manifest.json``):

    {
      "schema_version": 1,
      "generated_from": "config/cron/jobs.yaml",
      "playbook_hashes": {},
      "jobs": [
        {
          "name": "weekly-repo-health",
          "description": "...",
          "agent_id": "knishioka-pm",
          "schedule": {"kind": "cron", "expr": "0 20 * * 0", "tz": "Asia/Kuala_Lumpur"},
          "session_target": "isolated",
          "wake_mode": "now",
          "thinking": "medium",
          "timeout_seconds": 900,
          "model": null,
          "delivery": {"mode": "none", "channel": "whatsapp", "to": "+81...", "best_effort": true},
          "playbook": null,
          "message": "...",
          "message_hash": "<sha256 of rstripped message>",
          "failure_alert": {...},
          "enabled": true
        },
        ...
      ]
    }

Usage:
    scripts/build-cron-jobs.py                # writes build/cron/manifest.json
    scripts/build-cron-jobs.py --output -     # writes JSON to stdout
    scripts/build-cron-jobs.py --check        # just expand and validate, no write
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import re
import sys
from pathlib import Path
from typing import Any


def _load_yaml(path: Path) -> Any:
    """Load YAML using PyYAML if available, else fall back to ``uv run`` shim.

    CI installs PyYAML directly (``import yaml`` path). Locally, where PyYAML
    may not be on the interpreter, we shell out to ``uv run --with pyyaml``
    the same way the workspace's other Python tools do.
    """
    try:
        import yaml  # type: ignore[import-not-found]

        return yaml.safe_load(path.read_text())
    except ModuleNotFoundError:
        import subprocess

        out = subprocess.check_output(
            [
                "uv",
                "run",
                "--quiet",
                "--with",
                "pyyaml",
                "python3",
                "-c",
                "import sys, yaml, json;"
                "print(json.dumps(yaml.safe_load(open(sys.argv[1]).read())))",
                str(path),
            ],
            text=True,
        )
        return json.loads(out)


def _sha256(data: str) -> str:
    return hashlib.sha256(data.encode("utf-8")).hexdigest()


_ENV_REF = re.compile(r"\$\{([A-Z_][A-Z0-9_]*)\}")


def _expand_env(value: Any, unresolved: set[str]) -> Any:
    """Substitute ``${NAME}`` references from the environment.

    Secrets / PII (e.g. the WhatsApp alert number) live in the environment, not
    in the committed ``config/cron/jobs.yaml`` (this repo is public). At build
    time we resolve them so the manifest the registry consumes carries the real
    value, while the source-of-truth stays scrubbed.

    Names that are not set in the environment are left as the literal
    ``${NAME}`` and recorded in ``unresolved`` so the caller can decide whether
    that is fatal (apply / live verify) or acceptable (offline structural check).
    """
    if not isinstance(value, str):
        return value

    def _sub(m: "re.Match[str]") -> str:
        name = m.group(1)
        if name in os.environ:
            return os.environ[name]
        unresolved.add(name)
        return m.group(0)

    return _ENV_REF.sub(_sub, value)


def _normalize_delivery(
    delivery: dict[str, Any] | None, unresolved: set[str]
) -> dict[str, Any]:
    """Normalize a job's delivery block to a canonical shape.

    ``mode`` is required (``none`` or ``announce``). ``channel`` defaults to
    ``last`` to mirror the ``openclaw cron add`` default. ``to`` and
    ``best_effort`` are optional and omitted when absent so the manifest only
    carries fields that were actually declared.
    """
    delivery = delivery or {}
    mode = delivery.get("mode", "none")
    if mode not in ("none", "announce"):
        raise SystemExit(
            f"build-cron-jobs: invalid delivery.mode {mode!r} (want none|announce)"
        )
    out: dict[str, Any] = {"mode": mode, "channel": delivery.get("channel", "last")}
    if "to" in delivery and delivery["to"] is not None:
        out["to"] = _expand_env(delivery["to"], unresolved)
    if "best_effort" in delivery and delivery["best_effort"] is not None:
        out["best_effort"] = bool(delivery["best_effort"])
    return out


def _normalize_failure_alert(
    fa: dict[str, Any], unresolved: set[str]
) -> dict[str, Any]:
    """Pass the failure_alert block through with a stable key order."""
    out = {
        "after": fa["after"],
        "channel": fa["channel"],
        "to": _expand_env(fa["to"], unresolved),
        "cooldown_ms": fa["cooldown_ms"],
        "mode": fa["mode"],
        "account_id": fa["account_id"],
    }
    if "best_effort" in fa and fa["best_effort"] is not None:
        out["best_effort"] = bool(fa["best_effort"])
    return out


def _normalize_job(
    job: dict[str, Any], defaults: dict[str, Any], unresolved: set[str]
) -> dict[str, Any]:
    schedule = dict(job["schedule"])
    if schedule.get("kind") == "cron" and "tz" not in schedule:
        schedule["tz"] = defaults["tz"]
    message = _expand_env(job["message"], unresolved).rstrip()
    return {
        "name": job["name"],
        "description": job.get("description", ""),
        "agent_id": defaults["agent_id"],
        "schedule": schedule,
        "session_target": job.get("session_target", defaults["session_target"]),
        "wake_mode": job.get("wake_mode", defaults["wake_mode"]),
        "thinking": job.get("thinking", defaults.get("thinking")),
        "timeout_seconds": job.get("timeout_seconds"),
        "model": job.get("model"),
        "delivery": _normalize_delivery(job.get("delivery"), unresolved),
        "playbook": job.get("playbook"),
        "message": message,
        "message_hash": _sha256(message),
        "failure_alert": _normalize_failure_alert(
            defaults["failure_alert"], unresolved
        ),
        "enabled": job.get("enabled", defaults["enabled"]),
    }


def _load_secrets_env(workspace_root: Path) -> None:
    """Load config/cron/secrets.env into the environment (fills gaps only).

    Secrets / PII (the WhatsApp alert number) must be in os.environ for
    _expand_env to resolve ${...} references. Relying on the caller to `export`
    them by hand is fragile: a forgotten or mistyped export silently bakes a
    placeholder into the live registry (this is exactly how KNISHIOKA_ALERT_TO
    became '+81xxxxxxxxxx'). Persisting them in this gitignored file makes every
    build resolve correctly regardless of the shell. An explicit export still
    wins (setdefault), so a one-off override stays possible.
    """
    env_file = workspace_root / "config" / "cron" / "secrets.env"
    if not env_file.is_file():
        return
    for raw in env_file.read_text().splitlines():
        line = raw.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, _, val = line.partition("=")
        key = key.strip()
        val = val.strip().strip('"').strip("'")
        if key:
            os.environ.setdefault(key, val)


_PHONE_RE = re.compile(r"^\+?[0-9]{7,15}$")
# WhatsApp JIDs / group IDs are long digit strings (group IDs are ~18 digits and
# can carry a legacy "<creator>-<timestamp>" hyphen), and are NOT length-bounded
# like phone numbers — so they get their own pattern rather than _PHONE_RE.
_WA_JID_LOCAL_RE = re.compile(r"^[0-9][0-9-]{4,29}$")
_WA_TARGET_SUFFIXES = ("@g.us", "@s.whatsapp.net", "@c.us")


def _looks_like_valid_target(to: str) -> bool:
    for suf in _WA_TARGET_SUFFIXES:
        if to.endswith(suf):
            return bool(_WA_JID_LOCAL_RE.match(to[: -len(suf)]))
    return bool(_PHONE_RE.match(to))


def _validate_targets(jobs: list[dict[str, Any]]) -> None:
    """Reject resolved delivery targets that look like an unfilled placeholder.

    Guards the failure mode where ${KNISHIOKA_ALERT_TO} resolves to a docs
    placeholder like '+81xxxxxxxxxx' (which IS set, so the unset-env check below
    misses it) and gets silently registered. Only fully-resolved values are
    checked; literals still containing '${' are caught by the unresolved-env
    gate instead.
    """
    bad: list[str] = []
    for job in jobs:
        candidates: list[tuple[str, str]] = []
        delivery = job.get("delivery") or {}
        if delivery.get("to"):
            candidates.append(("delivery.to", delivery["to"]))
        fa = job.get("failure_alert") or {}
        if fa.get("to"):
            candidates.append(("failure_alert.to", fa["to"]))
        for where, val in candidates:
            sval = str(val)
            if "${" in sval:
                continue
            if not _looks_like_valid_target(sval):
                bad.append(f"{job.get('name')}: {where}={val!r}")
    if bad:
        joined = "\n  ".join(bad)
        raise SystemExit(
            "build-cron-jobs: delivery target(s) look like an unfilled "
            "placeholder, not a real phone/WhatsApp id:\n  "
            f"{joined}\n"
            "  Fix config/cron/secrets.env (e.g. KNISHIOKA_ALERT_TO=+<digits>) "
            "and rebuild. A real number must be all digits (optionally +-prefixed)."
        )


def build(
    workspace_root: Path, jobs_yaml_path: Path, allow_unset_env: bool = False
) -> dict[str, Any]:
    _load_secrets_env(workspace_root)
    spec = _load_yaml(jobs_yaml_path)
    if spec.get("schema_version") != 1:
        raise SystemExit(
            f"build-cron-jobs: unsupported schema_version "
            f"{spec.get('schema_version')!r} in {jobs_yaml_path}"
        )
    defaults = spec.get("defaults") or {}
    for required in (
        "agent_id",
        "tz",
        "enabled",
        "session_target",
        "wake_mode",
        "failure_alert",
    ):
        if required not in defaults:
            raise SystemExit(
                f"build-cron-jobs: missing required default '{required}' in {jobs_yaml_path}"
            )

    unresolved: set[str] = set()
    expanded: list[dict[str, Any]] = []
    playbook_paths: set[str] = set()
    for job in spec.get("jobs") or []:
        expanded.append(_normalize_job(job, defaults, unresolved))
        if job.get("playbook"):
            playbook_paths.add(job["playbook"])

    # ${ENV} references (e.g. the WhatsApp alert number) must resolve before the
    # manifest is applied to or compared against the live registry. Offline /
    # structural checks tolerate unset vars (allow_unset_env=True).
    if unresolved and not allow_unset_env:
        names = ", ".join(sorted(unresolved))
        raise SystemExit(
            f"build-cron-jobs: unset environment variable(s) referenced in "
            f"{jobs_yaml_path.name}: {names}\n"
            f"  export them before build/register/verify --live, "
            f"or pass --allow-unset-env for a structural-only build."
        )

    # Playbook hashes (knishioka jobs are inline today, so this is usually
    # empty — kept for parity with ds-pm so a future playbook reference is
    # automatically drift-checked).
    playbook_hashes: dict[str, str] = {}
    for rel in sorted(playbook_paths):
        pb_path = workspace_root / rel
        if not pb_path.is_file():
            raise SystemExit(
                f"build-cron-jobs: referenced playbook not found: {rel} (resolved to {pb_path})"
            )
        playbook_hashes[rel] = _sha256(pb_path.read_text())
    for job in expanded:
        pb = job.get("playbook")
        if pb:
            job["playbook_hash"] = playbook_hashes[pb]

    # Sanity: detect duplicate names.
    seen: dict[str, int] = {}
    for job in expanded:
        seen[job["name"]] = seen.get(job["name"], 0) + 1
    dups = sorted(name for name, count in seen.items() if count > 1)
    if dups:
        raise SystemExit(f"build-cron-jobs: duplicate job names produced: {dups}")

    # Reject placeholder-looking delivery targets before they reach the registry.
    _validate_targets(expanded)

    try:
        generated_from = str(jobs_yaml_path.relative_to(workspace_root))
    except ValueError:
        generated_from = str(jobs_yaml_path)

    return {
        "schema_version": 1,
        "generated_from": generated_from,
        "playbook_hashes": playbook_hashes,
        "unresolved_env": sorted(unresolved),
        "jobs": expanded,
    }


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        description="Build the canonical knishioka-pm cron manifest"
    )
    parser.add_argument(
        "--input",
        default=None,
        help="Path to jobs.yaml (default: <workspace>/config/cron/jobs.yaml)",
    )
    parser.add_argument(
        "--output",
        default=None,
        help=(
            "Path to write manifest JSON. "
            "Use '-' for stdout. Default: <workspace>/build/cron/manifest.json"
        ),
    )
    parser.add_argument(
        "--check",
        action="store_true",
        help="Validate and expand without writing output (implies --allow-unset-env)",
    )
    parser.add_argument(
        "--allow-unset-env",
        action="store_true",
        help="Do not fail on unset ${ENV} references (structural-only build)",
    )
    args = parser.parse_args(argv)

    # Detect workspace root: nearest ancestor containing config/cron/jobs.yaml.
    here = Path(__file__).resolve()
    for cand in (here.parent.parent, *here.parents):
        if (cand / "config" / "cron" / "jobs.yaml").is_file():
            workspace_root = cand
            break
    else:
        raise SystemExit("build-cron-jobs: cannot locate workspace root")

    jobs_yaml = (
        Path(args.input).resolve()
        if args.input
        else workspace_root / "config" / "cron" / "jobs.yaml"
    )
    manifest = build(
        workspace_root, jobs_yaml, allow_unset_env=(args.allow_unset_env or args.check)
    )

    if args.check:
        sys.stderr.write(
            f"build-cron-jobs: OK ({len(manifest['jobs'])} jobs, "
            f"{len(manifest['playbook_hashes'])} playbooks)\n"
        )
        return 0

    out_target = (
        Path(args.output).resolve()
        if (args.output and args.output != "-")
        else (
            None
            if args.output == "-"
            else workspace_root / "build" / "cron" / "manifest.json"
        )
    )

    payload = json.dumps(manifest, ensure_ascii=False, indent=2) + "\n"
    if out_target is None:
        sys.stdout.write(payload)
    else:
        out_target.parent.mkdir(parents=True, exist_ok=True)
        out_target.write_text(payload)
        try:
            display = out_target.relative_to(workspace_root)
        except ValueError:
            display = out_target
        sys.stderr.write(
            f"build-cron-jobs: wrote {len(manifest['jobs'])} jobs to {display}\n"
        )
    return 0


if __name__ == "__main__":
    sys.exit(main())
