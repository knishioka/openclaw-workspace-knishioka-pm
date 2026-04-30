# Focus Task Report — 2026-04-30 (Thu)

## 作成した Issue + PR

| Repo | Issue | PR | Type | Perspective | Subtype | Status |
|------|-------|----|------|-------------|---------|--------|
| knishioka/ib-sec-mcp | [#114](https://github.com/knishioka/ib-sec-mcp/issues/114) feat: 保有銘柄の決算・配当カレンダーツールを追加 | [#115](https://github.com/knishioka/ib-sec-mcp/pull/115) | feature | pm | feature | draft_pr_created ✅ |

## Pre-check 判定結果

| 項目 | 判定 | 詳細 |
|------|------|------|
| Open PM Issues | 2件 (OK) | kanji-practice #31, freee-mcp #177 |
| 直近30日 resolve率 | **66.7%** (4/6) | 50-80% → 最大 1 Issue/回 |
| Feature count (直近4回) | 2件 | 優先フラグなし |
| 直近4回 perspective | PM 3 : Dev 3 | バランス良好 |

→ 今回: PM perspective / feature 1件 作成

## 直近4回の Perspective 比率

| 日付 | Repo | Perspective | Subtype |
|------|------|-------------|---------|
| 2026-04-30 | ib-sec-mcp | **pm** | feature |
| 2026-04-27 | freee-mcp | dev | tech-adoption |
| 2026-04-26 | kanji-practice | qa | bugfix |
| 2026-04-20 | kanji-practice | pm | feature |
| 2026-04-20 | ib-sec-mcp | dev | maintenance |

直近4回 PM:Dev = 3:3 → バランス維持

## Tech Radar スキャン結果（今回採用せず、次回以降検討）

### 今週の重要トピック

1. **FastMCP 3** — ib-sec-mcp で 2026-04-20 に採用済み ✅
2. **yfinance `>=2.0` 対応** — ib-sec-mcp の dependabot PR #113 で `<2.0` 制約が更新待ち。`earnings_calendar.py` のコードは yfinance 2.x API の calendar dict 形式に対応させて実装。
3. **MCP Streaming Responses** — MCP spec v0.6 で partial streaming が議論中。FastMCP 3 側のサポート状況を継続観察。
4. **Python 3.13** — ib-sec-mcp はすでに Python 3.13 対応済み (pyproject.toml の `python_requires >= 3.12`, CI は 3.13 で動作確認)
5. **actions/checkout v4→v6** — dependabot PR #70 が open。2メジャーバージョン飛び越し。次回 focus-task で maintenance Issue 候補。
6. **astral-sh/setup-uv v5→v7** — dependabot PR #69 が open。同上。

### 次回 focus-task 候補

- **ib-sec-mcp**: dependabot PRs をまとめてマージする maintenance Issue（actions/checkout v6, setup-uv v7, yfinance 2.x）
- **math-worksheet**: Issue #57（分数↔小数変換）の auto-resolve 試行が pending → Codex へ回すか確認
- **english-note-maker**: sight words / phonics 穴埋めモード（PM/feature）

## Auto-Resolve 結果

| Issue | Codex | テスト | PR |
|-------|-------|--------|-----|
| ib-sec-mcp #114 | ✅ 完走 | 894/894 passed (56.17% coverage) | [#115](https://github.com/knishioka/ib-sec-mcp/pull/115) draft |

## 実装サマリ

新規ファイル `ib_sec_mcp/mcp/tools/earnings_calendar.py`:
- `get_earnings_calendar(symbols, days_ahead=90)` MCP ツール
- `symbols=None` → `PositionStore` の最新スナップショットから自動取得
- yfinance `Ticker.calendar` で Earnings Date / Ex-Dividend Date を取得
- 銘柄単位の失敗はエラーエントリとして返す（処理を止めない）
- 結果は `days_until_earnings` 昇順ソート

変更ファイル: 4件（earnings_calendar.py 新規, tools/__init__.py, test_server.py, test_earnings_calendar.py 新規）
