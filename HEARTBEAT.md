# HEARTBEAT.md

## Every 30 minutes (session active only)

1. Check if Ken has been working on any monitored repo in this session
   - Look at recent exec/bash history for `gh`, `git` commands referencing monitored repos
2. If yes: update monitoring/active-session.json with `{repo, timestamp}`
3. If a focus-task has been completed during the session, note it
4. No output unless something important changed

## When to speak (exceptions only)

- Ken just pushed to a monitored repo AND CI fails within this heartbeat cycle
  → Brief inline: "Heads up: CI failed on {repo} after your push. Want me to check the logs?"
- Do NOT repeat information from cron reports. The heartbeat is silent context tracking.
