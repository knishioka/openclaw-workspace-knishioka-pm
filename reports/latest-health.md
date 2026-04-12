As of: 2026-04-12
Summary: RED 4 / YELLOW 0 / GREEN 6

>> Changes this week:
  ib-sec-mcp: RED → GREEN (CI failure解消、Issue #103 / PR #104 反映後に success)
  english-note-maker: RED → GREEN (Issue #19 / PR #20 反映後、最終更新1日前)
  simple-bookkeeping: YELLOW → RED (92日 inactive で critical threshold超過)

>> Risks / Blockers:
  simple-bookkeeping  92日放置、open issue 37 / open PR 8、dormant repo [RED 1週連続]
  td-mcp-server  252日放置、open PR 2、abandoned repo [RED 3週連続]
  meditation-chrome-extension  286日放置、CI なし、abandoned repo [RED 3週連続]
  remotion-math-education  299日放置、CI なし、abandoned repo [RED 3週連続]

>> Next actions:
  simple-bookkeeping: dormant前提で新規Issueは増やさず、月次レビューで扱いを再確認 → pending
  td-mcp-server: abandoned前提で archive 候補として月次レビュー送り → pending
  meditation-chrome-extension: abandoned前提で archive 候補として月次レビュー送り → pending
  remotion-math-education: abandoned前提で archive 候補として月次レビュー送り → pending

>> Confirmed:
  kanji-practice  最終更新0日前 GREEN
  math-worksheet  最終更新0日前 GREEN
  ib-sec-mcp  最終更新1日前 GREEN
  freee-mcp  最終更新12日前 GREEN
  cost-management-mcp  最終更新15日前 GREEN
  english-note-maker  最終更新1日前 GREEN

## Demo Site QA

- kanji-practice: OK
  - 5枚指定で `1/5` ... `5/5`、10枚指定で `1/10` ... `10/10` を確認
  - 2026-03-28 の Issue #20 症状（ページ数リセット）は現行 site で非再現
  - 1年生サンプル内容に明らかな学年逸脱は見当たらず、A4プレビュー崩れなし
- math-worksheet: OK
  - `+1のたし算` 30問 / 3列、20問 / 2列で問題数とプレビュー一致
  - `1桁のひき算（繰り下がりなし）` サンプルで負数なし
  - 2026-03-28 の列重複 Issue #48 の再発は見えず、レイアウト崩れなし
- english-note-maker: OK
  - 5ページ指定で `Phrase Practice - あいさつ (1/5)` ... `(5/5)` を確認
  - 直近修正後も 1ページ / 5ページともページ生成は正常
  - 表示フレーズ、和訳、用途ラベルに明らかな誤りなし

## Knowledge context

- math-worksheet: 今週は Bar Model overflow 修正と幼児向け数字なぞり書き機能追加があり、教育系拡張が継続。
- ib-sec-mcp: 今週の競合調査では read-only portfolio/risk summary と paper/live 安全表示が差別化候補。
- freee-mcp: axios pin 済みで CI は安定継続。

## Issue Tracker

- Tracked issues total: 6
- Open tracked issues checked this run: 0
- Quality score summary: A 6 / B 0 / C 0 / D 0
- Status changes this run: なし
- Notable: 追跡中 Issue は全件 merged 済み。今回の retrospective 更新対象はなし
