# ib-sec-mcp Knowledge Base

## Overview
- Repo: knishioka/ib-sec-mcp
- Primary language (GitHub): Python
- License: none
- Default branch: main
- Created: 2025-10-07
- Updated: 2026-06-04
- Collected: 2026-06-05

## Tech Stack
- package.json: not found (or not accessible via GitHub contents API)
- pyproject.toml: present
- requirements.txt: not found

## Architecture / Patterns

- MCP server / tool integration
- Portfolio analytics MCP tools
- Event-driven investment decision support
- Client Portal/Flex position reconciliation

## Tech Decisions (from PRs/commits)

- [2026-06-04] Unify live CP and historical Flex positions via reconciliation view -- Live Client Portal positions and historical Flex snapshots are treated as complementary sources; the repo now exposes a reconciliation view instead of forcing one source of truth. (source: PR #150)
- [2026-06-04] Add position-decision synthesis tool -- Advisor output now combines positions, analytics, sentiment, and upcoming events into an MCP tool for decision support rather than isolated data fetches. (source: PR #149)
- [2026-06-04] Integrate earnings, ex-dividend, and macro event feeds into daily checks -- Upcoming events became a first-class input for daily checks and position decisions, including interest-rate events in `get_upcoming_events`. (source: PR #151/#153)
- [2026-06-04] Add portfolio time-series and benchmark-relative tracking -- Portfolio snapshots now support TWR/cumulative time series and benchmark-relative analysis. (source: PR #148)
- [2026-05-01] feat: add earnings calendar MCP tool -- ## Summary - add `get_earnings_calendar` FastMCP tool backed by yfinance calendar data - load symbols from the latest `PositionStore` snapshot when symbols are omitted - return per-symbol error entries and filter events by `days_ahead` - ad (source: PR #115)
- [2026-04-20] maintenance: FastMCP 3系へ追従し内部API依存テストを解消する -- ## Summary - upgrade the optional `mcp` dependency and lockfile from FastMCP 2.x to FastMCP 3.x - replace MCP tests that depended on `_tool_manager`, `get_tools()`, `get_resources()`, and `get_resource_templates()` with public FastMCP APIs  (source: PR #112)
- [2026-04-11] fix(api): paginate positions and preserve connection errors in CPClient -- Addresses two unresolved review comments from PR #98 (chatgpt-codex-connector): (source: PR #105)
- [2026-03-21] test: add integration test suite for Client Portal API with Paper Trading -- - Add `tests/integration/` with 24 integration tests for the Client Portal API using Paper Trading account - Tests cover connection, live orders, order lifecycle (place/modify/cancel), and DB sync - All tests auto-skip when Gateway is not r (source: PR #102)
- [2026-03-21] feat(orders): add order placement and management via Client Portal API -- Implements order placement, modification, and cancellation via IB Client Portal Gateway API with multiple safety mechanisms (#97). (source: PR #101)
- [2026-03-21] feat(sync): add limit order DB sync with live IB orders via CP API -- - Add `ib_sec_mcp/storage/order_sync.py` with IB → local DB sync logic - Add `sync_limit_orders` MCP tool for manual sync trigger - Matching by `symbol + limit_price + order_type` with IB as source of truth - Graceful handling when Gateway  (source: PR #100)
