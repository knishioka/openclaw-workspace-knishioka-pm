# ib-sec-mcp Knowledge Base

## Overview

- Repo: knishioka/ib-sec-mcp
- Primary language (GitHub): Python
- License: none
- Default branch: main
- Created: 2025-10-07
- Updated: 2026-05-01
- Collected: 2026-05-22

## Tech Stack

- package.json: not found (or not accessible via GitHub contents API)
- pyproject.toml: present
- requirements.txt: not found

## Architecture / Patterns

- MCP server / tool integration

## Tech Decisions (from PRs/commits)

- [2026-03-11] docs: add testing rules and update MCP tool guidelines -- ## Summary - **NEW** `.claude/rules/testing.md` (95行): MCP toolテストパターン、mockストラテジー、必須テストチェックリスト、抽出可能性ルール（Wave 14の`check_order_proximity`バグの再発防止） - **UPDATE** `.claude/rules/mcp-tools.md` (100行): External Dependency Pattern追加、Testing Requirem (source: PR #91)
- [2026-03-11] test: add MCP tool-level tests for limit order tools -- - Add 28 functional tests in `tests/mcp/test_limit_orders.py` covering all 5 limit order MCP tools - Fix symbol resolution bug in `check_order_proximity`: add market suffix mapping (LSE→`.L`, TSE→`.T`) for correct yfinance ticker lookup (source: PR #90)
- [2026-03-11] fix: resolve non-US symbols for Yahoo Finance in check_order_proximity -- - Add `MARKET_YAHOO_SUFFIX` mapping dict to translate IB market identifiers (LSE, TSE, HKG, SGX, ASX, FRA) to Yahoo Finance exchange suffixes (.L, .T, .HK, .SI, .AX, .F) - Guard against double-appending for symbols that already contain the  (source: PR #89)
- [2026-03-10] fix: add daily monitor tools to test_server expected tools set -- ## Summary - Add `sync_daily_snapshot` and `get_sync_status` to `EXPECTED_TOOLS` in `test_server.py` - These tools were added in PR #81 but the test was not updated (source: PR #85)
- [2026-03-10] feat: add /daily-check command with memory file auto-update rules -- - Create `/daily-check` slash command (`.claude/commands/daily-check.md`) with complete 8-step workflow for daily portfolio monitoring - Define auto-update rules for 5 memory files: OVERWRITE (snapshot), CONDITIONAL (strategy), APPEND (deci (source: PR #83)
- [2026-03-10] feat: add /daily-check slash command for scheduled monitoring -- - Create `/daily-check` slash command for automated daily portfolio monitoring - Designed for Claude Desktop scheduled tasks (no user interaction required) - Completes in under 3 minutes with parallel price fetching (source: PR #82)

## Competitive Landscape

- [2026-05-22] MCP servers should treat Streamable HTTP as the remote-server baseline: the 2025-06-18 spec lists stdio and Streamable HTTP as standard transports, notes Streamable HTTP replaces HTTP+SSE, and calls out Origin validation, localhost binding for local servers, and authentication requirements. Feature candidate: add a remote transport/security readiness checklist before exposing `ib-sec-mcp` outside local stdio. Sources: modelcontextprotocol.io spec 2025-06-18; fetched 2026-05-22.
- [2026-05-22] Python MCP SDK v1.27.x release notes emphasize OAuth client fixes, StreamableHTTP idle timeout, conformance tests, and a v2 branch strategy with v1.x maintenance. Feature candidate: pin/track `mcp>=1.27,<2`, add OAuth/resource-validation regression tests, and watch v2 migration timing. Source: modelcontextprotocol/python-sdk releases; fetched 2026-05-22.
