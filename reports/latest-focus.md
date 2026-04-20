As of: 2026-04-20
Summary: RED 5 / YELLOW 2 / GREEN 3

>> Changes this week:
  knishioka/kanji-practice: GREEN → ACTION (learner-context に沿う学習プリセット MVP を feature として起票, Issue #25 / draft PR #26)
  knishioka/ib-sec-mcp: YELLOW → ACTION (FastMCP 3 追従が maintenance 課題として確定, Issue #111 / draft PR #112)

>> Risks / Blockers:
  Dynamic frequency check: open_pm_issues=0, last30_total=8, last30_resolved=8, resolve_rate=1.00 → Issue creation allowed, max 2 this run
  Perspective balance before selection: PM:Dev = 3:1 over the last 4 focus-task issues, so this run forced a 1 PM + 1 Dev split
  kanji-practice main worktree had local modifications, so auto-resolve was isolated in /tmp/kanji-practice-issue-25
  ib-sec-mcp main worktree also had local state, so auto-resolve was isolated in /tmp/ib-sec-mcp-issue-111

>> Next actions:
  knishioka/kanji-practice: feat: 学習プリセット（9級読み・9級書き取り・8級先取り）を追加 → Issue #25 created, draft PR #26 created
  knishioka/ib-sec-mcp: maintenance: FastMCP 3系へ追従し内部API依存テストを解消する → Issue #111 created, draft PR #112 created
  knishioka/kanji-practice: verify draft PR #26 in review, especially preset wording, localStorage compatibility, and print layout
  knishioka/ib-sec-mcp: verify draft PR #112 in review, especially FastMCP 3 public API compatibility and warning noise left outside this scope

>> Confirmed:
  knishioka/kanji-practice  npm run test:unit / build / check 通過, draft PR #26 open
  knishioka/ib-sec-mcp  uv run pytest 890 passed, coverage 55.97%, draft PR #112 open

## Created this run
- knishioka/kanji-practice Issue #25, draft PR #26
  - perspective: pm
  - subtype: feature
  - title: feat: 学習プリセット（9級読み・9級書き取り・8級先取り）を追加
- knishioka/ib-sec-mcp Issue #111, draft PR #112
  - perspective: dev
  - subtype: maintenance
  - title: maintenance: FastMCP 3系へ追従し内部API依存テストを解消する

## Dynamic frequency decision
- open PM issues: 0
- last 30 days created: 8
- last 30 days resolved: 8
- resolve rate: 1.00
- decision: normal capacity, up to 2 issues

## Perspective ratio
- recent 4 focus-task issues before this run: PM:Dev = 3:1
- this run selection: PM 1 + Dev 1

## Tech Radar notes
- FastMCP 3 is mature enough to adopt now, and removing test dependence on private internals materially lowers future MCP upgrade risk
- GitHub Actions runner support is deprecating Node 20, so MCP and CI repos should keep runtime and action versions under periodic review
- Astral's uv GitHub Actions integration is increasingly the default Python workflow path, but this run kept scope on FastMCP compatibility only
