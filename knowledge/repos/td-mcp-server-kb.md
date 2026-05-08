# td-mcp-server Knowledge Base

## Overview

- Repo: knishioka/td-mcp-server
- Description: Treasure Data MCP server -- inactive since 2025-08
- Primary language (GitHub): Python
- Category / Priority: mcp / low
- Status: abandoned
- License: none
- Default branch: main
- Created: 2025-05-13
- Updated: 2025-08-03
- Collected: 2026-05-08

## Tech Stack

- package.json: not found (or not accessible via GitHub contents API)
- Dependencies (sample): not found
- Dev dependencies (sample): not found
- npm scripts (keys): not found
- pyproject.toml: present
- requirements.txt: present
- README signal: # Treasure Data MCP Server A Model Context Protocol (MCP) server that provides Treasure Data API integration for Claude Code and Claude Desktop. > **DISCLAIMER**: This is a personal development project and is not affiliated with, endorsed by, or related to Treasure Data Inc. in a

## Architecture / Patterns

- MCP server with tool-per-capability interface and schema-validated inputs
- Upstream API/client layer isolated from MCP presentation surface
- Risk-aware workflow design around external system access, auth, and long-running tasks

## Competitive Landscape (notes)

No competitive research captured yet.

Potential feature candidates for this repo:
- No candidates captured yet.

## Tech Decisions (from PRs/commits)

- [2025-08-03] Fix test expectations for new tool count (source: commit 208b033)
- [2025-08-03] Improve MCP tool descriptions for better AI comprehension (source: commit 14c52b4)
- [2025-08-03] Improve workflow retrieval to handle large IDs (source: commit f8c726f)
- [2025-08-02] Fix test expectations for new tool count (source: commit 5a2394b)
- [2025-08-02] Temporarily disable mypy in CI to unblock development (source: commit c8063cb)
- [2025-08-02] Add mypy configuration and fix major type errors (source: commit 4fb9db6)
- [2025-08-01] Use pre-commit in CI for consistent linting (source: commit 0572edd)
- [2025-08-01] Fix all lint errors and ensure code quality compliance (source: commit 737d115)
