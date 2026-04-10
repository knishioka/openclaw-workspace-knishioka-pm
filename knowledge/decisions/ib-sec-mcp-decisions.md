# ib-sec-mcp Design Decisions

## 2026-03-21: test: add integration test suite for Client Portal API with Paper Trading

- **What**: test: add integration test suite for Client Portal API with Paper Trading
- **Why**: ## Summary - Add `tests/integration/` with 24 integration tests for the Client Portal API using Paper Trading account - Tests cover connection, live orders, order lifecycle (place/modify/cancel), and DB sync - All tests auto-skip when Gateway is not running —…
- **Source**: PR #102

## 2026-03-21: feat(orders): add order placement and management via Client Portal API

- **What**: feat(orders): add order placement and management via Client Portal API
- **Why**: ## Summary Implements order placement, modification, and cancellation via IB Client Portal Gateway API with multiple safety mechanisms (#97). - **4 MCP tools**: `place_order`, `modify_order`, `cancel_order`, `cancel_all_orders` - **6 safety mechanisms**: dry-r…
- **Source**: PR #101

## 2026-03-21: feat(sync): add limit order DB sync with live IB orders via CP API

- **What**: feat(sync): add limit order DB sync with live IB orders via CP API
- **Why**: ## Summary - Add `ib_sec_mcp/storage/order_sync.py` with IB → local DB sync logic - Add `sync_limit_orders` MCP tool for manual sync trigger - Matching by `symbol + limit_price + order_type` with IB as source of truth - Graceful handling when Gateway is not ru…
- **Source**: PR #100

## 2026-03-21: feat(mcp): add live trading tools via Client Portal Gateway API

- **What**: feat(mcp): add live trading tools via Client Portal Gateway API
- **Why**: ## Summary - Add 4 MCP tools for real-time IB data via Client Portal Gateway API - `get_live_orders` — active orders with symbol/side/status filters - `get_live_account_balance` — real-time balance (auto-selects first account) - `get_live_positions` — position…
- **Source**: PR #99

## 2026-03-21: feat(api): add IB Client Portal API client with session management

- **What**: feat(api): add IB Client Portal API client with session management
- **Why**: ## Summary Implements #96 — IB Client Portal API client for real-time account data access through the local IB Gateway. - **CPClient**: Async httpx client with session management, TLS enforcement, exponential backoff retry (3 attempts) - **Pydantic Models**: C…
- **Source**: PR #98

## 2026-03-13: docs: deduplicate and compress documentation (-44%)

- **What**: docs: deduplicate and compress documentation (-44%)
- **Why**: ## Summary - Rewrite `.claude/README.md` (1,042→140 lines): verbose descriptions → concise tables, remove all duplicated content (architecture, time savings, version history, best practices, 3x `/daily-check`) - Fix `CLAUDE.md`: correct agent count (8→11), com…
- **Source**: PR #92
