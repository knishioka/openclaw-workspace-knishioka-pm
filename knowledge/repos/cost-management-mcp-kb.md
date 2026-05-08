# cost-management-mcp Knowledge Base

## Overview

- Repo: knishioka/cost-management-mcp
- Description: A Model Context Protocol (MCP) server for unified cost management across cloud providers and API services
- Primary language (GitHub): TypeScript
- Category / Priority: mcp / medium
- Status: active
- License: MIT
- Default branch: main
- Created: 2025-06-13
- Updated: 2026-05-04
- Collected: 2026-05-08

## Tech Stack

- package.json: present
- Dependencies (sample): @aws-sdk/client-cost-explorer, dotenv, node-cache, openai, zod
- Dev dependencies (sample): @modelcontextprotocol/sdk, @types/jest, @types/node, @typescript-eslint/eslint-plugin, @typescript-eslint/parser, eslint, husky, jest, lint-staged, prettier, ts-jest, tsx
- npm scripts (keys): build, clean, dev, lint, lint:fix, prepare, start, test, test:coverage, test:watch, typecheck
- pyproject.toml: not found
- requirements.txt: not found
- README signal: # Cost Management MCP [![CI](https://github.com/knishioka/cost-management-mcp/actions/workflows/ci.yml/badge.svg)](https://github.com/knishioka/cost-management-mcp/actions/workflows/ci.yml) [![Security Scan](https://github.com/knishioka/cost-management-mcp/actions/workflows/secur

## Architecture / Patterns

- MCP server with tool-per-capability interface and schema-validated inputs
- Upstream API/client layer isolated from MCP presentation surface
- Risk-aware workflow design around external system access, auth, and long-running tasks

## Competitive Landscape (notes)

No competitive research captured yet.

Potential feature candidates for this repo:
- No candidates captured yet.

## Tech Decisions (from PRs/commits)

- [2026-05-04] fix(security): resolve fast-xml-parser audit finding -- @aws-sdk/xml-builder 経由で解決されていた脆弱な fast-xml-parser を npm overrides で安全版へ固定し、Security Scan の npm audit --production 失敗を解消します。AWS SDK 本体の広範な更新は行わず、Node.js >=18 の互換性を維持する最小差分にしています。 (source: PR #150)
- [2026-05-02] chore: adopt knishioka/openclaw-workspace-ds-pm baseline -- First adoption of the cross-repo Claude Code / GitHub baseline maintained at knishioka/openclaw-workspace-ds-pm:templates/repo-baseline. (source: PR #148)
- [2026-03-28] fix(ci): fix schedule workflows (close-stale-dependency-prs / trufflehog) -- ready provides core in scope **security.yml (secret-scan)**: Split TruffleHog into two conditional steps — diff scan for push/PR events (compares base vs HEAD) and full filesystem scan for schedule events (avoids same-commit comparison error) [ ] Trigger `Cl... (source: PR #147)
- [2025-11-04] Upgrade Zod to v4 and update schema handling -- bump the Zod dependency to v4.1.12 and refresh the lockfile adjust environment and tool schemas for the Zod v4 API changes tighten Anthropic usage handling by replacing the loose any cast with typed helpers npm run lint npm run typecheck npm run test ------ ht (source: PR #140)
- [2025-11-03] docs: add AGENTS handbook for repository operations -- add repository-wide AGENTS guide outlining project overview, setup, operational commands, and governance rules for future agents not run (documentation only) [x] 主要コマンド（build/lint/typecheck/test/e2e）を実リポジトリから検出 [x] CI必須ステータスと整合 [x] モノレポは近接優先のAGENTS.mdを配置 [x] 秘 (source: PR #136)
- [2025-11-01] Add protocol-level MCP handler tests -- add coverage for the MCP ListTools handler to confirm exported metadata is returned verify CallTool requests invoke registered tool handlers with the provider registry assert tool failures are converted into structured MCP error payloads npm test -- --runTests (source: PR #135)
- [2025-11-01] Centralize provider definitions and tool routing -- add a shared SUPPORTED_PROVIDERS constant and reuse it across configuration and provider listing refactor the MCP server to pull tool metadata and handlers from a dedicated registry expand provider listing coverage/tests to include Anthropic and validate tool (source: PR #134)
- [2025-11-01] Fix TypeScript any usage in caching and analytics utilities -- add structured cache key typing and key enumeration support to the cache manager tighten common error, logging, and type definitions to remove any usage update cost analysis tools to rely on typed metadata and provider name resolution instead of casts npm run (source: PR #133)
