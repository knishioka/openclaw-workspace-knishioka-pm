# Focus Task Report — 2026-05-11 (Mon)

## 作成 Issue + PR

| repo | issue | PR | perspective | subtype | title | status |
|---|---|---|---|---|---|---|
| knishioka/math-worksheet | [#67](https://github.com/knishioka/math-worksheet/issues/67) | [#68](https://github.com/knishioka/math-worksheet/pull/68) | pm | feature | feat: 文章題に「式を書く欄」トグルを追加する | draft PR ✅ |

## Pre-check 判定

| チェック項目 | 結果 |
|---|---|
| Open PM-created Issues (制限: <3) | 2件 → 作成可 (`kanji-practice` #31, `cost-management-mcp` #151 は open) |
| Resolve rate 直近30日 | 約 80% → max 1 Issue/run |
| Feature Issue 直近4回連続0件 | Yes → 今回は feature 優先 |
| 前回サジェスト除外 | `knishioka/cost-management-mcp` → 除外 |
| エスカレーション優先 | RED 2週連続+high の最優先対象なし |

## 動的頻度判定

resolve 率が 50-80% 帯のため今回は 1 Issue に制限。そのうえ直近4回で feature が 0 件だったため、教育系リポの PM 視点 feature を優先した。

## Dual-Perspective 候補比較

| repo | perspective | subtype | candidate | Value | Effort | Confidence | Urgency | Total | 採否 |
|---|---|---|---|---:|---:|---:|---:|---:|---|
| knishioka/math-worksheet | pm | feature | 文章題に「式を書く欄」トグルを追加し立式練習を支援 | 9 | 8 | 9 | 6 | 32 | ✅ 採用 |
| knishioka/freee-mcp | dev | refactor | 依存更新に備えた型整理 | 6 | 6 | 6 | 4 | 22 | 見送り |
| knishioka/ib-sec-mcp | dev | maintenance | 主要 SDK 更新の事前棚卸し | 5 | 6 | 6 | 4 | 21 | 見送り |
| knishioka/kanji-practice | pm | improvement | 漢字練習の補助 UI 改善 | 6 | 5 | 5 | 3 | 19 | 見送り |

## 直近4回の perspective 比率

対象: 2026-05-03 以降の focus-task で作成・追跡した 4件

| created | repo | issue | perspective | subtype |
|---|---|---:|---|---|
| 2026-05-03 | knishioka/cost-management-mcp | #149 | qa | bugfix |
| 2026-05-04 | knishioka/freee-mcp | #179 | dev | dx |
| 2026-05-07 | knishioka/cost-management-mcp | #151 | dev | maintenance |
| 2026-05-11 | knishioka/math-worksheet | #67 | pm | feature |

PM:Dev = 1:2（qa を除外）。今回は PM 側を戻してバランスを補正した。

## Tech Radar スキャン (2026-05-11)

今回採用しなかったが次回以降の監視候補:

| トピック | 関連リポ | 優先度 | メモ |
|---|---|---|---|
| Tailwind CSS v4 系 | math-worksheet | medium | CSS-first config への移行余地あり |
| Vitest 4.x / ESLint flat config | math-worksheet / freee-mcp | medium | テスト基盤更新の横展開候補 |
| `@modelcontextprotocol/sdk` 1.29.x | freee-mcp / ib-sec-mcp | medium | MCP 系の依存更新候補 |
| `openai` 6.36.x | cost-management-mcp | medium | 差分が大きく別 maintenance Issue 向き |

## Codex auto-resolve 結果

- Issue: knishioka/math-worksheet #67
- PR: #68 (draft) — https://github.com/knishioka/math-worksheet/pull/68
- Branch: `feat/issue-67-equation-line`
- Commit: `3f19ecd`
- 検証: `build` ✅ / `lint` ✅ / `format` ❌ (既存未整形44件) / `typecheck` ✅ / `test` ✅ (52 passed) / `layout` ✅
- playbook_version: 2026-05-01
- lint_available: true
- lint_skipped_reason: null

## 既存 Open tracked Issues 状況

| repo | issue | perspective | subtype |
|---|---:|---|---|
| knishioka/kanji-practice | #31 | qa | bugfix |
| knishioka/cost-management-mcp | #151 | dev | maintenance |
| knishioka/math-worksheet | #67 | pm | feature |
