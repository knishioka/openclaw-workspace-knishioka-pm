As of: 2026-04-05
Summary: RED 5 / YELLOW 1 / GREEN 4

>> Changes this week:
  cost-management-mcp: RED → GREEN (schedule-only CI failure fixed in PR #147; latest CI success, 8日 inactive)
  english-note-maker: YELLOW → RED (94日 inactive で critical threshold超過)

>> Risks / Blockers:
  ib-sec-mcp  Security workflow failure継続、open PR 4、Issue #103 open [RED 2週連続]
  english-note-maker  94日放置で RED 化、open Issue #19 のみで実装進捗なし [RED 1週目]
  td-mcp-server  245日放置、open PR 2 のまま [RED 2週連続]
  meditation-chrome-extension  279日放置、CI なし [RED 2週連続]
  remotion-math-education  292日放置、CI なし [RED 2週連続]

>> Next actions:
  ib-sec-mcp: Issue #103 のまま security workflow 修復を優先（gitleaks schedule false-positive対処） → pending
  english-note-maker: 既存 feature Issue #19 を維持、追加 Issue はまだ不要 → pending
  kanji-practice: サイトQAでページ数 5枚生成は live で再現せず。Issue #20 は現行 GitHub Pages 上では再確認が必要 → pending close proposal
  cost-management-mcp: CI 修復後の安定監視を継続 → confirmed

>> Confirmed:
  kanji-practice  最終更新14日前 GREEN
  math-worksheet  最終更新5日前 GREEN
  freee-mcp  最終更新5日前 GREEN
  cost-management-mcp  最終更新8日前 GREEN
  simple-bookkeeping  最終更新85日前 YELLOW

## Demo Site QA

- kanji-practice: OK
  - `.a4-page` count: 5枚指定 → 5ページ生成を確認
  - A4レイアウト維持、プレビュー崩れなし
  - 既存 Issue #20 の症状（5/10枚が 1枚へ戻る）は current site では非再現
- math-worksheet: OK
  - `+1のたし算` 30問 / 3列レイアウトで 1ページに収まり、番号 1-30 を確認
  - 生成値サンプルは 0-9 の範囲で、+1 なので負数なし
  - 3列レイアウト崩れなし
- english-note-maker: OK
  - ページ数 5 を入力 → `.note-page` 5ページ生成を確認
  - Phrase Practice のページ見出し `(1/5)`, `(2/5)` を確認
  - 表示文言・和訳に明らかな誤りなし

## Knowledge context

- math-worksheet: 先週、property-based tests と Playwright 検証層を追加済み。今回 QA 安定と整合的。
- cost-management-mcp: PR #147 で schedule CI failure 修復済み。今回 RED→GREEN を確認。
- freee-mcp: axios 1.14.0 pin と MCP spec 動向メモあり。CI は安定継続。
- kanji-practice: 競合調査メモあり。今週の QA では feature/UX 検討よりも既存品質は安定。

## Issue Tracker

- Open tracked issues checked: #103 (ib-sec-mcp), #20/#21 (kanji-practice), #19 (english-note-maker)
- Status changes this run: なし
- Notable: kanji-practice Issue #20 は live site で非再現。close 提案候補だが、GitHub status はまだ OPEN
