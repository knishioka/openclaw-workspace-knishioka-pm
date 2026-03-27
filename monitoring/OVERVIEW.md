# Monitoring Overview

## State Tracking

- `repo-state.json` -- Last check timestamps per repo (gitignored, local only)

## Cron Jobs

| Job                      | Agent        | Schedule (KL) | Purpose              |
| ------------------------ | ------------ | ------------- | -------------------- |
| weekly-repo-health       | knishioka-pm | Sun 20:00     | Full health report   |
| daily-task-suggest       | knishioka-pm | Weekdays 8:30 | Task suggestions     |
| weekly-knowledge-extract | knishioka-pm | Fri 19:00     | Knowledge extraction |

## Reports

- `reports/latest-health.md` -- Most recent health report (committed)
- `reports/latest-tasks.md` -- Most recent task suggestions (committed)
- `reports/archive/` -- Historical reports (gitignored)
