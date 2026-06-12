# market-lens-studio Design Decisions

## 2026-06-11: fix(notion): Notion 実エラー文言にフェイルセーフが反応しないバグを修正

- **What**: fix(notion): Notion 実エラー文言にフェイルセーフが反応しないバグを修正
- **Why**: 2026-06-11 朝の本番インシデントで発覚: `sync_to_notion.py` の optional プロパティ・フォールバックが、Notion の**実際のエラー文言** `"Skeleton is not a property that exists."` にマッチせず、同期がハードフェイルしていました。
- **Source**: PR #292

## 2026-06-11: feat(automation): フォールバック公開経路にも render check を追加

- **What**: feat(automation): フォールバック公開経路にも render check を追加
- **Why**: Step 6.2.6 のレンダリングチェック（#290）は `/note:write` ワークフロー内でのみ実行され、launchd のフォールバック公開経路では一切走らないギャップがありました。両経路に**非ブロッキング・ログのみ**の render check を追加します。
- **Source**: PR #291

## 2026-06-10: feat(note): Playwright による公開ページの決定的レンダリングチェック (Step 6.2.6)

- **What**: feat(note): Playwright による公開ページの決定的レンダリングチェック (Step 6.2.6)
- **Why**: 既存の品質ゲート（fact-check / quality-review / lint_article）はすべて **Markdown ソース**を検証しており、「note.com が実際にどう描画したか」は誰も見ていませんでした。公開直後に headless Playwright で公開ページを開き、レンダリング結果を機械的に検証する Step 6.2.6 を追加します。
- **Source**: PR #290

## 2026-06-10: feat(note): sub-agent を sonnet-4-6 へ更新 + 複数シンボルの並列取得（上限3）

- **What**: feat(note): sub-agent を sonnet-4-6 へ更新 + 複数シンボルの並列取得（上限3）
- **Why**: 1. **モデル更新**: note パイプラインの全サブエージェント11個のモデルピンを `claude-sonnet-4-5` → `claude-sonnet-4-6` に更新（価格は $3/$15 で同一のため notify_slack のコスト定数は不変、コメントのみ更新）。CI は `--model sonnet` エイリアスのため変更不要。 2. **複数シンボルの並列取得**: 未使用だった `parallel_fetcher.py` を活用し、シンボル2つ以
- **Source**: PR #289

## 2026-06-10: feat(diagram): generation_insights の diagram_budget_overrides を消費 (#287)

- **What**: feat(diagram): generation_insights の diagram_budget_overrides を消費 (#287)
- **Why**: Issue #287 の実装。PR #286（自動学習ループ）で `build_generation_insights.py` が算出する `diagram_budget_overrides`（画像枚数バケット×エンゲージメント中央値由来）を、消費側の `suggest_diagrams.py` に配線します。#284 とのコンフリクト回避のため #286 では見送っていた最後のピースです。
- **Source**: PR #288

## 2026-06-10: feat(note): 自動学習ループ — generation insights を毎実行時に再計算して還流 (PDCA改善 Phase 4)

- **What**: feat(note): 自動学習ループ — generation insights を毎実行時に再計算して還流 (PDCA改善 Phase 4)
- **Why**: 「意図的にやらずとも勝手に改善していく」仕組み（PDCA改善計画 Phase 4/4・最終）。収集済みだが未消費だったエンゲージメント実績・生成メタデータ・fact-check 警告を、**毎実行時に決定的に再計算**して suggest/write に還流します。
- **Source**: PR #286
