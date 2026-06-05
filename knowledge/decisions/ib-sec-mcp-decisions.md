# ib-sec-mcp Design Decisions

## 2026-06-04: Unify live CP and historical Flex positions via reconciliation view

- **What**: Unify live CP and historical Flex positions via reconciliation view
- **Why**: Live Client Portal positions and historical Flex snapshots are treated as complementary sources; the repo now exposes a reconciliation view instead of forcing one source of truth.
- **Source**: PR #150

## 2026-06-04: Add position-decision synthesis tool

- **What**: Add position-decision synthesis tool
- **Why**: Advisor output now combines positions, analytics, sentiment, and upcoming events into an MCP tool for decision support rather than isolated data fetches.
- **Source**: PR #149

## 2026-06-04: Integrate earnings, ex-dividend, and macro event feeds into daily checks

- **What**: Integrate earnings, ex-dividend, and macro event feeds into daily checks
- **Why**: Upcoming events became a first-class input for daily checks and position decisions, including interest-rate events in `get_upcoming_events`.
- **Source**: PR #151/#153

## 2026-06-04: Add portfolio time-series and benchmark-relative tracking

- **What**: Add portfolio time-series and benchmark-relative tracking
- **Why**: Portfolio snapshots now support TWR/cumulative time series and benchmark-relative analysis.
- **Source**: PR #148

## 2026-05-01: feat: add earnings calendar MCP tool

- **What**: feat: add earnings calendar MCP tool
- **Why**: ## Summary - add `get_earnings_calendar` FastMCP tool backed by yfinance calendar data - load symbols from the latest `PositionStore` snapshot when symbols are omitted - return per-symbol error entries and filter events by `days_ahead` - ad
- **Source**: PR #115

## 2026-04-20: maintenance: FastMCP 3系へ追従し内部API依存テストを解消する

- **What**: maintenance: FastMCP 3系へ追従し内部API依存テストを解消する
- **Why**: ## Summary - upgrade the optional `mcp` dependency and lockfile from FastMCP 2.x to FastMCP 3.x - replace MCP tests that depended on `_tool_manager`, `get_tools()`, `get_resources()`, and `get_resource_templates()` with public FastMCP APIs
- **Source**: PR #112

## 2026-04-11: fix(api): paginate positions and preserve connection errors in CPClient

- **What**: fix(api): paginate positions and preserve connection errors in CPClient
- **Why**: Addresses two unresolved review comments from PR #98 (chatgpt-codex-connector):
- **Source**: PR #105

## 2026-03-21: test: add integration test suite for Client Portal API with Paper Trading

- **What**: test: add integration test suite for Client Portal API with Paper Trading
- **Why**: - Add `tests/integration/` with 24 integration tests for the Client Portal API using Paper Trading account - Tests cover connection, live orders, order lifecycle (place/modify/cancel), and DB sync - All tests auto-skip when Gateway is not r
- **Source**: PR #102

## 2026-03-21: feat(orders): add order placement and management via Client Portal API

- **What**: feat(orders): add order placement and management via Client Portal API
- **Why**: Implements order placement, modification, and cancellation via IB Client Portal Gateway API with multiple safety mechanisms (#97).
- **Source**: PR #101

## 2026-03-21: feat(sync): add limit order DB sync with live IB orders via CP API

- **What**: feat(sync): add limit order DB sync with live IB orders via CP API
- **Why**: - Add `ib_sec_mcp/storage/order_sync.py` with IB → local DB sync logic - Add `sync_limit_orders` MCP tool for manual sync trigger - Matching by `symbol + limit_price + order_type` with IB as source of truth - Graceful handling when Gateway
- **Source**: PR #100
