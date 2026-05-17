As of: 2026-05-17
Summary: RED 4 / YELLOW 0 / GREEN 6

>> Changes this week:
  None: repo health status is unchanged from 2026-05-10.

>> Risks / Blockers:
  knishioka/kanji-practice  Demo QA: production demo still shows a floating `Debug` control. Existing Issue #31 remains open; no duplicate Issue created. [site QA WARN]
  knishioka/simple-bookkeeping  127 days inactive, 37 open issues, 8 open PRs. [RED 6週連続]
  knishioka/td-mcp-server  287 days inactive, abandoned; no new Issue per policy. [RED継続]
  knishioka/meditation-chrome-extension  321 days inactive, no CI. [RED継続]
  knishioka/remotion-math-education  334 days inactive, no CI. [RED継続]

>> Next actions:
  knishioka/kanji-practice: Resolve existing production Debug overlay Issue #31 → pending
  knishioka/simple-bookkeeping: dormant repo; no new Issue per frequency/status policy → pending manual portfolio decision
  knishioka/td-mcp-server / meditation-chrome-extension / remotion-math-education: abandoned repos; keep silent unless portfolio review recommends archive

>> Confirmed:
  knishioka/kanji-practice  最終更新3日前 GREEN / CI success / open issues 1 / PRs 0
  knishioka/math-worksheet  最終更新5日前 GREEN / CI success / open issues 1 / PRs 1
  knishioka/ib-sec-mcp  最終更新16日前 GREEN / CI success / open issues 0 / PRs 5
  knishioka/freee-mcp  最終更新11日前 GREEN / CI success / open issues 1 / PRs 11
  knishioka/cost-management-mcp  最終更新5日前 GREEN / CI success / open issues 3 / PRs 3
  knishioka/english-note-maker  最終更新13日前 GREEN / CI success / open issues 0 / PRs 0

>> Demo Site QA:
  knishioka/kanji-practice: WARN — default 1-page generation renders, but `Debug` button is visible in production demo. Existing Issue #31 covers this.
  knishioka/math-worksheet: OK — +1 addition checked across 1/2/3 columns; 10/20/30 questions render and sample answers are non-negative.
  knishioka/english-note-maker: OK — phrase practice checked for 1/5/10 pages; page headings and content render consistently.

>> Issue Tracker:
  Updated this run:
    knishioka/cost-management-mcp #151 → merged via PR #152, Quality Score A
    knishioka/math-worksheet #67 → merged via PR #68, Quality Score A
    knishioka/kanji-practice #33 → merged via PR #34, Quality Score A
  Still open:
    knishioka/kanji-practice #31 — production Debug overlay entrypoint remains visible

Context from knowledge/CHANGELOG.md:
  Recent merged work includes kanji-practice PR #34 header customization, math-worksheet PRs #68/#69 for equation lines and harder Grade 4-6 English word problems, and cost-management-mcp PR #152 Security Scan hardening.
