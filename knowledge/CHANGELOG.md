# Knowledge Changelog - 2026-05-15

Only new findings since 2026-05-08 are listed.

## knishioka/cost-management-mcp

- [2026-05-12] PR #152: fix(ci): make TruffleHog scan refs robust — ## 概要 Security Scan workflow の TruffleHog diff scan が main push で default branch 名と `HEAD` を比較して同一 commit 扱いになり、`BASE and HEAD commits are the same` で失敗する問題を修正しました。push /...

## knishioka/kanji-practice

- [2026-05-14] PR #34: feat(print): customize first page header fields — ## 概要 1ページ目ヘッダーの名前欄・日付欄について、表示/非表示とラベル文言を設定パネルから変更できるようにしました。既存設定ロード時はデフォルト値を migration で補完し、2ページ目以降のヘッダー表示は従来どおり維持しています。 Closes #33 ## 変更内容 - `Settings` に `showNameField` /...

## knishioka/market-lens-studio

- [2026-05-13] PR #178: fix(note): avoid preview jq permission prompts — ## Summary Moves preview JSON construction for `/note:write` into the `note:preview-save` skill so auto workflows do not need top-level `jq | tee` commands that can miss Claude...

## knishioka/math-worksheet

- [2026-05-12] PR #69: feat(word-en): raise grade 4-6 difficulty for English word problems — ## Summary 4年生以上の English Word Problems (`word-en`) のレベルが、数値計算面でも英文構造面でも低すぎたため、Grade 4-6 全体を引き上げ。 -...
- [2026-05-12] PR #68: feat: add equation line option for word problems — ## 概要 文章題で立式の練習ができるように、文章題系パターンだけに「式を書く欄」トグルを追加しました。トグルON時は日本語文章題・英語文章題・Singapore Math の各問題で、答え欄の前に式欄を表示します。 Closes #67 ## 変更内容 - `WorksheetSettings` に `showEquationLine`...
- [2026-05-10] PR #66: [codex] Improve answer line spacing — ## Summary - Increase the writable area for Japanese word-problem answer lines. - Move the answer line lower for first-grade symbol/counting problems so it uses the blank space...

## knishioka/workflow-engine

- [2026-05-12] PR #153: fix(notion): bump HTTPClient timeout to 30s to avoid ReadTimeoutError — ## Summary - Increase the Notion HTTPClient timeout from 10s → 30s in `service_manager.get_notion_client()` - The Notion query API exceeds 10s when scanning the Tasks DB with a...
- [2026-05-11] PR #152: feat(actions): bundle multi-item LINE notifications via batch mode — ## Background ファミリーカレンダーで一度に多数の予定変更が起きた際、現状はイベントごとに個別の LINE push が走り、`max_per_execution=10` の rate limiter で10件目以降が失敗する（2026-05-11 06:00 UTC で実際に発生）。 ## Summary - ワークフロー設定に...

## Competitive Research Findings

- math-worksheet: AI/adaptive worksheet trend suggests next-step personalization, mistake-driven regeneration, answer/explanation sheets, and bar-model hint scaffolds.
- freee-mcp: Money Forward remote MCP launch makes remote/OAuth deployment a competitive baseline; freee deal-line cap change requires schema/test coverage for 100-line deals.

## Staleness Warnings

- None: all priority=high repositories were collected this week.
