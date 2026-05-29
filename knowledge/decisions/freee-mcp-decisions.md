# freee-mcp Design Decisions

## 2026-05-05: test: migrate Jest suite to Vitest

- **What**: test: migrate Jest suite to Vitest
- **Why**: Jest + ts-jest のテスト実行環境を Vitest 3 に移行し、ESM/TypeScript 向けの設定を簡素化しました。既存テストの振る舞いは維持しつつ、テストスクリプトとカバレッジ生成を Vitest ベースに更新しています。 
- **Source**: PR #180

## 2026-04-29: feat(kpi): add structured dashboard output

- **What**: feat(kpi): add structured dashboard output
- **Why**: ## Summary - Upgrade @modelcontextprotocol/sdk to ^1.29.0. - Return structuredContent from freee_kpi_dashboard with company_id, period, and profitability / safety / efficiency / liquidity KPI sections while preserving the existing JSON text 
- **Source**: PR #178

## 2026-04-16: refactor(schema): migrate tool registration to Zod 4

- **What**: refactor(schema): migrate tool registration to Zod 4
- **Why**: ## Summary - upgrade `zod` from `^3.25.28` to `^4.3.6` and refresh the lockfile - replace the `any`-based `registerTool` shim with a typed generic wrapper while keeping tool names and input argument names unchanged - update focused regressi 
- **Source**: PR #176

## 2026-03-31: fix(security): pin axios to 1.14.0 to avoid compromised 1.14.1

- **What**: fix(security): pin axios to 1.14.0 to avoid compromised 1.14.1
- **Why**: - **axios 1.14.1** was published as a malicious version containing a remote access trojan (RAT) via the `plain-crypto-js` dependency ([StepSecurity advisory](https://www.stepsecurity.io/blog/axios-compromised-on-npm-malicious-versions-drop- 
- **Source**: PR #173

## 2026-03-06: feat(analysis): add freee_partner_analysis tool

- **What**: feat(analysis): add freee_partner_analysis tool
- **Why**: - Add `freee_partner_analysis` MCP tool for partner-level revenue/expense analysis with concentration risk assessment - Aggregates deals by partner using auto-pagination, computes top N rankings with share %, monthly breakdown, and concentr 
- **Source**: PR #172

## 2026-03-06: feat(tools): add freee_kpi_dashboard tool

- **What**: feat(tools): add freee_kpi_dashboard tool
- **Why**: ## Summary - Add `freee_kpi_dashboard` MCP tool that aggregates KPI data from PL, BS, and walletables in a single call - Computes profitability (operating/ordinary profit margins), safety (current/equity ratios), efficiency (receivable/paya 
- **Source**: PR #171
