# Focus Task Report — 2026-06-15

As of: 2026-06-15
Summary: 0 issues created, 0 PRs created

>> Pre-check result:
  open PM-created issues tracked in monitoring/issue-tracker.jsonl = 3 (`freee-mcp` #193, `english-note-maker` #35, `cost-management-mcp` #164), so the hard stop triggered
  total open tracker items = 5 including QA backlog (`kanji-practice` #31, #35)
  30-day resolve rate = 2/6 = 33.3%, which would also force priority-review mode even without the hard stop
  last 4 focus-task perspective ratio = PM:Dev 3:3
  feature-priority override not triggered; the last 4 focus-task runs already included feature work

>> Open backlog summary:
  P1: knishioka/cost-management-mcp #164 `maintenance: complete TypeScript 6 migration without deprecated moduleResolution`
    perspective: dev
    subtype: maintenance
    created: 2026-06-08
    reason: newest unresolved dev issue on an active MCP repo; TypeScript 6 migration remains blocked and still has the clearest path to unlock the queue

  P2: knishioka/freee-mcp #193 `maintenance: make the TypeScript 6 upgrade branch CI-green`
    perspective: dev
    subtype: maintenance
    created: 2026-05-25
    reason: same TS6 adoption theme, older than #164, and still unresolved after the previous auto-resolve failed before playbook start

  P3: knishioka/english-note-maker #35 `feature: persist and manage custom sentence examples for repeat classroom use`
    perspective: pm
    subtype: feature
    created: 2026-05-25
    reason: still the only open PM-side product issue, but urgency is lower than the blocked dev maintenance items above

  P4: knishioka/kanji-practice #35 `bugfix: 低学年プリントの例語に学年範囲外の漢字を出さない`
    perspective: qa
    subtype: bugfix
    created: 2026-05-24
    reason: education-quality issue remains open, but it is outside the PM/dev balancing gate used for this cron's hard stop

  P5: knishioka/kanji-practice #31 `bugfix: hide Debug overlay entrypoint from production preview`
    perspective: qa
    subtype: bugfix
    created: 2026-04-26
    reason: oldest open tracker item, but lower impact than the TypeScript migration backlog and already deprioritized in earlier runs

>> Tech radar / carry-over:
  no new PM/dev candidate scan executed because the hard stop triggered before backlog generation
  the carry-over theme is still TypeScript 6 adoption across MCP repos; both open dev issues point to the same migration wave and should be cleared before new issue creation resumes

>> Blocking pattern:
  the unresolved PM/dev backlog is concentrated in runs where `scripts/codex-resolve.sh` aborted before playbook start
  recorded failure mode: `codex login status` was not authenticated on 2026-05-25 and 2026-06-08
