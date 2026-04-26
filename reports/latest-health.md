As of: 2026-04-26
Summary: RED 4 / YELLOW 0 / GREEN 6

>> Changes this week:
  変化なし（全10リポのステータス遷移なし）

>> Risks / Blockers:
  knishioka/kanji-practice  production preview に Debug ボタンが露出。site QA で確認し bugfix Issue #31 を作成
  knishioka/simple-bookkeeping  106日更新なし、open issue 37件、RED 4週連続
  knishioka/td-mcp-server  266日更新なし、RED 4週連続（abandoned）
  knishioka/meditation-chrome-extension  300日更新なし、CI未設定、RED 4週連続（abandoned）
  knishioka/remotion-math-education  313日更新なし、CI未設定、RED 4週連続（abandoned）

>> Next actions:
  knishioka/kanji-practice: 本番UIから Debug 導線を隠す → Issue #31 created
  knishioka/simple-bookkeeping: dormant のため新規Issueは作らず、月次レビューで扱い方を再判断 → pending
  knishioka/ib-sec-mcp: 先週作成の maintenance Issue #111 は同日解決済み、retrospective反映 → done
  knishioka/kanji-practice: 先週作成の feature Issue #25 は同日解決済み、retrospective反映 → done

>> Confirmed:
  knishioka/kanji-practice  最終更新1日前 GREEN
  knishioka/math-worksheet  最終更新1日前 GREEN
  knishioka/ib-sec-mcp  最終更新6日前 GREEN
  knishioka/freee-mcp  最終更新10日前 GREEN
  knishioka/cost-management-mcp  最終更新29日前 GREEN
  knishioka/english-note-maker  最終更新1日前 GREEN

## QA Notes

- Demo site QA は browser(host) が github.io への hostname navigation を制限したため、Playwright screenshot fallback で実施
- kanji-practice: NG, production preview に Debug ボタン露出
- math-worksheet: OK, 3列30問プレビューに崩れなし
- english-note-maker: OK, phrase practice 1ページプレビューに崩れなし

## Issue Tracker

- Updated: knishioka/kanji-practice #25 → merged (PR #26, 2026-04-20), Quality A
- Updated: knishioka/ib-sec-mcp #111 → merged (PR #112, 2026-04-20), Quality A
- New: knishioka/kanji-practice #31 bugfix open (site QA)
