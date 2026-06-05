# market-lens-studio Design Decisions

## 2026-06-04: Deny ScheduleWakeup during headless note runs

- **What**: Deny ScheduleWakeup during headless note runs
- **Why**: Morning automation now blocks wakeup scheduling so headless runs cannot silently end before publishing.
- **Source**: PR #279

## 2026-05-30: Bound morning suggest with a hard wall-clock timeout

- **What**: Bound morning suggest with a hard wall-clock timeout
- **Why**: Automation now fails boundedly instead of hanging or drifting beyond its publishing window.
- **Source**: PR #275

## 2026-05-30: Prevent duplicate posts and surface the real failure reason

- **What**: Prevent duplicate posts and surface the real failure reason
- **Why**: CI/write-article handling now favors idempotency and diagnosable failures over retrying into duplicate publication.
- **Source**: PR #277

## 2026-05-29: fix(note): enforce suggest --auto mandate compliance and headless safety

- **What**: fix(note): enforce suggest --auto mandate compliance and headless safety
- **Why**: 2026-05-29 朝の自動運用（launchd → `claude -p "/note:suggest --auto"`）が**記事を公開せず停止**した。エラーではなく、ワークフロー設計の穴2点の合わせ技：
- **Source**: PR #273

## 2026-05-28: fix(automation): detect summary table success logs

- **What**: fix(automation): detect summary table success logs
- **Why**: ## Summary - Expand notify_workflow_failure.sh phase-row detection to handle new markdown summary rows like `| 5. Publishing |`. - Treat `Workflow Complete`, `Published Article: https://note.com/`, `Draft -> Notion synced`, and `public publ
- **Source**: PR #270

## 2026-05-27: feat(automation): add morning launchd status dashboard

- **What**: feat(automation): add morning launchd status dashboard
- **Why**: ## Summary - Add purpose headers to the three launchd plist templates for Layer 1 / 1.5 / 1.7. - Enhance `scripts/dev/list_morning_jobs.sh` with fixed layer names, schedules, launchd state, last exit code, and purpose text. - Add `scripts/d
- **Source**: PR #268

## 2026-05-27: fix: accept new codex auth doctor output

- **What**: fix: accept new codex auth doctor output
- **Why**: ## Summary - update setup_codex_fallback.sh auth check to accept legacy `auth: OK`, new `auth is configured`, and `stored auth mode` outputs - add mocked setup tests for authenticated and logged-out Codex doctor scenarios - refresh automati
- **Source**: PR #265

## 2026-05-27: feat(automation): add Codex fallback Wave D orchestrator

- **What**: feat(automation): add Codex fallback Wave D orchestrator
- **Why**: ## Summary - add shared morning lock helpers and wire Layer 1 / Layer 1.5 scripts through them - add shared Slack notifier with same-day layer/type dedup plus Wave D payload templates - add publish retry policy, phase runner, idempotency ch
- **Source**: PR #261

## 2026-05-27: feat(quality): add Codex fact-check quality gates

- **What**: feat(quality): add Codex fact-check quality gates
- **Why**: ## Summary - Add Tier 1 deterministic article lint for NG words, markdown/caption/image/source/data/numeric checks - Add Tier 2 Codex fact-check wrapper with schema output and mock mode - Add fact-check result merger that preserves Claude-c
- **Source**: PR #260
