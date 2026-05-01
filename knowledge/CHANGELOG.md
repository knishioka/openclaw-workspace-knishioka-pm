# Knowledge Changelog

As of: 2026-05-01

## New findings this week

- knishioka/kanji-practice: fix: Klee One フォントを Google Fonts 経由の Web フォントに変更（全環境で教科書体保証） (PR #27, #28, 2026-04-24)
- knishioka/kanji-practice: feat: 例文写経モードの練習行数を可変化（1-3行）+ 全マス書き取り対象に変更 (PR #29, #30, 2026-04-25)
- knishioka/math-worksheet: feat(tracing): 数字なぞり書きモジュール全面刷新（0-4/5-9 分割、SVG教科書体、2行目練習マス追加） (PR #60-63, 2026-04-25)
- knishioka/freee-mcp: feat(kpi): freee_kpi_dashboard に structuredContent 追加 + MCP SDK 1.29.0 (PR #178, 2026-04-29)
- knishioka/english-note-maker: feat(practice): 全練習モードに paged dedup + 難易度プリセット適用 (PR #26, #28, 2026-04-25)
- knishioka/workflow-engine: chore: デフォルト LLM を claude-sonnet-4-5 → claude-sonnet-4-6 に更新 (PR #150, 2026-04-28)
- knishioka/market-lens-studio: feat(ci): 週次レトロスペクティブ GitHub Actions ワークフロー追加（月曜 09:00 JST 自動実行） (PR #169, 2026-04-17)
- knishioka/jgrants-app: feat(ai): Claude ルートに Anthropic prompt caching 導入（system prompt を ephemeral キャッシュ） (PR #96, 2026-04-15)
- knishioka/ut-gymnastics: fix(nginx): Let's Encrypt 証明書失効 → server_name + ACME challenge location を修正 (PR #148, 2026-04-15)

## Competitive / trend research

- freee-mcp: MCP SDK pre-release (1.30+) が Standard Schema (Zod v4/Valibot/ArkType) + TaskManager を追加。freee-mcp は既に Zod v4 を採用済みのため互換性あり。TaskManager は長時間財務レポート生成への次の採用候補。
- math-worksheet: 0-4/5-9 分割レイアウトと教科書体 SVG の数字なぞり書きで、他の無料プリントサービスがほとんどカバーしていない幼児（年長）ターゲットに対応。URL State で同一設定を再現できる（PR #38）ため、教師・保護者がリンク共有するユースケースにも対応。
- market-lens-studio: AI コンテンツ自動化ツールは fact-check アーカイブ + 事後レトロスペクティブパイプラインが標準化しつつある。weekly retrospective workflow で先行優位性を確保。
- kanji-practice: 前回の spaced retrieval 提案に続き、今週の全マス書き取り（PR #30）で「1問あたりの練習量」が倍増。次は累積復習プリセット（当日学習 + 前回学習の混合）が最も効果的な機能候補として浮上。

## Knowledge freshness

- No priority=high repos are older than 8 weeks in KB freshness.
