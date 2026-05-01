# Focus Task Report — 2026-04-30 (Thu)

## 2026-05-02: cron prompt → codex-resolve.sh 切替メモ (Issue #7)

`~/.openclaw/cron/jobs.json` の `focus-task` job を編集し、Codex 起動行を直接 `codex exec` から workspace の wrapper に切り替えた。

| 項目          | 内容                                                                                                      |
| ------------- | --------------------------------------------------------------------------------------------------------- |
| 切替日        | 2026-05-02                                                                                                |
| 旧            | `codex exec -C /Users/ken/Developer/private/{repo_name} --full-auto "/resolve-issue #{issue_number}"`     |
| 新            | `bash /Users/ken/.openclaw/workspace-knishioka-pm/scripts/codex-resolve.sh {owner}/{name} {issue_number}` |
| backup        | `~/.openclaw/cron/jobs.json.bak.pre-codex-resolve-20260502`                                               |
| 初回監視対象  | 次回 `focus-task` 実行 (Mon 2026-05-04 8:30 KL)                                                           |
| rollback 手順 | `cp ~/.openclaw/cron/jobs.json.bak.pre-codex-resolve-20260502 ~/.openclaw/cron/jobs.json`                 |

**狙い**: PR #3 で追加した "PR Description Standards" / "Codex Prompting Guidelines" を、wrapper 経由で workspace `docs/codex-playbook.md` ごと Codex プロンプトに注入する経路に乗せる。リポ側 CLAUDE.md / AGENTS.md には依存しない。

### Dry-run 確認

`bash scripts/codex-resolve.sh --dry-run knishioka/kanji-practice 999` で生成プロンプト 280 行を確認:

- 冒頭に `# Workspace Policy Context (knishioka-pm AGENTS.md)` セクションで `docs/codex-playbook.md` 全文が injection される
- `# Task` セクションで `/resolve-issue #999` + 【目標】【制約】【検証】【出力】の 4 ブロック (Codex Prompting Guidelines 準拠)
- 対象リポを `knishioka/kanji-practice` のみに限定し、workspace 側を編集対象外と明示

### 他 cron job 棚卸し

`~/.openclaw/cron/jobs.json` の全 40 job を grep した結果、prompt 内で `codex exec` を直接呼ぶ job は **focus-task の 1 件のみ**。

- escalation 系 (例: weekly-repo-health) は WhatsApp / commit のみで Codex を起動しない
- private-repo-check も Issue 作成までで自動 PR 化はしない
- → 同様の wrapper 切替が必要な後続 job は **なし**。本 Issue で完了。

### 検証ゲート

実 PR 生成は次回 `focus-task` (Mon 8:30 KL) に委ねる。生成された draft PR の本文が "PR Description Standards" (動作確認テーブル / 受け入れ条件 / 影響範囲 / レビュー観点 / 日本語) を満たしていることを確認後、本切替を完了とみなす。1 サイクルで PR description が壊れていた場合は backup から即 rollback する。

---

## 作成した Issue + PR

| Repo                 | Issue                                                                                                       | PR                                                       | Type    | Perspective | Subtype | Status              |
| -------------------- | ----------------------------------------------------------------------------------------------------------- | -------------------------------------------------------- | ------- | ----------- | ------- | ------------------- |
| knishioka/ib-sec-mcp | [#114](https://github.com/knishioka/ib-sec-mcp/issues/114) feat: 保有銘柄の決算・配当カレンダーツールを追加 | [#115](https://github.com/knishioka/ib-sec-mcp/pull/115) | feature | pm          | feature | draft_pr_created ✅ |

## Pre-check 判定結果

| 項目                    | 判定            | 詳細                               |
| ----------------------- | --------------- | ---------------------------------- |
| Open PM Issues          | 2件 (OK)        | kanji-practice #31, freee-mcp #177 |
| 直近30日 resolve率      | **66.7%** (4/6) | 50-80% → 最大 1 Issue/回           |
| Feature count (直近4回) | 2件             | 優先フラグなし                     |
| 直近4回 perspective     | PM 3 : Dev 3    | バランス良好                       |

→ 今回: PM perspective / feature 1件 作成

## 直近4回の Perspective 比率

| 日付       | Repo           | Perspective | Subtype       |
| ---------- | -------------- | ----------- | ------------- |
| 2026-04-30 | ib-sec-mcp     | **pm**      | feature       |
| 2026-04-27 | freee-mcp      | dev         | tech-adoption |
| 2026-04-26 | kanji-practice | qa          | bugfix        |
| 2026-04-20 | kanji-practice | pm          | feature       |
| 2026-04-20 | ib-sec-mcp     | dev         | maintenance   |

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

| Issue           | Codex   | テスト                           | PR                                                             |
| --------------- | ------- | -------------------------------- | -------------------------------------------------------------- |
| ib-sec-mcp #114 | ✅ 完走 | 894/894 passed (56.17% coverage) | [#115](https://github.com/knishioka/ib-sec-mcp/pull/115) draft |

## 実装サマリ

新規ファイル `ib_sec_mcp/mcp/tools/earnings_calendar.py`:

- `get_earnings_calendar(symbols, days_ahead=90)` MCP ツール
- `symbols=None` → `PositionStore` の最新スナップショットから自動取得
- yfinance `Ticker.calendar` で Earnings Date / Ex-Dividend Date を取得
- 銘柄単位の失敗はエラーエントリとして返す（処理を止めない）
- 結果は `days_until_earnings` 昇順ソート

変更ファイル: 4件（earnings_calendar.py 新規, tools/**init**.py, test_server.py, test_earnings_calendar.py 新規）
