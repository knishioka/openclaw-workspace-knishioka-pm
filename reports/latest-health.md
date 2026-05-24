As of: 2026-05-24
Summary: RED 4 / YELLOW 0 / GREEN 6

>> Changes this week:
  knishioka/kanji-practice: GREEN -> GREEN (CI success, last update 10 days ago; QA found a content correctness bug and Issue #35 was created)
  knishioka/math-worksheet: GREEN -> GREEN (PR #71 merged; last update 1 day ago)
  knishioka/cost-management-mcp: GREEN -> GREEN (PR #154 merged and dependabot update landed; open PR count cleared)
  No status color transitions from 2026-05-17.

>> Risks / Blockers:
  knishioka/kanji-practice  Site QA: 1年生書き練習で `曜` など対象学年外の漢字を含む例語が出る。Issue #35 created [QA HIGH]
  knishioka/kanji-practice  Production preview still exposes `Debug` entrypoint. Existing Issue #31 remains open [QA MEDIUM]
  knishioka/simple-bookkeeping  inactivity 134 days, open issues 37, open PRs 8 [RED 7+ weeks]
  knishioka/td-mcp-server  inactivity 294 days, open PRs 2 [RED 7+ weeks]
  knishioka/meditation-chrome-extension  inactivity 328 days, no CI signal [RED 7+ weeks]
  knishioka/remotion-math-education  inactivity 341 days, no CI signal [RED 7+ weeks]

>> Next actions:
  knishioka/kanji-practice: restrict low-grade example words to learned kanji or kana fallback -> Issue #35 created
  knishioka/kanji-practice: hide production Debug overlay entrypoint -> Issue #31 pending
  knishioka/simple-bookkeeping: no new Issue; repo is dormant and already has high open issue/PR backlog

>> Confirmed:
  knishioka/kanji-practice  last update 10 days ago GREEN; page counts 1/5/10 matched generated pages after slider change
  knishioka/math-worksheet  last update 1 day ago GREEN; problem counts 15/20/30 matched; subtraction-with-borrow generated 30 non-negative problems
  knishioka/ib-sec-mcp  last update 23 days ago GREEN
  knishioka/freee-mcp  last update 18 days ago GREEN
  knishioka/cost-management-mcp  last update 1 day ago GREEN
  knishioka/english-note-maker  last update 20 days ago GREEN; page counts 1/5/10 reflected in generated phrase-practice preview

>> Demo Site QA:
  knishioka/kanji-practice: FAIL content-correctness. Page count and generation flow OK; low-grade vocabulary filtering needs fix (#35).
  knishioka/math-worksheet: OK. 15/20/30 problem counts matched; subtraction-with-borrow sample had no negative answers; no console errors observed.
  knishioka/english-note-maker: OK. Page count 1/5/10 generated matching preview sections; phrase content was grammatical and category-appropriate; no console errors observed.

>> Issue Tracker:
  knishioka/cost-management-mcp#153 -> merged via PR #154 on 2026-05-23, Quality Score A
  knishioka/math-worksheet#70 -> merged via PR #71 on 2026-05-23, Quality Score A
  knishioka/kanji-practice#31 remains open
  knishioka/kanji-practice#35 opened from this QA run

>> Context:
  knowledge/CHANGELOG.md notes recent competitive findings for kanji-practice around AI-assisted differentiation while preserving handwriting practice. The new QA finding is narrower: grade-appropriate worksheet vocabulary.
