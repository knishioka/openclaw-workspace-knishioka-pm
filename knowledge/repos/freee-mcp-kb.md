# freee-mcp Knowledge Base

## Overview

- Repo: knishioka/freee-mcp
- Description: MCP server for freee accounting API integration
- Primary language (GitHub): TypeScript
- License: MIT
- Default branch: main
- Created: 2025-05-26
- Updated: 2026-05-06
- Collected: 2026-06-05

## Tech Stack

- package.json: present
- Dependencies (sample): @modelcontextprotocol/sdk, axios, debug, dotenv, zod
- Dev dependencies (sample): @types/debug, @types/node, @typescript-eslint/eslint-plugin, @typescript-eslint/parser, @vitest/coverage-v8, eslint, husky, lint-staged, tsx, typescript, vitest
- npm scripts (keys): build, dev, gitleaks, gitleaks:ci, lint, prepare, setup-auth, start, test, test:coverage, typecheck
- pyproject.toml: not found
- requirements.txt: not found

## Architecture / Patterns

- MCP server / tool integration
- Runtime schema validation
- CLI-style usage

## Tech Decisions (from PRs/commits)

- [2026-05-05] test: migrate Jest suite to Vitest -- Jest + ts-jest のテスト実行環境を Vitest 3 に移行し、ESM/TypeScript 向けの設定を簡素化しました。既存テストの振る舞いは維持しつつ、テストスクリプトとカバレッジ生成を Vitest ベースに更新しています。 (source: PR #180)
- [2026-04-29] feat(kpi): add structured dashboard output -- ## Summary - Upgrade @modelcontextprotocol/sdk to ^1.29.0. - Return structuredContent from freee_kpi_dashboard with company_id, period, and profitability / safety / efficiency / liquidity KPI sections while preserving the existing JSON text (source: PR #178)
- [2026-04-16] refactor(schema): migrate tool registration to Zod 4 -- ## Summary - upgrade `zod` from `^3.25.28` to `^4.3.6` and refresh the lockfile - replace the `any`-based `registerTool` shim with a typed generic wrapper while keeping tool names and input argument names unchanged - update focused regressi (source: PR #176)
- [2026-03-31] fix(security): pin axios to 1.14.0 to avoid compromised 1.14.1 -- - **axios 1.14.1** was published as a malicious version containing a remote access trojan (RAT) via the `plain-crypto-js` dependency ([StepSecurity advisory](https://www.stepsecurity.io/blog/axios-compromised-on-npm-malicious-versions-drop- (source: PR #173)
- [2026-03-06] feat(analysis): add freee_partner_analysis tool -- - Add `freee_partner_analysis` MCP tool for partner-level revenue/expense analysis with concentration risk assessment - Aggregates deals by partner using auto-pagination, computes top N rankings with share %, monthly breakdown, and concentr (source: PR #172)
- [2026-03-06] feat(tools): add freee_kpi_dashboard tool -- ## Summary - Add `freee_kpi_dashboard` MCP tool that aggregates KPI data from PL, BS, and walletables in a single call - Computes profitability (operating/ordinary profit margins), safety (current/equity ratios), efficiency (receivable/paya (source: PR #171)

## Competitive Landscape

- [2026-06-05] Official MCP TypeScript SDK remains v1.29.0 for production while v2 is pre-alpha; stable v2 is targeted for Q3 2026 with updated spec work around July 28, 2026. Feature candidate: keep production on v1.x, add compatibility watch/tests for v2 before migration. Source date: 2026-06-05 observed; source: https://github.com/modelcontextprotocol/typescript-sdk
- [2026-06-05] freee now offers an official hosted remote freee-mcp endpoint with OSS-equivalent coverage across accounting, HR, invoices, time tracking, and sales, covering about 270 operations. Feature candidate: differentiate Ken fork through opinionated accounting analysis, local dry-run/audit mode, and safer write confirmations rather than raw endpoint coverage. Source date: 2026-03-27; source: https://corp.freee.co.jp/news/20260327freee_mcp.html
- [2026-06-05] freee Developers lists recent API surface changes: accounting API changes on 2026-05-22/05-20, invoice data from sales on 2026-05-21, time tracking edit/delete on 2026-06-01, and sales estimate/cost-budget APIs on 2026-05-28/05-29. Feature candidate: add release-note watch and schema-drift tests for high-use endpoints. Source date: 2026-06-05 release notes page; source: https://developer.freee.co.jp/info
