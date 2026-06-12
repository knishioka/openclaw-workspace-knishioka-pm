# cost-management-mcp Knowledge Base

## Overview

- Repo: knishioka/cost-management-mcp
- Description: A Model Context Protocol (MCP) server for unified cost management across cloud providers and API services
- Primary language (GitHub): TypeScript
- License: MIT
- Default branch: main
- Created: 2025-06-13
- Updated: 2026-05-23
- Collected: 2026-06-12

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

- [2025-11-01] Add MCP tool for Anthropic admin key -- Add comprehensive Anthropic Admin API integration for cost and usage tracking: (source: PR #131)
- [2025-11-01] Auto-close stale dependency PRs -- ## Summary - add a scheduled workflow that closes dependency pull requests that have been inactive for three weeks - leave a comment explaining the closure so maintainers can reopen when needed (source: PR #130)
