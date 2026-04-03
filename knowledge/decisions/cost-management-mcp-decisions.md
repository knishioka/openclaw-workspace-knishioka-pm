# cost-management-mcp Design Decisions

## 2026-03-28: fix(ci): fix schedule workflows (close-stale-dependency-prs / trufflehog)

- **What**: Repair scheduled GitHub Actions workflows for stale-dependency PR closing and secret scanning.
- **Why**: Prevent schedule-only CI failures (github-script already provides `core`; TruffleHog schedule needs full filesystem scan rather than diff scan).
- **Source**: PR #147

## 2025-11-04: Upgrade Zod to v4 and update schema handling

- **What**: Upgrade Zod to v4 and update schema handling
- **Why**: ## Summary - bump the Zod dependency to v4.1.12 and refresh the lockfile - adjust environment and tool schemas for the Zod v4 API changes - tighten Anthropic usage handling by replacing the loose any cast with typed helpers 
- **Source**: PR #140

## 2025-11-03: docs: add AGENTS handbook for repository operations

- **What**: docs: add AGENTS handbook for repository operations
- **Why**: ## Summary - add repository-wide AGENTS guide outlining project overview, setup, operational commands, and governance rules for future agents 
- **Source**: PR #136

## 2025-11-01: Add protocol-level MCP handler tests

- **What**: Add protocol-level MCP handler tests
- **Why**: ## Summary - add coverage for the MCP ListTools handler to confirm exported metadata is returned - verify CallTool requests invoke registered tool handlers with the provider registry - assert tool failures are converted into structured MCP  
- **Source**: PR #135

## 2025-11-01: Centralize provider definitions and tool routing

- **What**: Centralize provider definitions and tool routing
- **Why**: ## Summary - add a shared SUPPORTED_PROVIDERS constant and reuse it across configuration and provider listing - refactor the MCP server to pull tool metadata and handlers from a dedicated registry - expand provider listing coverage/tests to 
- **Source**: PR #134

## 2025-11-01: Fix TypeScript any usage in caching and analytics utilities

- **What**: Fix TypeScript any usage in caching and analytics utilities
- **Why**: ## Summary - add structured cache key typing and key enumeration support to the cache manager - tighten common error, logging, and type definitions to remove `any` usage - update cost analysis tools to rely on typed metadata and provider na 
- **Source**: PR #133

## 2025-11-01: Add MCP tool for Anthropic admin key

- **What**: Add MCP tool for Anthropic admin key
- **Why**: Add comprehensive Anthropic Admin API integration for cost and usage tracking: 
- **Source**: PR #131
