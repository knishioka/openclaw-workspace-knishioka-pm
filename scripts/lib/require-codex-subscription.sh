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
# Usage:
#   source "$(dirname "$0")/lib/require-codex-subscription.sh"
#   require_codex_subscription || exit 4

require_codex_subscription() {
  # 1. The most authoritative check: codex's own /status output.
  #    `codex login status` exits 0 when logged in, prints "Logged in using ChatGPT"
  #    or "Logged in using an API key - sk-***".
  local status_line
  status_line=$(codex login status 2>&1 | head -1)
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
    echo "WARN: codex login status unexpected: '$status_line'" >&2
    # Fall through to auth.json check rather than block, in case the wording
    # changes in a future codex-cli release.
  fi

  # 2. Cross-check ~/.codex/auth.json — independent signal in case `codex login
  #    status` ever lies (bug surface).
  local auth_mode openai_key_present
  if [ -f "${HOME}/.codex/auth.json" ]; then
    auth_mode=$(jq -r '.auth_mode // "unknown"' "${HOME}/.codex/auth.json" 2>/dev/null)
    openai_key_present=$(jq -r '.OPENAI_API_KEY != null' "${HOME}/.codex/auth.json" 2>/dev/null)
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
