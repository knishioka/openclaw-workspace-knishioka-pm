# ib-sec-mcp Design Decisions

## 2026-04-11: fix(api): paginate positions and preserve connection errors in CPClient

- **What**: fix(api): paginate positions and preserve connection errors in CPClient
- **Why**: ## Summary Addresses two unresolved review comments from PR #98 (chatgpt-codex-connector): - **Pagination for `get_positions`**: Previously only fetched page 0 (`/positions/0`). IB paginates ~30 positions per page, so accounts with more holdings silently lost data. Now loops through all pages until empty response. - **Connection error preservation**: `_ensure_authenticated` was catching `CPClientError` (base class) …
- **Source**: PR #105

## 2026-04-11: ci(security): fix gitleaks schedule failure on test dummy account IDs

- **What**: ci(security): fix gitleaks schedule failure on test dummy account IDs
- **Why**: ## Summary - Schedule gitleaks runs now use `--no-git --source .` to scan only the working tree, avoiding false positives from IB account ID patterns (`U\d{7,10}`) in git history - Push/PR gitleaks runs continue scanning commit history as before - Expanded `.gitleaks.toml` allowlist from `tests/fixtures/.*` to `tests/.*` as defense-in-depth Fixes #103 ## Changes | File | Change | |------|--------| | `.github/workflo…
- **Source**: PR #104

## 2026-03-21: test: add integration test suite for Client Portal API with Paper Trading

- **What**: test: add integration test suite for Client Portal API with Paper Trading
- **Why**: ## Summary - Add `tests/integration/` with 24 integration tests for the Client Portal API using Paper Trading account - Tests cover connection, live orders, order lifecycle (place/modify/cancel), and DB sync - All tests auto-skip when Gateway is not running — zero impact on CI/CD ## Changes ### New Files - `tests/integration/__init__.py` — Package init - `tests/integration/conftest.py` — `gateway_available()` skip c…
- **Source**: PR #102

## 2026-03-21: feat(orders): add order placement and management via Client Portal API

- **What**: feat(orders): add order placement and management via Client Portal API
- **Why**: ## Summary Implements order placement, modification, and cancellation via IB Client Portal Gateway API with multiple safety mechanisms (#97). - **4 MCP tools**: `place_order`, `modify_order`, `cancel_order`, `cancel_all_orders` - **6 safety mechanisms**: dry-run (default ON), per-order limit ($50K), daily limit ($200K), read-only mode, order logging, account masking - **CP Client extensions**: 3 new methods + 2-step…
- **Source**: PR #101

## 2026-03-21: feat(sync): add limit order DB sync with live IB orders via CP API

- **What**: feat(sync): add limit order DB sync with live IB orders via CP API
- **Why**: ## Summary - Add `ib_sec_mcp/storage/order_sync.py` with IB → local DB sync logic - Add `sync_limit_orders` MCP tool for manual sync trigger - Matching by `symbol + limit_price + order_type` with IB as source of truth - Graceful handling when Gateway is not running (skip, no error) ## Changes ### New Files - `ib_sec_mcp/storage/order_sync.py` — Core sync logic - `sync_orders_from_ib()` — New/filled/cancelled order s…
- **Source**: PR #100

## 2026-03-21: feat(mcp): add live trading tools via Client Portal Gateway API

- **What**: feat(mcp): add live trading tools via Client Portal Gateway API
- **Why**: ## Summary - Add 4 MCP tools for real-time IB data via Client Portal Gateway API - `get_live_orders` — active orders with symbol/side/status filters - `get_live_account_balance` — real-time balance (auto-selects first account) - `get_live_positions` — positions with unrealized P&L - `check_gateway_status` — connection/auth status check - Graceful error handling: gateway down or session expired returns JSON errors, n…
- **Source**: PR #99

## 2026-03-21: feat(api): add IB Client Portal API client with session management

- **What**: feat(api): add IB Client Portal API client with session management
- **Why**: ## Summary Implements #96 — IB Client Portal API client for real-time account data access through the local IB Gateway. - **CPClient**: Async httpx client with session management, TLS enforcement, exponential backoff retry (3 attempts) - **Pydantic Models**: CPAuthStatus, CPOrder, CPAccountBalance, CPPosition — all financial fields use `Decimal` - **Security**: HTTPS-only (HTTP rejected), account number masking in l…
- **Source**: PR #98

## 2026-03-13: docs: deduplicate and compress documentation (-44%)

- **What**: docs: deduplicate and compress documentation (-44%)
- **Why**: ## Summary - Rewrite `.claude/README.md` (1,042→140 lines): verbose descriptions → concise tables, remove all duplicated content (architecture, time savings, version history, best practices, 3x `/daily-check`) - Fix `CLAUDE.md`: correct agent count (8→11), command count (12→21), remove template code duplicated in `.claude/CLAUDE.md` - Fix `.claude/CLAUDE.md`: simplify MCP reference to link, remove outdated "TODO" wa…
- **Source**: PR #92
