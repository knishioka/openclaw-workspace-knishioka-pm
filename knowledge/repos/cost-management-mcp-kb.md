# cost-management-mcp Knowledge Base

## Overview

- Repo: knishioka/cost-management-mcp
- Description: A Model Context Protocol (MCP) server for unified cost management across cloud providers and API services
- Primary language (GitHub): TypeScript
- License: MIT
- Default branch: main
- Created: 2025-06-13
- Updated: 2025-11-04
- Collected: 2026-03-27

## Tech Stack

- package.json: present
- Dependencies (sample): @aws-sdk/client-cost-explorer, dotenv, node-cache, openai, zod
- Dev dependencies (sample): @modelcontextprotocol/sdk, @types/jest, @types/node, @typescript-eslint/eslint-plugin, @typescript-eslint/parser, eslint, husky, jest, lint-staged, prettier, ts-jest, tsx
- npm scripts (keys): build, clean, dev, lint, lint:fix, prepare, start, test, test:coverage, test:watch, typecheck
- pyproject.toml: not found
- requirements.txt: not found

## Architecture / Patterns

- MCP server / tool integration
- Runtime schema validation

## Tech Decisions (from PRs/commits)

- [2026-03-28] fix(ci): fix schedule workflows (close-stale-dependency-prs / trufflehog) -- Fix scheduled GitHub Actions failures (duplicate `core` declaration in github-script; TruffleHog schedule scan mode). (source: PR #147)
- [2025-11-04] Upgrade Zod to v4 and update schema handling -- ## Summary - bump the Zod dependency to v4.1.12 and refresh the lockfile - adjust environment and tool schemas for the Zod v4 API changes - tighten Anthropic usage handling by replacing the loose any cast with typed helpers (source: PR #140)
- [2025-11-03] docs: add AGENTS handbook for repository operations -- ## Summary - add repository-wide AGENTS guide outlining project overview, setup, operational commands, and governance rules for future agents (source: PR #136)
- [2025-11-01] Add protocol-level MCP handler tests -- ## Summary - add coverage for the MCP ListTools handler to confirm exported metadata is returned - verify CallTool requests invoke registered tool handlers with the provider registry - assert tool failures are converted into structured MCP  (source: PR #135)
- [2025-11-01] Centralize provider definitions and tool routing -- ## Summary - add a shared SUPPORTED_PROVIDERS constant and reuse it across configuration and provider listing - refactor the MCP server to pull tool metadata and handlers from a dedicated registry - expand provider listing coverage/tests to (source: PR #134)
- [2025-11-01] Fix TypeScript any usage in caching and analytics utilities -- ## Summary - add structured cache key typing and key enumeration support to the cache manager - tighten common error, logging, and type definitions to remove `any` usage - update cost analysis tools to rely on typed metadata and provider na (source: PR #133)
- [2025-11-01] Add MCP tool for Anthropic admin key -- Add comprehensive Anthropic Admin API integration for cost and usage tracking: (source: PR #131)
