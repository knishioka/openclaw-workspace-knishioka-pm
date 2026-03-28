As of: 2026-03-28 15:41 +08
Summary: RED 5 / YELLOW 2 / GREEN 3

>> Changes this week:
  （ステータス変化なし）全10リポが前回と同じステータス
  cost-management-mcp: RED → RED（放置143日→0日。ただし push直後の Actions が failure: CI run 23680239635 / Security Scan 23680239615）
  ib-sec-mcp: RED → RED（open issues 1→2 / gitleaks検出で落ちる Issue #103 が未解決）

>> Risks / Blockers:
  cost-management-mcp  CI failure（push直後の CI / Security Scan が連続 failure）[RED 2週連続]
  ib-sec-mcp  CI failure（Security: schedule run failure）[RED 2週連続]
  td-mcp-server  放置237日 / 未処理PR 2件 [RED 2週連続]
  meditation-chrome-extension  放置271日 [RED 2週連続]
  remotion-math-education  放置284日 [RED 2週連続]

>> Next actions:
  cost-management-mcp: 失敗 run 23680239635 / 23680239615 を確認→原因を切り分け（#146はPR #147で解決済みだが、push後も failure）
  cost-management-mcp: 未処理PR 3件を整理（必要ならrebase/close）
  ib-sec-mcp: gitleaks 失敗（Issue #103）を修復（tests/履歴内の ib-account-id 検出を除外 or fixture更新）
  ib-sec-mcp: 未処理PR 4件を整理（必要ならrebase/close）
  td-mcp-server: 未処理PR 2件を整理（必要ならrebase/close）+ 放置237日→ maintenance only / archive検討をREADMEに明記
  meditation-chrome-extension: 放置271日→ maintenance only / archive検討をREADMEに明記（またはアーカイブ）
  remotion-math-education: 放置284日→ maintenance only / archive検討をREADMEに明記（またはアーカイブ）
  english-note-maker: 放置86日→ 小さな改善（README/CI/依存更新）で再稼働の足がかりを作る
  simple-bookkeeping: 未処理PR 8件を整理 + open issues 36件をトリアージ（上位5件に優先度/ラベル付け→残りはstale整理）

>> Confirmed:
  kanji-practice  最終更新6日前 GREEN
  math-worksheet  最終更新6日前 GREEN（PR 1件 open）
  freee-mcp  最終更新22日前 GREEN（PR 15件 open）

>> Issue Tracker:
  作成: 2件 / 解決: 1件 / 未着手: 1件
  解決: cost-management-mcp #146 → PR #147 merged（Quality A / days_to_resolve=0）
  溜まり: 1件（focus-task 継続OK）
