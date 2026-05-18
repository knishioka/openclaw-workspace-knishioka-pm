# Focus Task Report — 2026-05-18 (Mon)

## 作成 Issue + PR

| repo | issue | PR | perspective | subtype | title | status |
|---|---|---|---|---|---|---|
| knishioka/cost-management-mcp | [#153](https://github.com/knishioka/cost-management-mcp/issues/153) | [#154](https://github.com/knishioka/cost-management-mcp/pull/154) | dev | tech-adoption | tech: CI に Node.js 22 互換性レーンを追加する | draft PR ✅ |
| knishioka/math-worksheet | [#70](https://github.com/knishioka/math-worksheet/issues/70) | [#71](https://github.com/knishioka/math-worksheet/pull/71) | pm | feature | feat: 3桁×2桁の筆算に部分積ガイドを出せるようにする | draft PR ✅ |

## Pre-check 判定

| チェック項目 | 結果 |
|---|---|
| Open PM-created Issues (制限: <3) | 0件 → 作成可 |
| Resolve rate 直近30日 | 90.0% (9/10) → max 2 Issues/run |
| Feature Issue 直近4回連続0件 | No → 2026-05-14 に `kanji-practice` #33 feature あり |
| 前回サジェスト除外 | `knishioka/kanji-practice` を回避 |
| エスカレーション優先 | `RED 2週連続+high` の最優先 repo なし |
| tech-adoption 直近3回連続0件 | Yes → 今回 `cost-management-mcp` #153 を tech-adoption として採用 |

## 動的頻度判定

resolve 率が 80% 超だったため今回は最大 2 Issue で通常運転。教育系 repo から PM feature を 1件、MCP / ツール系 repo から Developer 側の tech-adoption を 1件選び、feature 比率と PM:Dev バランスの両方を崩しすぎない組み合わせにした。

## Dual-Perspective 候補比較

| repo | perspective | subtype | candidate | Value | Effort | Confidence | Urgency | Total | 採否 |
|---|---|---|---|---:|---:|---:|---:|---:|---|
| knishioka/math-worksheet | pm | feature | 3桁×2桁筆算で部分積を段ごとに練習できるようにする | 9 | 8 | 9 | 6 | 32 | ✅ 採用 |
| knishioka/cost-management-mcp | dev | tech-adoption | Node.js 22 compatibility lane を CI に追加し次期 LTS 互換性を先回り確認 | 8 | 8 | 9 | 8 | 33 | ✅ 採用 |
| knishioka/freee-mcp | dev | tech-adoption | MCP SDK 1.29 系の session 廃止前提で PoC を切る | 7 | 5 | 6 | 6 | 24 | 次点 |
| knishioka/english-note-maker | pm | improvement | 初回セットアップの入力導線を短縮する | 6 | 6 | 6 | 4 | 22 | 見送り |

## 直近4回の perspective 比率

| created | repo | issue | perspective | subtype |
|---|---|---:|---|---|
| 2026-05-07 | knishioka/cost-management-mcp | #151 | dev | maintenance |
| 2026-05-11 | knishioka/math-worksheet | #67 | pm | feature |
| 2026-05-14 | knishioka/kanji-practice | #33 | pm | feature |
| 2026-05-18 | knishioka/cost-management-mcp | #153 | dev | tech-adoption |

PM:Dev = 2:2。今回の 2件目 (`math-worksheet` #70) まで含めると直近5件では PM:Dev = 3:2。許容範囲内。

## Tech Radar スキャン (2026-05-18)

| トピック | 関連リポ | 優先度 | メモ |
|---|---|---|---|
| Node.js 22 LTS 互換性確認 | cost-management-mcp / freee-mcp / ib-sec-mcp | high | SDK/CI の互換性確認を早めに回しておく価値が高い。今回 `cost-management-mcp` で先行対応。 |
| MCP SDK 1.29 系の session 廃止影響 | freee-mcp / ib-sec-mcp | high | 次回 tech-adoption 候補。protocol-level session 依存の棚卸しが必要。 |
| 小学生向け worksheet で部分積の可視化 | math-worksheet | medium | 競合教材で一般的。4年生の筆算導入として user value が高い。 |
| print layout regression の snapshot / visual check 強化 | math-worksheet / kanji-practice | medium | 印刷系 UI 変更の回帰確認を機械化したい。 |

## Codex auto-resolve 結果

### knishioka/cost-management-mcp #153
- PR: #154 (draft) — https://github.com/knishioka/cost-management-mcp/pull/154
- Branch: `chore/issue-153-node-22-ci`
- 検証: `build` ✅ / `lint` ✅ 0 errors / `format` ✅ / `typecheck` ✅ / `test` ✅ 92 passed / `node22` ✅ / `ci` ✅
- playbook_version: 2026-05-01
- lint_available: true
- lint_skipped_reason: null

### knishioka/math-worksheet #70
- PR: #71 (draft) — https://github.com/knishioka/math-worksheet/pull/71
- Branch: `feature/issue-70-partial-products`
- 検証: `build` ✅ / `lint` ✅ / `format` ⚠️ fail (既存未整形 42 files) / `typecheck` ✅ / `test` ✅ 612 passed / `ci` ✅
- playbook_version: 2026-05-01
- lint_available: true
- lint_skipped_reason: null

## 既存 Open tracked Issues 状況

| repo | issue | perspective | subtype |
|---|---:|---|---|
| knishioka/kanji-practice | #31 | qa | bugfix |
| knishioka/cost-management-mcp | #153 | dev | tech-adoption |
| knishioka/math-worksheet | #70 | pm | feature |
