# ib-sec-mcp Design Decisions

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

## 2026-03-21: feat(mcp): add live trading tools via Client Portal Gateway API

- **What**: feat(mcp): add live trading tools via Client Portal Gateway API
- **Why**: - Add 4 MCP tools for real-time IB data via Client Portal Gateway API - `get_live_orders` — active orders with symbol/side/status filters - `get_live_account_balance` — real-time balance (auto-selects first account) - `get_live_positions` — 
- **Source**: PR #99

## 2026-03-21: feat(api): add IB Client Portal API client with session management

- **What**: feat(api): add IB Client Portal API client with session management
- **Why**: Implements #96 — IB Client Portal API client for real-time account data access through the local IB Gateway. 
- **Source**: PR #98

## 2026-03-11: docs: add testing rules and update MCP tool guidelines

- **What**: docs: add testing rules and update MCP tool guidelines
- **Why**: ## Summary - **NEW** `.claude/rules/testing.md` (95行): MCP toolテストパターン、mockストラテジー、必須テストチェックリスト、抽出可能性ルール（Wave 14の`check_order_proximity`バグの再発防止） - **UPDATE** `.claude/rules/mcp-tools.md` (100行): External Dependency Pattern追加、Testing Requirem 
- **Source**: PR #91
