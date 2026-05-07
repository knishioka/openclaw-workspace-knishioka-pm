# Focus Task Report — 2026-05-07 (Thu)

## 作成 Issue + PR

| repo | issue | PR | perspective | subtype | title | status |
|---|---|---|---|---|---|---|
| knishioka/cost-management-mcp | [#151](https://github.com/knishioka/cost-management-mcp/issues/151) | [#152](https://github.com/knishioka/cost-management-mcp/pull/152) | dev | maintenance | fix(ci): make TruffleHog secret scan robust on main pushes | draft PR ✅ CI green |

## Pre-check 判定

| チェック項目 | 結果 |
|---|---|
| Open PM-created Issues (制限: <3) | 0件 → 作成可 |
| Open tracked Issues (参考) | 1件 (`knishioka/kanji-practice` #31, qa/bugfix) |
| Resolve rate 直近30日 | 8/9 = 88.9% → max 2 Issues/run |
| Feature Issue 直近4回連続0件 | No (`ib-sec-mcp` #114 が feature) |
| 前回サジェスト除外 | `knishioka/freee-mcp` → 除外 |
| エスカレーション優先 | RED 2週連続+high の最優先対象なし |

## 動的頻度判定

Resolve rate 88.9%（80%以上）なので通常運転、最大2 Issue/run。今回は Dual-Perspective 比較の結果、CI fail を即解消できる Developer 視点の maintenance を 1件だけ採用。

## Dual-Perspective 候補比較

| repo | perspective | subtype | candidate | Value | Effort | Confidence | Urgency | Total | 採否 |
|---|---|---|---|---:|---:|---:|---:|---:|---|
| knishioka/cost-management-mcp | dev | maintenance | TruffleHog diff scan を push / PR SHA ベースへ修正し CI ノイズを止める | 9 | 9 | 9 | 10 | 37 | ✅ 採用 |
| knishioka/english-note-maker | pm | growth | LICENSE / CONTRIBUTING 追加で外部コントリビューション導線を作る | 5 | 9 | 9 | 3 | 26 | 見送り |
| knishioka/english-note-maker | pm | feature | alphabet 練習の次候補はあるが `/resolve-issue` で完走させる要件明確度が今回不足 | 7 | 6 | 5 | 2 | 20 | 見送り |
| knishioka/ib-sec-mcp | dev | maintenance | SDK / OpenAI minor 更新を検討 | 5 | 6 | 6 | 3 | 20 | 見送り |

## 直近4回の perspective 比率

対象: 2026-04-30 以降の focus-task で作成・追跡した 4件

| created | repo | issue | perspective | subtype |
|---|---|---:|---|---|
| 2026-04-30 | knishioka/ib-sec-mcp | #114 | pm | feature |
| 2026-05-03 | knishioka/cost-management-mcp | #149 | qa | bugfix |
| 2026-05-04 | knishioka/freee-mcp | #179 | dev | dx |
| 2026-05-07 | knishioka/cost-management-mcp | #151 | dev | maintenance |

PM:Dev = 1:2（qa を除外）。直近は Dev 側に寄っているが、直前の未解決 CI failure を優先した判断。

## Tech Radar スキャン (2026-05-07)

今回採用しなかったが次回以降の監視候補:

| トピック | 関連リポ | 優先度 | メモ |
|---|---|---|---|
| TruffleHog GitHub Action の base/head 運用見直し | cost-management-mcp | high | 今回の Issue で対処。merge 後は main push 経路の実観測を確認したい |
| `@modelcontextprotocol/sdk` 1.29.0 | freee-mcp / ib-sec-mcp / cost-management-mcp | medium | `cost-management-mcp` は `^1.20.2` で遅れあり。ただし今回は CI修復を優先 |
| `openai` 6.36.0 | cost-management-mcp | medium | 現在 `^6.8.0`。差分が大きく、別 maintenance Issue に切り出す価値あり |
| Tailwind CSS v4 系 | math-worksheet | medium | CSS-first config への移行余地あり |
| Vitest 4.x / ESLint flat config | math-worksheet / freee-mcp | low-medium | 直近で freee-mcp 側はテスト移行済み。横展開候補 |

## Codex auto-resolve 結果

- Issue: knishioka/cost-management-mcp #151
- PR: #152 (draft) — https://github.com/knishioka/cost-management-mcp/pull/152
- Branch: `fix/issue-151-trufflehog-scan-refs`
- Commit: `b030efc`
- 検証: `build` ✅ / `lint` ✅ / `format` ✅ / `typecheck` ✅ / `test` ✅ / `ci` ✅
- PR checks: `secret-scan`, `dependency-scan`, `CodeQL Analysis`, `build`, `security`, `test (18.x)`, `test (20.x)` 全 pass
- playbook_version: 2026-05-01
- lint_available: true
- lint_skipped_reason: null

## 既存 Open tracked Issues 状況

| repo | issue | perspective | subtype | title |
|---|---:|---|---|---|
| knishioka/kanji-practice | #31 | qa | bugfix | bugfix: hide Debug overlay entrypoint from production preview |
