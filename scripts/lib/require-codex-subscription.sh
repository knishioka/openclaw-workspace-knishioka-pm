#!/usr/bin/env bash
# require-codex-subscription: source this from any wrapper that spawns
# `codex exec` to ensure we never accidentally bill against an API key.
#
# Defense-in-depth layer 3 (script-side guard). Layers 1 + 2 are:
#   1. ~/.codex/config.toml: preferred_auth_method = "chatgpt"
#                            forced_login_method   = "chatgpt"
#   2. ~/.oh-my-zsh/custom/00-environment.zsh: unset OPENAI_API_KEY
#
# Why both: layers 1+2 prevent codex from picking API-key auth in the first
# place, but if any of {chezmoi rollback / fresh box / future codex regression
# like openai/codex#20099 / a script that re-exports the env var} bypasses
# them, this guard catches it before money flows. Sourced (not exec'd) so it
# can return 0 / call exit on failure.
#
# Fail-closed: any check that cannot prove ChatGPT subscription auth returns
# non-zero. Missing `codex` CLI, non-zero `codex login status` exit, and
# unparseable status output all abort instead of falling through.
#
# Usage:
#   source "$(dirname "$0")/lib/require-codex-subscription.sh"
#   require_codex_subscription || exit 5

require_codex_subscription() {
  # 0. The codex CLI itself must be available. Without it, every check below
  #    is meaningless and would otherwise capture shell "command not found"
  #    text as $status_line, then fail open at the "no auth.json" path.
  if ! command -v codex >/dev/null 2>&1; then
    echo "ABORT: 'codex' CLI not found in PATH — cannot verify subscription auth." >&2
    return 1
  fi

  # 1. The most authoritative check: codex's own status output.
  #    `codex login status` exits 0 when logged in, prints "Logged in using ChatGPT"
  #    or "Logged in using an API key - sk-***".
  #
  #    Capture stdout+stderr AND exit code separately so we fail closed when
  #    the subcommand errors (renamed flag, permission/config error, codex
  #    binary in PATH but broken). Piping into `head` would mask the upstream
  #    exit code under default pipefail-off behaviour.
  local raw_status rc status_line
  raw_status=$(codex login status 2>&1)
  rc=$?
  if [ "$rc" -ne 0 ]; then
    echo "ABORT: 'codex login status' exited ${rc} — refusing to spawn." >&2
    [ -n "$raw_status" ] && echo "       ${raw_status}" >&2
    echo "Fix:   codex logout && codex login   # OAuth flow for ChatGPT subscription" >&2
    return 1
  fi
  status_line=$(printf '%s\n' "$raw_status" | head -n 1)
  if [ -z "$status_line" ]; then
    echo "ABORT: codex login status returned nothing (not logged in?)" >&2
    return 1
  fi
  if echo "$status_line" | grep -q "API key"; then
    echo "ABORT: codex is configured for API-KEY billing — refusing to spawn." >&2
    echo "       (\`$status_line\`)" >&2
    echo "Fix:   codex logout && codex login   # OAuth flow for ChatGPT subscription" >&2
    return 1
  fi
  if ! echo "$status_line" | grep -q "ChatGPT"; then
    echo "ABORT: codex login status did not confirm ChatGPT auth: '$status_line'" >&2
    echo "       Refusing to spawn rather than fall back to a permissive default." >&2
    return 1
  fi

  # 2. Cross-check ~/.codex/auth.json — independent signal in case `codex login
  #    status` ever lies (bug surface). jq is optional; on hosts without jq we
  #    fall back to grep heuristics so this guard doesn't silently degrade.
  local auth_mode openai_key_present
  if [ -f "${HOME}/.codex/auth.json" ]; then
    if command -v jq >/dev/null 2>&1; then
      auth_mode=$(jq -r '.auth_mode // "unknown"' "${HOME}/.codex/auth.json" 2>/dev/null)
      openai_key_present=$(jq -r '.OPENAI_API_KEY != null' "${HOME}/.codex/auth.json" 2>/dev/null)
    else
      # Heuristic fallback — single-line JSON or pretty-printed both work.
      # `"auth_mode": "chatgpt"` (with optional whitespace) → match.
      if grep -qE '"auth_mode"[[:space:]]*:[[:space:]]*"chatgpt"' "${HOME}/.codex/auth.json"; then
        auth_mode="chatgpt"
      else
        auth_mode="unknown"
      fi
      if grep -qE '"OPENAI_API_KEY"[[:space:]]*:[[:space:]]*"[^"]+"' "${HOME}/.codex/auth.json"; then
        openai_key_present="true"
      else
        openai_key_present="false"
      fi
    fi
    if [ "$auth_mode" != "chatgpt" ]; then
      echo "ABORT: ~/.codex/auth.json auth_mode=${auth_mode}, expected 'chatgpt'." >&2
      return 1
    fi
    if [ "$openai_key_present" = "true" ]; then
      echo "WARN: ~/.codex/auth.json still carries an OPENAI_API_KEY value." >&2
      echo "      preferred_auth_method=\"chatgpt\" should keep codex on subscription," >&2
      echo "      but consider \`codex logout\` + \`codex login\` to clean it up." >&2
    fi
  fi

  # 3. Catch the silent-switch bug: env var present means codex may pick it up
  #    even with config saying otherwise (openai/codex#20099 history).
  if [ -n "${OPENAI_API_KEY:-}" ]; then
    echo "ABORT: OPENAI_API_KEY is set in the environment." >&2
    echo "       Even with preferred_auth_method=chatgpt, this can flip auth." >&2
    echo "Fix:   unset OPENAI_API_KEY   # or remove from shell rc / .env" >&2
    return 1
  fi

  return 0
}
