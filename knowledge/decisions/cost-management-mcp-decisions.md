# cost-management-mcp Design Decisions

## 2026-05-04: resolve fast-xml-parser audit finding

- **What**: resolve fast-xml-parser audit finding
- **Why**: @aws-sdk/xml-builder 経由で解決されていた脆弱な fast-xml-parser を npm overrides で安全版へ固定し、Security Scan の npm audit --production 失敗を解消します。AWS SDK 本体の広範な更新は行わず、Node.js >=18 の互換性を維持する最小差分にしています。
- **Source**: PR #150

## 2026-05-02: adopt knishioka/openclaw-workspace-ds-pm baseline

- **What**: adopt knishioka/openclaw-workspace-ds-pm baseline
- **Why**: First adoption of the cross-repo Claude Code / GitHub baseline maintained at knishioka/openclaw-workspace-ds-pm:templates/repo-baseline.
- **Source**: PR #148

## 2026-03-28: fix schedule workflows (close-stale-dependency-prs / trufflehog)

- **What**: fix schedule workflows (close-stale-dependency-prs / trufflehog)
- **Why**: ready provides core in scope **security.yml (secret-scan)**: Split TruffleHog into two conditional steps — diff scan for push/PR events (compares base vs HEAD) and full filesystem scan for schedule events (avoids same-commit comparison error) [ ] Trigger `Cl...
- **Source**: PR #147

## 2025-11-04: Upgrade Zod to v4 and update schema handling

- **What**: Upgrade Zod to v4 and update schema handling
- **Why**: bump the Zod dependency to v4.1.12 and refresh the lockfile adjust environment and tool schemas for the Zod v4 API changes tighten Anthropic usage handling by replacing the loose any cast with typed helpers npm run lint npm run typecheck npm run test ------ ht
- **Source**: PR #140

## 2025-11-03: add AGENTS handbook for repository operations

- **What**: add AGENTS handbook for repository operations
- **Why**: add repository-wide AGENTS guide outlining project overview, setup, operational commands, and governance rules for future agents not run (documentation only) [x] 主要コマンド（build/lint/typecheck/test/e2e）を実リポジトリから検出 [x] CI必須ステータスと整合 [x] モノレポは近接優先のAGENTS.mdを配置 [x] 秘
- **Source**: PR #136

## 2025-11-01: Add protocol-level MCP handler tests

- **What**: Add protocol-level MCP handler tests
- **Why**: add coverage for the MCP ListTools handler to confirm exported metadata is returned verify CallTool requests invoke registered tool handlers with the provider registry assert tool failures are converted into structured MCP error payloads npm test -- --runTests
- **Source**: PR #135

## 2025-11-01: Centralize provider definitions and tool routing

- **What**: Centralize provider definitions and tool routing
- **Why**: add a shared SUPPORTED_PROVIDERS constant and reuse it across configuration and provider listing refactor the MCP server to pull tool metadata and handlers from a dedicated registry expand provider listing coverage/tests to include Anthropic and validate tool
- **Source**: PR #134

## 2025-11-01: Fix TypeScript any usage in caching and analytics utilities

- **What**: Fix TypeScript any usage in caching and analytics utilities
- **Why**: add structured cache key typing and key enumeration support to the cache manager tighten common error, logging, and type definitions to remove any usage update cost analysis tools to rely on typed metadata and provider name resolution instead of casts npm run
- **Source**: PR #133

## 2025-11-04: Bump the npm-runtime-deps group with 12 updates

- **What**: Bump the npm-runtime-deps group with 12 updates
- **Why**: [dotenv](https://github.com/motdotla/dotenv) | 17.0.0 | 17.2.3 | | [@modelcontextprotocol/sdk](https://github.com/modelcontextprotocol/typescript-sdk) | 1.13.2 | 1.20.2 | | [@types/node](https://github.com/DefinitelyTyped/DefinitelyTyped/tree/HEAD/types/node...
- **Source**: PR #132

## 2025-11-01: Add MCP tool for Anthropic admin key

- **What**: Add MCP tool for Anthropic admin key
- **Why**: pt caching cost tracking Include model pricing for Claude 3.5 Sonnet, Haiku, Opus, and legacy models Add anthropic_costs MCP tool with grouping and optimization tips Update server configuration to include Anthropic provider Add comprehensive tests for Anthro...
- **Source**: PR #131
