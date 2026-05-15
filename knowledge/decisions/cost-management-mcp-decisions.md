# cost-management-mcp Design Decisions

Updated: 2026-05-15

## 2026-05-12: fix(ci): make TruffleHog scan refs robust

- **What**: ## 概要 Security Scan workflow の TruffleHog diff scan が main push で default branch 名と `HEAD` を比較して同一 commit 扱いになり、`BASE and HEAD commits are the same` で失敗する問題を修正しました。push /...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #152

## 2026-05-04: fix(security): resolve fast-xml-parser audit finding

- **What**: ## 概要 `@aws-sdk/xml-builder` 経由で解決されていた脆弱な `fast-xml-parser` を npm `overrides` で安全版へ固定し、Security Scan の `npm audit --production` 失敗を解消します。AWS SDK 本体の広範な更新は行わず、Node.js >=18...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #150

## 2026-05-02: chore: adopt knishioka/openclaw-workspace-ds-pm baseline

- **What**: ## Summary First adoption of the cross-repo Claude Code / GitHub baseline maintained at `knishioka/openclaw-workspace-ds-pm:templates/repo-baseline`. Applied via: \`\`\`sh bash...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #148

## 2026-03-28: fix(ci): fix schedule workflows (close-stale-dependency-prs / trufflehog)

- **What**: ## Summary - **close-stale-dependency-prs.yml**: Remove duplicate `const core = require('@actions/core')` declaration that caused `SyntaxError: Identifier 'core' has already...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #147

## 2025-11-04: Upgrade Zod to v4 and update schema handling

- **What**: ## Summary - bump the Zod dependency to v4.1.12 and refresh the lockfile - adjust environment and tool schemas for the Zod v4 API changes - tighten Anthropic usage handling by...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #140

## 2025-11-03: docs: add AGENTS handbook for repository operations

- **What**: ## Summary - add repository-wide AGENTS guide outlining project overview, setup, operational commands, and governance rules for future agents ## Testing - not run (documentation...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #136

## 2025-11-01: Add protocol-level MCP handler tests

- **What**: ## Summary - add coverage for the MCP ListTools handler to confirm exported metadata is returned - verify CallTool requests invoke registered tool handlers with the provider...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #135

## 2025-11-01: Centralize provider definitions and tool routing

- **What**: ## Summary - add a shared SUPPORTED_PROVIDERS constant and reuse it across configuration and provider listing - refactor the MCP server to pull tool metadata and handlers from a...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #134

## 2025-11-01: Fix TypeScript any usage in caching and analytics utilities

- **What**: ## Summary - add structured cache key typing and key enumeration support to the cache manager - tighten common error, logging, and type definitions to remove `any` usage -...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #133

## 2025-11-04: chore(deps): Bump the npm-runtime-deps group with 12 updates

- **What**: Bumps the npm-runtime-deps group with 12 updates: | Package | From | To | | --- | --- | --- | | [@aws-sdk/client-cost-explorer](https://github.com/aws/aws-sdk-...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #132
