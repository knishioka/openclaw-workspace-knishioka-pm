As of: 2026-05-10
Summary: RED 4 / YELLOW 0 / GREEN 6

No new repo regressions this week. `cost-management-mcp` recovered to GREEN after the fast-xml-parser security fix, but `kanji-practice` still exposes the production `Debug` entrypoint already tracked in Issue #31.

>> Changes this week:
  knishioka/cost-management-mcp: RED → GREEN (PR #150 merged on 2026-05-04, CI/security failure cleared)

>> Risks / Blockers:
  knishioka/kanji-practice  Production preview still shows `Debug` button in public UI; reproduced again on 2026-05-10 weekly QA. Existing Issue #31 remains open, so no duplicate created.
  knishioka/simple-bookkeeping  120 days inactive, 37 open issues, 8 open PRs [RED 5週連続]
  knishioka/td-mcp-server  280 days inactive, effectively abandoned backlog [RED 9週連続]
  knishioka/meditation-chrome-extension  314 days inactive, no active CI signal [RED 9週連続]
  knishioka/remotion-math-education  327 days inactive, no active CI signal [RED 9週連続]

>> Next actions:
  knishioka/kanji-practice: hide production Debug overlay entrypoint → Issue #31 pending
  knishioka/cost-management-mcp: review open PR #152 (TruffleHog refs robustness) now that repo health is GREEN → pending
  knishioka/simple-bookkeeping: no new issue due dormant policy; keep suppressed unless status changes → pending

>> Confirmed:
  knishioka/kanji-practice  GREEN, 8日前更新, page-count QA passed for 1/5/10 pages, but Debug button still visible
  knishioka/math-worksheet  GREEN, 今日更新, 30問3列レイアウトと non-negative subtraction spot check passed
  knishioka/ib-sec-mcp  GREEN, 9日前更新, earnings calendar feature merged this week and CI remains healthy
  knishioka/freee-mcp  GREEN, 4日前更新, Vitest migration merged this week and CI remains healthy
  knishioka/cost-management-mcp  GREEN, 6日前更新, security fix landed and RED recovered
  knishioka/english-note-maker  GREEN, 6日前更新, 5/10 page preview QA and spelling spot check passed

## Demo Site QA

- knishioka/kanji-practice: `reports/site-qa/2026-05-10/kanji-practice.png`
  - 1 / 5 / 10 page generation counts matched expected output
  - 1年生 読み練習 spot check did not show obvious grade-range contamination
  - `Debug` button is still visible in production, matching open Issue #31
- knishioka/math-worksheet: `reports/site-qa/2026-05-10/math-worksheet.png`
  - default 30-question 3-column worksheet rendered cleanly
  - 1桁のひき算（繰り下がりなし）30問 spot check found no negative results
- knishioka/english-note-maker: `reports/site-qa/2026-05-10/english-note-maker.png`
  - 5-page and 10-page preview flows rendered expected repeated page headers
  - phrase spelling spot check passed (`How have you been?`, `Congratulations!`, `Excuse me.`)

## Issue Tracker

### Resolved / Updated this week

- knishioka/cost-management-mcp Issue #149: merged via PR #150 on 2026-05-04, Quality Score A
- knishioka/freee-mcp Issue #179: merged via PR #180 on 2026-05-05, Quality Score A

### Still open

- knishioka/kanji-practice Issue #31 (`bugfix`): production Debug overlay still reproducible
- knishioka/cost-management-mcp Issue #151 (`maintenance`): PR #152 open, verification already green

### Quality Score Summary (all-time)

- A: 14
- B: 0
- C: 0
- Open: 2

## Context from knowledge/CHANGELOG.md

- `cost-management-mcp` recovery aligns with `fix(security): override vulnerable fast-xml-parser (#150)` merged on 2026-05-04.
- `math-worksheet` and `english-note-maker` both shipped worksheet/tracing improvements this week, and no new QA regressions were found in this run.
- `kanji-practice` merged the harness pack Phase B PoC on 2026-05-02, but the older production Debug UI bug is still present.
