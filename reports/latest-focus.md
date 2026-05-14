# Focus Task Report — 2026-05-14 (Thu)

## 作成 Issue + PR

| repo | issue | PR | perspective | subtype | title | status |
|---|---|---|---|---|---|---|
| knishioka/kanji-practice | [#33](https://github.com/knishioka/kanji-practice/issues/33) | [#34](https://github.com/knishioka/kanji-practice/pull/34) | pm | feature | feat: プリント1ページ目の名前・日付欄を切り替え/編集できるようにする | draft PR ✅ |

## Pre-check 判定

| チェック項目 | 結果 |
|---|---|
| Open PM-created Issues (制限: <3) | 2件 → 作成可 (`knishioka/cost-management-mcp` #151, `knishioka/math-worksheet` #67) |
| Resolve rate 直近30日 | 72.7% (8/11) → max 1 Issue/run |
| Feature Issue 直近4回連続0件 | No → 2026-05-11 に `math-worksheet` #67 feature あり |
| 前回サジェスト除外 | `knishioka/math-worksheet` → 除外 |
| エスカレーション優先 | `RED 2週連続+high` の明確な最優先対象なし |
| tech-adoption 直近3回連続0件 | Yes → 今回は Tech Radar を記録し、次回候補を明示 |

## 動的頻度判定

resolve 率が 50-80% 帯のため今回は 1 Issue に制限。教育系リポ優先かつ前回提案 repo を避ける条件を満たす中で、`kanji-practice` の印刷体験改善 feature を採用した。

## Dual-Perspective 候補比較

| repo | perspective | subtype | candidate | Value | Effort | Confidence | Urgency | Total | 採否 |
|---|---|---|---|---:|---:|---:|---:|---:|---|
| knishioka/kanji-practice | pm | feature | 1ページ目の名前・日付欄を表示切替/ラベル編集可能にして家庭・教室運用を楽にする | 9 | 8 | 9 | 5 | 31 | ✅ 採用 |
| knishioka/freee-mcp | dev | tech-adoption | MCP SDK 1.29.x 前提で session 依存箇所を棚卸しし、protocol-level session 廃止へ備える PoC | 7 | 5 | 6 | 5 | 23 | 次点 |
| knishioka/cost-management-mcp | dev | maintenance | 直近 CI failure の原因を切り分け、TruffleHog 周辺の失敗再発を抑える | 6 | 6 | 6 | 6 | 24 | 見送り |
| knishioka/english-note-maker | pm | improvement | 罫線プリントの初回設定導線を短縮する | 5 | 6 | 5 | 3 | 19 | 見送り |

## 直近4回の perspective 比率

対象: 2026-05-04 以降の focus-task で作成・追跡した 4件

| created | repo | issue | perspective | subtype |
|---|---|---:|---|---|
| 2026-05-04 | knishioka/freee-mcp | #179 | dev | dx |
| 2026-05-07 | knishioka/cost-management-mcp | #151 | dev | maintenance |
| 2026-05-11 | knishioka/math-worksheet | #67 | pm | feature |
| 2026-05-14 | knishioka/kanji-practice | #33 | pm | feature |

PM:Dev = 2:2。今回の採用で直近バランスは均衡に戻った。

## Tech Radar スキャン (2026-05-14)

今回採用しなかったが次回以降の監視候補:

| トピック | 関連リポ | 優先度 | メモ |
|---|---|---|---|
| React 19.2.x 継続更新 + React Foundation 発足 | kanji-practice / math-worksheet | medium | 教育系フロントの依存更新タイミングを揃えやすい。 |
| Playwright visual snapshot / Vitest snapshot 活用整理 | kanji-practice | medium | 今回の印刷 UI 変更でも snapshot 更新が主検証になり、print regression の型が見えた。 |
| MCP SDK 1.29.0 と protocol-level session 廃止の流れ | freee-mcp / ib-sec-mcp | high | 次回の tech-adoption 候補。session 前提コードの PoC issue を切る価値が高い。 |
| 競合の漢字 worksheet generator は editable header を標準搭載 | kanji-practice | medium | `henckq.nl/kanji/` などで header customization が一般化しており、今回機能で差分を埋めた。 |

## Codex auto-resolve 結果

- Issue: knishioka/kanji-practice #33
- PR: #34 (draft) — https://github.com/knishioka/kanji-practice/pull/34
- Branch: `feat/issue-33-custom-header`
- Commit: `c99c6de`
- 検証: `build` ✅ / `lint` ✅ / `format` n/a / `typecheck` ✅ / `test` ✅ / `ci` ✅
- playbook_version: 2026-05-01
- lint_available: true
- lint_skipped_reason: null
- 補足: local `.git` lock 制約のため、remote branch への直接 push で PR を成立

## 既存 Open tracked Issues 状況

| repo | issue | perspective | subtype |
|---|---:|---|---|
| knishioka/kanji-practice | #31 | qa | bugfix |
| knishioka/cost-management-mcp | #151 | dev | maintenance |
| knishioka/math-worksheet | #67 | pm | feature |
| knishioka/kanji-practice | #33 | pm | feature |
