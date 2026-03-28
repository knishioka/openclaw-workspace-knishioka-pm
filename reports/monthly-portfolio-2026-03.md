# Monthly Portfolio Review (2026-03)

As of: 2026-03-28

## Summary

- Portfolio size (tracked): **Public 10 / Private 5**
- Activity (30/90 day rule):
  - **Active (≤30d): 10** (public 6 / private 4)
  - **Dormant (31–90d): 4** (public 2 / private 1)
  - **Abandoned (90d+): 3** (public 3 / private 0)
- Note: `status: on-hold` repos are intentionally **omitted** from this report (per policy).

## 1) Last month health trend (monitoring/health-trend.jsonl)

Data availability: **2 days only** (2026-03-27, 2026-03-28). So “past 1 month trend” is not statistically meaningful yet.

Observed change (within available window):
- `knishioka/cost-management-mcp`: days_inactive **143 → 0** (new push on 2026-03-28)
- Overall health snapshot stayed: **GREEN 3 / YELLOW 2 / RED 5** (both days)

Hotspots (from latest snapshot 2026-03-28):
- `freee-mcp`: **open PRs 15** (review load risk)
- `simple-bookkeeping`: **open issues 36, open PRs 8** (backlog pressure)
- `ib-sec-mcp`: CI failure + **open PRs 4** (merge queue risk)

## 2) Activity classification (commit recency)

### Public repos

**Active (≤30d)**
- knishioka/kanji-practice (last push 2026-03-22)
- knishioka/math-worksheet (last push 2026-03-22)
- knishioka/ib-sec-mcp (last push 2026-03-21)
- knishioka/freee-mcp (last push 2026-03-06)
- knishioka/cost-management-mcp (last push 2026-03-28)

**Dormant (31–90d)**
- knishioka/simple-bookkeeping (last push 2026-01-25)
- knishioka/english-note-maker (last push 2026-01-01)

**Abandoned (90d+)**
- knishioka/td-mcp-server (last push 2025-08-03)
- knishioka/meditation-chrome-extension (last push 2025-06-30)
- knishioka/remotion-math-education (last push 2025-06-17)

### Private repos (no details)

**Active (≤30d)**
- knishioka/market-lens-studio
- knishioka/workflow-engine
- knishioka/household-finance
- knishioka/ut-gymnastics

**Dormant (31–90d)**
- knishioka/jgrants-app

**Abandoned (90d+)**
- (none)

## 3) Cross-repo analysis (from knowledge/repos/*.md)

### Common technology clusters

1) **MCP servers** (`ib-sec-mcp`, `freee-mcp`, `cost-management-mcp`, `td-mcp-server`)
- Repeated patterns:
  - Tool registration + metadata + handler routing
  - Runtime schema validation (TS: Zod)
  - External API pagination / rate limits / error normalization
  - Testing split: unit vs integration (IB has rich integration test suite)
- Integration opportunity (high ROI):
  - Create a small shared “**mcp-server-kit**” template/package (even as a copy/paste repo first) covering:
    - typed tool registry + common error envelope
    - standardized auth/env loading
    - pagination helpers + retry/backoff
    - common CI (lint/typecheck/test, gitleaks, release tagging)

2) **Printable education web apps** (`kanji-practice`, `math-worksheet`, `english-note-maker`)
- Repeated patterns:
  - A4 print/PDF layout correctness is the main quality bar
  - Playwright-based layout checks appear as a recurring solution
- Integration opportunity:
  - Shared “**print-layout-check**” approach: a reusable Playwright harness + layout heuristics (overflow detection, A4 bounds) that can be imported across repos.

### “Overwork” candidates (maintenance load)

- `freee-mcp`: PR backlog suggests review/merge throughput is a bottleneck.
- `simple-bookkeeping`: large open-issue backlog likely needs triage more than new features.
- `ib-sec-mcp`: recent feature velocity + CI failure risk → prioritize CI stabilization + merge queue hygiene.

## 4) Abandoned repos: archive recommendation / revival conditions

### Recommend Archive (unless a clear near-term user need exists)

- `knishioka/remotion-math-education`
  - Rationale: initial commit-only level of maturity; no recent activity.
  - Revival condition: a concrete content pipeline + target output (e.g., “2-digit subtraction video series”) + automation plan.

- `knishioka/meditation-chrome-extension`
  - Rationale: long inactivity; Chrome extension maintenance cost (manifest/API changes) tends to drift.
  - Revival condition: decide distribution goal (Chrome Web Store vs personal use), then do a “release hardening” pass (manifest compatibility + build/test + minimal CI).

### Candidate for Archive OR “minimal refresh” revival

- `knishioka/td-mcp-server`
  - Rationale: MCP server pattern matches current active investments, but has been idle since 2025-08.
  - Revival condition: confirm Treasure Data integration is still needed; if yes, do a minimal refresh:
    - dependency/security update
    - re-enable typing checks (mypy policy) + a smoke integration test

---

Created by: knishioka-pm (automated)
