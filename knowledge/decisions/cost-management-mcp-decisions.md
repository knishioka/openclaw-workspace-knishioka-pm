# cost-management-mcp Design Decisions

## 2026-03-28: fix(ci): fix schedule workflows (close-stale-dependency-prs / trufflehog)

- **What**: fix(ci): fix schedule workflows (close-stale-dependency-prs / trufflehog)
- **Why**: ## Summary - **close-stale-dependency-prs.yml**: Remove duplicate `const core = require('@actions/core')` declaration that caused `SyntaxError: Identifier 'core' has already been declared` — `actions/github-script@v7` already provides `core` in scope - **security.yml (secret-scan)**: Split TruffleHog into two conditional steps — diff scan for push/PR events (compares base vs HEAD) and full filesystem scan for schedu…
- **Source**: PR #147

## 2025-11-04: Upgrade Zod to v4 and update schema handling

- **What**: Upgrade Zod to v4 and update schema handling
- **Why**: ## Summary - bump the Zod dependency to v4.1.12 and refresh the lockfile - adjust environment and tool schemas for the Zod v4 API changes - tighten Anthropic usage handling by replacing the loose any cast with typed helpers ## Testing - npm run lint - npm run typecheck - npm run test ------ https://chatgpt.com/codex/tasks/task_e_690944bff7608326bf0c3bfdaba7b854
- **Source**: PR #140

## 2025-11-03: docs: add AGENTS handbook for repository operations

- **What**: docs: add AGENTS handbook for repository operations
- **Why**: ## Summary - add repository-wide AGENTS guide outlining project overview, setup, operational commands, and governance rules for future agents ## Testing - not run (documentation only) ## Checklist - [x] 主要コマンド（build/lint/typecheck/test/e2e）を実リポジトリから検出 - [x] CI必須ステータスと整合 - [x] モノレポは近接優先のAGENTS.mdを配置 - [x] 秘密情報の記載なし - [ ] 手元で smoke 実行 OK（可能な範囲） ------ https://chatgpt.com/codex/tasks/task_e_690886dfef8c8326987200c2e931…
- **Source**: PR #136

## 2025-11-01: Add protocol-level MCP handler tests

- **What**: Add protocol-level MCP handler tests
- **Why**: ## Summary - add coverage for the MCP ListTools handler to confirm exported metadata is returned - verify CallTool requests invoke registered tool handlers with the provider registry - assert tool failures are converted into structured MCP error payloads ## Testing - npm test -- --runTestsByPath tests/server.test.ts ------ https://chatgpt.com/codex/tasks/task_e_6906848b7de08326aec2108ad3be13c3
- **Source**: PR #135

## 2025-11-01: Centralize provider definitions and tool routing

- **What**: Centralize provider definitions and tool routing
- **Why**: ## Summary - add a shared SUPPORTED_PROVIDERS constant and reuse it across configuration and provider listing - refactor the MCP server to pull tool metadata and handlers from a dedicated registry - expand provider listing coverage/tests to include Anthropic and validate tool registry output ## Testing - npm test -- --runInBand ------ https://chatgpt.com/codex/tasks/task_e_690616773f388326bd04cb30cd5618e4
- **Source**: PR #134

## 2025-11-01: Fix TypeScript any usage in caching and analytics utilities

- **What**: Fix TypeScript any usage in caching and analytics utilities
- **Why**: ## Summary - add structured cache key typing and key enumeration support to the cache manager - tighten common error, logging, and type definitions to remove `any` usage - update cost analysis tools to rely on typed metadata and provider name resolution instead of casts ## Testing - npm run lint - npm test -- --watch=false ------ https://chatgpt.com/codex/tasks/task_e_69060fefb9908326bc31a1aaeea264bb
- **Source**: PR #133

## 2025-11-04: chore(deps): Bump the npm-runtime-deps group with 12 updates

- **What**: chore(deps): Bump the npm-runtime-deps group with 12 updates
- **Why**: Bumps the npm-runtime-deps group with 12 updates: | Package | From | To | | --- | --- | --- | | [@aws-sdk/client-cost-explorer](https://github.com/aws/aws-sdk-js-v3/tree/HEAD/clients/client-cost-explorer) | `3.839.0` | `3.922.0` | | [dotenv](https://github.com/motdotla/dotenv) | `17.0.0` | `17.2.3` | | [@modelcontextprotocol/sdk](https://github.com/modelcontextprotocol/typescript-sdk) | `1.13.2` | `1.20.2` | | [@typ…
- **Source**: PR #132

## 2025-11-01: Add MCP tool for Anthropic admin key

- **What**: Add MCP tool for Anthropic admin key
- **Why**: Add comprehensive Anthropic Admin API integration for cost and usage tracking: - Implement AnthropicCostClient with Cost Report and Usage Report APIs - Support both actual billing data and token-level usage details - Add prompt caching cost tracking - Include model pricing for Claude 3.5 Sonnet, Haiku, Opus, and legacy models - Add anthropic_costs MCP tool with grouping and optimization tips - Update server configur…
- **Source**: PR #131
