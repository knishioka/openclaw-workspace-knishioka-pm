# Knowledge Changelog

As of: 2026-04-17

## This week’s new discoveries / updates

### knishioka/kanji-practice

- [2026-04-12] fix: 写経モードのふりがなをルビ注釈方式でゼロフォールバック化 (source: PR #24)
- [2026-04-11] feat: a11y改善（lang=ja / slider aria-label / 選択状態 / skip link） (source: PR #23)
- [2026-04-11] fix: ページ数が問題生成後にリセットされる問題を修正 (source: PR #22)

### knishioka/math-worksheet

- [2026-04-16] fix(fraction): 分数パターンがbasicテンプレにフォールバックしてA4から溢れる問題を修正 (source: PR #59)
- [2026-04-16] fix(hissan): 3桁×2桁のかけ算が2枚に分かれる問題と横線の幅を修正 (source: PR #58)
- [2026-04-12] feat: 数字なぞり書きプリント機能（幼児向け） (source: PR #56)

### knishioka/ib-sec-mcp

- [2026-04-11] fix(api): paginate positions and preserve connection errors in CPClient (source: PR #105)
- [2026-04-11] ci(security): fix gitleaks schedule failure on test dummy account IDs (source: PR #104)

### knishioka/freee-mcp

- [2026-04-16] refactor(schema): migrate tool registration to Zod 4 (source: PR #176)
- [2026-04-17] MCP TypeScript SDK latest is still **1.29.0** (`npm view @modelcontextprotocol/sdk version`). The repo just migrated its tool-registration layer to Zod 4, so the next leverage point is not core SDK churn but adopting newer protocol features on top of the stable SDK surface. (refs: npm view @modelcontextprotocol/sdk version, https://github.com/modelcontextprotocol/typescript-sdk)
- [2026-04-17] MCP spec 2025-06-18 adds **structured tool output**, **resource links**, **elicitation**, OAuth resource-server metadata, and stricter HTTP protocol-version signaling. For a finance/accounting MCP server, that points toward richer machine-readable report payloads and safer auth / clarification flows instead of only plain text responses. (ref: https://modelcontextprotocol.io/specification/2025-06-18/changelog)

### knishioka/english-note-maker

- [2026-04-16] feat: add phonics word-family practice mode (source: PR #23)
- [2026-04-11] fix(cloze): increase questions per page and hide notice from print (source: PR #21)
- [2026-04-11] feat(cloze): add fill-in-the-blank phrase practice mode (source: PR #20)

### knishioka/market-lens-studio

- [2026-04-17] fix(note): add Origin/Referer headers to login & remove redundant mkdir (source: PR #171)
- [2026-04-17] feat(retrospect): persist per-article generation metadata (source: PR #170)
- [2026-04-17] feat(ci): add weekly retrospective GitHub Actions workflow (source: PR #169)
- [2026-04-17] TradingView's feature surface keeps raising the baseline for market workspaces with many chart modalities (candles, range, Heikin Ashi, Renko, volume profile variants) aimed at fast noise reduction and intraday context switching. That suggests users increasingly expect analysis systems to preserve context, not just output one-off reports. (ref: https://www.tradingview.com/features/)
- [2026-04-17] Koyfin positions around **global coverage**, fast multi-asset overview, and comprehensive analysis in a single daily workspace. For this repo, the differentiator is automated insight-to-publication flow, but the competitive gap is a reusable analyst workspace layer that feeds the article generator. (ref: https://www.koyfin.com/features/)

### knishioka/workflow-engine

- [2026-04-16] fix(scripts): migrate sync_and_deploy.py from Secret Manager to GCS tokens.json (source: PR #144)

### knishioka/ut-gymnastics

- [2026-04-15] fix(nginx): server_name 修正 + ACME challenge 追加（証明書失効対応） (source: PR #148)
- [2026-04-15] fix(security): npm audit fix で high 脆弱性を解消 (#146) (source: PR #147)

### knishioka/jgrants-app

- [2026-04-15] feat(ai): Anthropic prompt caching for Claude routes (#94) (source: PR #96)

## New feature candidates (from competitive / trend research)

- freee-mcp: Add **structured-content responses** for ledger, KPI, aging, and comparison tools so clients can render tables/charts without reparsing text.
- freee-mcp: Add **resource links + elicitation** for follow-up workflows, for example linking related reports and asking for missing `companyId` / fiscal period before returning hard errors.
- market-lens-studio: Add **saved market-workspace snapshots** (watchlists, key charts, macro checklist, thesis notes) as first-class inputs to article generation and retrospectives.
- market-lens-studio: Add **alert-to-briefing workflows** that turn market events or screening hits into a draft article / X thread package with preserved cross-asset context.

## Staleness watch (priority=high)

- No priority=high repos exceeded 8 weeks without KB updates in this run.
