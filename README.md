# openclaw-workspace-knishioka-pm

Automated PM workspace for personal GitHub projects, powered by [OpenClaw](https://github.com/nicepkg/openclaw).

## What This Does

Personal projects tend to get abandoned. This workspace runs automated checks to keep them healthy:

| Feature                    | Description                                               | Schedule              |
| -------------------------- | --------------------------------------------------------- | --------------------- |
| **Repo Health Diagnosis**  | Activity, issues, CI, dependencies, security alerts       | Weekly (Sun 20:00)    |
| **Task Auto-Generation**   | Suggests next actions based on repo state                 | Daily (Weekdays 8:30) |
| **Knowledge Accumulation** | Extracts tech decisions and design rationale from history | Weekly (Fri 19:00)    |

## How It Works

```
config/repos.yaml          Define target repositories
        |
   scripts/repo-health     Diagnose each repo via gh CLI
   scripts/task-suggest     Suggest actionable tasks
   scripts/knowledge-collect Extract knowledge from commits/PRs
        |
   reports/                 Health reports & task suggestions
   knowledge/               Per-repo knowledge base
```

All analysis uses the `gh` CLI -- no tokens stored in this repo.

## Repo Health Scoring

| Status | Criteria                                             |
| ------ | ---------------------------------------------------- |
| GREEN  | Active within 7 days, CI passing, no security alerts |
| YELLOW | 30+ days inactive, or 10+ open issues                |
| RED    | 90+ days inactive, CI failing, or security alerts    |

## Directory Structure

```
config/          Target repos and threshold settings
scripts/         Analysis scripts (bash + gh CLI)
reports/         Generated health reports and task suggestions
knowledge/       Per-repo knowledge bases and design decisions
monitoring/      State tracking for incremental checks
```

## Quick Start

```bash
# Check a single repo
./scripts/repo-health knishioka/kanji-practice

# Check all configured repos (via cron or manual)
for repo in $(yq '.repos[].owner + "/" + .repos[].name' config/repos.yaml); do
  ./scripts/repo-health "$repo"
done
```

## Requirements

- `gh` CLI (authenticated)
- `jq`
- `yq` (optional, for parsing repos.yaml)
