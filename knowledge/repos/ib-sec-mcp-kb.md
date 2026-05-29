# ib-sec-mcp Knowledge Base

## Overview

- Repo: knishioka/ib-sec-mcp
- Primary language (GitHub): Python
- License: none
- Default branch: main
- Created: 2025-10-07
- Updated: 2026-05-01
- Collected: 2026-05-29

## Tech Stack

- package.json: not found (or not accessible via GitHub contents API)
- pyproject.toml: present
- requirements.txt: not found

## Architecture / Patterns

- MCP server / tool integration

## Tech Decisions (from PRs/commits)

- [2026-05-01] feat: add earnings calendar MCP tool -- ## Summary - add `get_earnings_calendar` FastMCP tool backed by yfinance calendar data - load symbols from the latest `PositionStore` snapshot when symbols are omitted - return per-symbol error entries and filter events by `days_ahead` - ad (source: PR #115)
- [2026-04-20] maintenance: FastMCP 3系へ追従し内部API依存テストを解消する -- ## Summary - upgrade the optional `mcp` dependency and lockfile from FastMCP 2.x to FastMCP 3.x - replace MCP tests that depended on `_tool_manager`, `get_tools()`, `get_resources()`, and `get_resource_templates()` with public FastMCP APIs  (source: PR #112)
- [2026-04-11] fix(api): paginate positions and preserve connection errors in CPClient -- Addresses two unresolved review comments from PR #98 (chatgpt-codex-connector): (source: PR #105)
- [2026-03-21] test: add integration test suite for Client Portal API with Paper Trading -- - Add `tests/integration/` with 24 integration tests for the Client Portal API using Paper Trading account - Tests cover connection, live orders, order lifecycle (place/modify/cancel), and DB sync - All tests auto-skip when Gateway is not r (source: PR #102)
- [2026-03-21] feat(orders): add order placement and management via Client Portal API -- Implements order placement, modification, and cancellation via IB Client Portal Gateway API with multiple safety mechanisms (#97). (source: PR #101)
- [2026-03-21] feat(sync): add limit order DB sync with live IB orders via CP API -- - Add `ib_sec_mcp/storage/order_sync.py` with IB → local DB sync logic - Add `sync_limit_orders` MCP tool for manual sync trigger - Matching by `symbol + limit_price + order_type` with IB as source of truth - Graceful handling when Gateway  (source: PR #100)
