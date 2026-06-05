# market-lens-studio Knowledge Base

## Overview
- Repo: knishioka/market-lens-studio
- Primary language (GitHub): Python
- License: none
- Default branch: main
- Created: 2025-11-14
- Updated: 2026-06-04
- Collected: 2026-06-05

## Tech Stack
- package.json: not found (or not accessible via GitHub contents API)
- pyproject.toml: present
- requirements.txt: present

## Architecture / Patterns

- (No clear patterns inferred from README/dependencies in this snapshot)
- Headless publishing hardening
- Duplicate-post prevention

## Tech Decisions (from PRs/commits)

- [2026-06-04] Deny ScheduleWakeup during headless note runs -- Morning automation now blocks wakeup scheduling so headless runs cannot silently end before publishing. (source: PR #279)
- [2026-05-30] Bound morning suggest with a hard wall-clock timeout -- Automation now fails boundedly instead of hanging or drifting beyond its publishing window. (source: PR #275)
- [2026-05-30] Prevent duplicate posts and surface the real failure reason -- CI/write-article handling now favors idempotency and diagnosable failures over retrying into duplicate publication. (source: PR #277)
- [2026-05-29] fix(note): enforce suggest --auto mandate compliance and headless safety -- 2026-05-29 朝の自動運用（launchd → `claude -p "/note:suggest --auto"`）が**記事を公開せず停止**した。エラーではなく、ワークフロー設計の穴2点の合わせ技： (source: PR #273)
- [2026-05-28] fix(automation): detect summary table success logs -- ## Summary - Expand notify_workflow_failure.sh phase-row detection to handle new markdown summary rows like `| 5. Publishing |`. - Treat `Workflow Complete`, `Published Article: https://note.com/`, `Draft -> Notion synced`, and `public publ (source: PR #270)
- [2026-05-27] feat(automation): add morning launchd status dashboard -- ## Summary - Add purpose headers to the three launchd plist templates for Layer 1 / 1.5 / 1.7. - Enhance `scripts/dev/list_morning_jobs.sh` with fixed layer names, schedules, launchd state, last exit code, and purpose text. - Add `scripts/d (source: PR #268)
- [2026-05-27] fix: accept new codex auth doctor output -- ## Summary - update setup_codex_fallback.sh auth check to accept legacy `auth: OK`, new `auth is configured`, and `stored auth mode` outputs - add mocked setup tests for authenticated and logged-out Codex doctor scenarios - refresh automati (source: PR #265)
- [2026-05-27] feat(automation): add Codex fallback Wave D orchestrator -- ## Summary - add shared morning lock helpers and wire Layer 1 / Layer 1.5 scripts through them - add shared Slack notifier with same-day layer/type dedup plus Wave D payload templates - add publish retry policy, phase runner, idempotency ch (source: PR #261)
- [2026-05-27] feat(quality): add Codex fact-check quality gates -- ## Summary - Add Tier 1 deterministic article lint for NG words, markdown/caption/image/source/data/numeric checks - Add Tier 2 Codex fact-check wrapper with schema output and mock mode - Add fact-check result merger that preserves Claude-c (source: PR #260)

## Competitive Landscape

- [2026-05-29] AI market-research tools are shifting toward continuous intelligence: always-on source monitoring, signal surfacing, and cited synthesis rather than one-off report generation. Feature candidates: watchlist-based daily signal digest, source freshness score, and persisted evidence packs for each generated note article. Sources: ToolRadar 2026 guide (updated 2026-05), Sushidata 2026 AI market research review (2026-04).
- [2026-05-29] Financial research competition is moving down-market: Google expanded AI-powered Google Finance to 100+ countries on 2026-04-08, with natural-language market questions and AI research. Differentiation should emphasize Japan-market workflow depth, note/X publishing automation, audit trail, and deterministic quality gates rather than generic stock Q&A. Source: Google Product Blog (2026-04-08).
- [2026-05-29] Agentic finance research highlights governance risks: autonomous financial agents need interpretability, supervisory observability, and human override because market actions can amplify systemic and compliance risk. Feature candidates: run-level trace viewer, "why this claim" citations, and human approval gates for publication after high-impact claims. Sources: arXiv Agentic AI in Finance survey (2026-04-23), TechRadar agent-security report (2026-05-25).
