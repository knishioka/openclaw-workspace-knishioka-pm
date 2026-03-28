# Monitoring Overview

## State Files

| File                  | Purpose                                               | Gitignored |
| --------------------- | ----------------------------------------------------- | ---------- |
| `repo-state.json`     | Last knowledge extraction timestamps per repo         | Yes        |
| `health-trend.jsonl`  | Weekly health snapshots with trend data (append-only) | Yes        |
| `last-suggested.json` | Last repo suggested by focus-task (avoid repeats)     | Yes        |
| `active-session.json` | Current session's active repo (heartbeat)             | Yes        |
| `private-health.json` | Private repo health data (never committed)            | Yes        |
| `latest-health.json`  | Raw JSON from last health run                         | Yes        |

## Cron Jobs

| Job                      | Agent        | Schedule (KL)  | 配信                  | Purpose                    |
| ------------------------ | ------------ | -------------- | --------------------- | -------------------------- |
| weekly-repo-health       | knishioka-pm | Sun 20:00      | WhatsApp (変化時のみ) | トレンド対応ヘルスレポート |
| focus-task               | knishioka-pm | Mon+Thu 8:30   | commit のみ           | 1リポ1タスク集中提案       |
| weekly-knowledge-extract | knishioka-pm | Fri 19:00      | commit                | ナレッジ抽出 + CHANGELOG   |
| monthly-portfolio-review | knishioka-pm | 第1日曜 19:00  | WhatsApp              | ポートフォリオ全体俯瞰     |
| private-repo-check       | knishioka-pm | 隔週水曜 20:00 | gitignored only       | Private リポ監視           |

## Heartbeat

30分間隔（セッションアクティブ時のみ）。サイレントでコンテキスト追跡。CI failure 検出時のみ発言。

## Reports

| File                                     | Content                               | Committed |
| ---------------------------------------- | ------------------------------------- | --------- |
| `reports/latest-health.md`               | Public repo health report             | Yes       |
| `reports/latest-focus.md`                | Today's focus task (1 repo, 1 action) | Yes       |
| `reports/monthly-portfolio-{YYYY-MM}.md` | Monthly portfolio review              | Yes       |

## Escalation Tiers

Silent → Inform → Nudge → Escalate → Archive
(Details in AGENTS.md)
