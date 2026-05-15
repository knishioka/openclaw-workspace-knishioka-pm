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
- Collected: 2026-05-15

## Tech Stack

- Runtime dependencies: none detected
- pyproject.toml: present
- requirements.txt: present
- README signal: # Treasure Data MCP Server A Model Context Protocol (MCP) server that provides Treasure Data API integration for Claude Code and Claude Desktop. > **DISCLAIMER**: This is a personal development project and is not...

## Architecture / Patterns

- MCP server surface should keep tool schemas explicit and API errors predictable for agent callers.
- Auth/token handling and API quota/error translation are core architecture risks.

## Competitive Landscape (notes)

No competitive research captured in this weekly rotation.

## Tech Decisions (from recent PRs/commits)

- [2025-08-03] Fix test expectations for new tool count (source: commit 208b033)
- [2025-08-03] Improve MCP tool descriptions for better AI comprehension (source: commit 14c52b4)
- [2025-08-03] Improve workflow retrieval to handle large IDs (source: commit f8c726f)
- [2025-08-02] Fix test expectations for new tool count (source: commit 5a2394b)
- [2025-08-02] Temporarily disable mypy in CI to unblock development (source: commit c8063cb)
