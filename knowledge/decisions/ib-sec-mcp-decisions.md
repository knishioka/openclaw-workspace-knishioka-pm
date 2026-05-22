# ib-sec-mcp Design Decisions

## 2026-03-11: docs: add testing rules and update MCP tool guidelines

- **What**: docs: add testing rules and update MCP tool guidelines
- **Why**: ## Summary - **NEW** `.claude/rules/testing.md` (95行): MCP toolテストパターン、mockストラテジー、必須テストチェックリスト、抽出可能性ルール（Wave 14の`check_order_proximity`バグの再発防止） - **UPDATE** `.claude/rules/mcp-tools.md` (100行): External Dependency Pattern追加、Testing Requirem
- **Source**: PR #91

## 2026-03-11: test: add MCP tool-level tests for limit order tools

- **What**: test: add MCP tool-level tests for limit order tools
- **Why**: - Add 28 functional tests in `tests/mcp/test_limit_orders.py` covering all 5 limit order MCP tools - Fix symbol resolution bug in `check_order_proximity`: add market suffix mapping (LSE→`.L`, TSE→`.T`) for correct yfinance ticker lookup
- **Source**: PR #90

## 2026-03-11: fix: resolve non-US symbols for Yahoo Finance in check_order_proximity

- **What**: fix: resolve non-US symbols for Yahoo Finance in check_order_proximity
- **Why**: - Add `MARKET_YAHOO_SUFFIX` mapping dict to translate IB market identifiers (LSE, TSE, HKG, SGX, ASX, FRA) to Yahoo Finance exchange suffixes (.L, .T, .HK, .SI, .AX, .F) - Guard against double-appending for symbols that already contain the
- **Source**: PR #89

## 2026-03-10: fix: add daily monitor tools to test_server expected tools set

- **What**: fix: add daily monitor tools to test_server expected tools set
- **Why**: ## Summary - Add `sync_daily_snapshot` and `get_sync_status` to `EXPECTED_TOOLS` in `test_server.py` - These tools were added in PR #81 but the test was not updated
- **Source**: PR #85

## 2026-03-10: feat: add /daily-check command with memory file auto-update rules

- **What**: feat: add /daily-check command with memory file auto-update rules
- **Why**: - Create `/daily-check` slash command (`.claude/commands/daily-check.md`) with complete 8-step workflow for daily portfolio monitoring - Define auto-update rules for 5 memory files: OVERWRITE (snapshot), CONDITIONAL (strategy), APPEND (deci
- **Source**: PR #83

## 2026-03-10: feat: add /daily-check slash command for scheduled monitoring

- **What**: feat: add /daily-check slash command for scheduled monitoring
- **Why**: - Create `/daily-check` slash command for automated daily portfolio monitoring - Designed for Claude Desktop scheduled tasks (no user interaction required) - Completes in under 3 minutes with parallel price fetching
- **Source**: PR #82
