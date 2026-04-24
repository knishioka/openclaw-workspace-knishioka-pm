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
- Updated: 2026-03-28
- Collected: 2026-04-24

## Tech Stack

- package.json: present
- Dependencies (sample): @aws-sdk/client-cost-explorer, dotenv, node-cache, openai, zod
- Dev dependencies (sample): @modelcontextprotocol/sdk, @types/jest, @types/node, @typescript-eslint/eslint-plugin, @typescript-eslint/parser, eslint, husky, jest, lint-staged, prettier, ts-jest, tsx
- npm scripts (keys): build, clean, dev, lint, lint:fix, prepare, start, test, test:coverage, test:watch, typecheck
- pyproject.toml: not found
- requirements.txt: not found
- README signal: Cost Management MCP [ ](https://codecov.io/gh/knis

## Architecture / Patterns

- TypeScript MCP server with tool-per-capability surface and schema-validated inputs
- TypeScript tool registration + typed domain model around external APIs
- Domain API adapter + report/analysis tools exposed to LLM clients

## Competitive Landscape (notes)

- No dedicated competitive / trend note recorded this week.

## Tech Decisions (from PRs/commits)

- [2026-03-28] fix(ci): fix schedule workflows (close-stale-dependency-prs / trufflehog) -- - **close-stale-dependency-prs.yml**: Remove duplicate `const core = require('@actions/core')` declaration that caused `SyntaxError: Identifier 'core' has already been declared` — `actions/github-script@v7` already provides `core` in scope - **security.yml (secret-scan)**: Split TruffleHog into two conditional steps —… (source: PR #147)
- [2025-11-04] Upgrade Zod to v4 and update schema handling -- - bump the Zod dependency to v4.1.12 and refresh the lockfile - adjust environment and tool schemas for the Zod v4 API changes - tighten Anthropic usage handling by replacing the loose any cast with typed helpers Testing - npm run lint - npm run typecheck - npm run test ------ https://chatgpt.com/codex/tasks/task_e_690… (source: PR #140)
- [2025-11-03] docs: add AGENTS handbook for repository operations -- - add repository-wide AGENTS guide outlining project overview, setup, operational commands, and governance rules for future agents Testing - not run (documentation only) Checklist - [x] 主要コマンド（build/lint/typecheck/test/e2e）を実リポジトリから検出 - [x] CI必須ステータスと整合 - [x] モノレポは近接優先のAGENTS.mdを配置 - [x] 秘密情報の記載なし - [ ] 手元で smoke 実行 OK… (source: PR #136)
- [2025-11-01] Add protocol-level MCP handler tests -- - add coverage for the MCP ListTools handler to confirm exported metadata is returned - verify CallTool requests invoke registered tool handlers with the provider registry - assert tool failures are converted into structured MCP error payloads Testing - npm test -- --runTestsByPath tests/server.test.ts ------ https://c… (source: PR #135)
- [2025-11-01] Centralize provider definitions and tool routing -- - add a shared SUPPORTED_PROVIDERS constant and reuse it across configuration and provider listing - refactor the MCP server to pull tool metadata and handlers from a dedicated registry - expand provider listing coverage/tests to include Anthropic and validate tool registry output Testing - npm test -- --runInBand ----… (source: PR #134)
- [2025-11-01] Fix TypeScript any usage in caching and analytics utilities -- - add structured cache key typing and key enumeration support to the cache manager - tighten common error, logging, and type definitions to remove `any` usage - update cost analysis tools to rely on typed metadata and provider name resolution instead of casts Testing - npm run lint - npm test -- --watch=false ------ ht… (source: PR #133)
- [2025-11-04] chore(deps): Bump the npm-runtime-deps group with 12 updates -- Bumps the npm-runtime-deps group with 12 updates: Package From To --- --- --- `3.839.0` `3.922.0` `17.0.0` `17.2.3` `1.13.2` `1.20.2` [@types/node](https://github.com/DefinitelyTyped/DefinitelyTyped/tree/HEAD/types/node... (source: PR #132)
- [2025-11-01] Add MCP tool for Anthropic admin key -- Add comprehensive Anthropic Admin API integration for cost and usage tracking: - Implement AnthropicCostClient with Cost Report and Usage Report APIs - Support both actual billing data and token-level usage details - Add prompt caching cost tracking - Include model pricing for Claude 3.5 Sonnet, Haiku, Opus, and legacy… (source: PR #131)
