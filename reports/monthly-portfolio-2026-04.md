# Monthly Portfolio Review (2026-04)

As of: 2026-04-07
Summary: RED 5 / YELLOW 1 / GREEN 4

>> Changes this month:
- cost-management-mcp: RED → GREEN（143日停滞から復帰、2026-03-28 に修復PR #147が即日マージ）
- english-note-maker: YELLOW → RED（95日無更新で Abandoned 域に到達）
- math-worksheet: GREEN 維持（2026-03-29〜31 に検証強化 + Singapore Math 拡張）
- freee-mcp: GREEN 維持（2026-03-06 以降の分析系ツール群を維持、ただし open PR 15件で滞留）

>> Risks / Blockers:
- ib-sec-mcp  CI failure が継続、RED 維持。直近16日以内に開発はあるが品質ゲート未回復。
- simple-bookkeeping  71日無更新 + open issue 37件 / open PR 8件で過剰WIP。再始動前に棚卸しが必要。
- english-note-maker  95日無更新。教育系ポートフォリオ内で役割が kanji-practice / math-worksheet と重複し始めている。
- td-mcp-server  247日無更新。Treasure Data 需要が明確でない限り保守コストに見合いにくい。
- meditation-chrome-extension / remotion-math-education  280日超無更新。用途が限定的で、現ポートフォリオの主戦場から外れている。

>> Next actions:
- Portfolio横断: 教育系3リポ（kanji-practice / math-worksheet / english-note-maker）の共通A4印刷QA・設定共有・URL永続化を共通基盤候補として整理する
- MCP横断: freee-mcp / cost-management-mcp / ib-sec-mcp / td-mcp-server で、tool metadata・transport・認証・テスト方針を共通化できるか検討する
- freee-mcp: 新規機能追加より先に open PR 15件の整理を優先する
- simple-bookkeeping: Issue/PR を棚卸しし、メンテ継続か凍結かを判断する
- Abandoned public repos: 下記の復活条件を満たさなければ段階的に archive 候補へ

>> Confirmed:
- kanji-practice  最終更新16日前 GREEN
- math-worksheet  最終更新6日前 GREEN
- freee-mcp  最終更新6日前 GREEN
- cost-management-mcp  最終更新10日前 GREEN

## 1. Portfolio classification

### Public repos

#### Active (30日以内にコミットあり)
- knishioka/kanji-practice — 16日
- knishioka/math-worksheet — 6日
- knishioka/ib-sec-mcp — 16日
- knishioka/freee-mcp — 6日
- knishioka/cost-management-mcp — 10日

#### Dormant (30-90日)
- knishioka/simple-bookkeeping — 71日

#### Abandoned (90日+)
- knishioka/english-note-maker — 95日
- knishioka/td-mcp-server — 247日
- knishioka/meditation-chrome-extension — 281日
- knishioka/remotion-math-education — 293日

### Private repos

> Private repos are listed by name + classification only.

- knishioka/market-lens-studio — Active
- knishioka/workflow-engine — Active
- knishioka/household-finance — Active
- knishioka/ut-gymnastics — Active
- knishioka/jgrants-app — Abandoned

### On-hold (excluded from recommendations / notifications)
- knishioka/line-advisor — on-hold
- knishioka/story-bridge — on-hold

## 2. Past-month trend (from monitoring/health-trend.jsonl)

- Public portfolio status moved from **GREEN 3 / YELLOW 2 / RED 5** (2026-03-27) to **GREEN 4 / YELLOW 1 / RED 5** (2026-04-05)
- Biggest positive change: **cost-management-mcp** recovered from long inactivity + CI failure to GREEN after PR #147
- Biggest negative change: **english-note-maker** crossed from YELLOW to RED as inactivity reached 94-95 days
- Persistent RED through the month: **ib-sec-mcp, td-mcp-server, meditation-chrome-extension, remotion-math-education**
- Persistent load concentration: **simple-bookkeeping** remained YELLOW while backlog stayed very large

## 3. Cross-repo analysis

### 3.1 Common technology / integration opportunities

#### A. MCP server common foundation
Target repos:
- freee-mcp
- cost-management-mcp
- ib-sec-mcp
- td-mcp-server

Observed commonality:
- All four are MCP servers
- freee-mcp / cost-management-mcp already share TypeScript + schema-driven tool patterns
- ib-sec-mcp / td-mcp-server share Python MCP/server patterns
- Recent KB entries show repeated work around tool exposure, validation, testing, and transport expectations

Integration opportunity:
- Shared MCP checklist/template covering:
  - tool metadata conventions
  - auth/config schema validation
  - transport options (stdio now, Streamable HTTP later where useful)
  - common CI/test matrix
  - release / docs / agent-operability conventions

Expected payoff:
- Less repeated setup work across new MCP repos
- Easier maintenance when MCP spec evolves
- Faster issue creation because acceptance criteria can point to a common standard

#### B. Education print-app common foundation
Target repos:
- kanji-practice
- math-worksheet
- english-note-maker
- remotion-math-education（adjacent only）

Observed commonality:
- Repeated A4 print-layout concerns
- Repeated generator correctness / content-validation work
- Browser-based printable learning material generation
- Recent KBs show duplicated investment in layout fitting, regression checks, and generation controls

Integration opportunity:
- Shared “worksheet core” candidate:
  - print layout QA harness
  - common page-size / overflow checks
  - shared URL-based settings model
  - reusable print preview / export utilities

Expected payoff:
- Reduces repeated CSS/layout debugging
- Makes future education tools easier to spin up
- Creates a clearer portfolio story than separate standalone mini-apps

### 3.2 Repos with likely over-investment / excessive work-in-progress

- **freee-mcp**: open PR 15件。機能密度は高いが、レビュー待ち/統合待ちの滞留コストが大きい。
- **simple-bookkeeping**: open issue 37件 / open PR 8件。最も backlog pressure が高い。
- **ib-sec-mcp**: open PR 4件 + CI failure。新機能速度に対して安定化が追いついていない。

Recommendation:
- 4月は「新規着手」より「WIP圧縮」を優先する
- 目安: open PR > 10 または open issue > 30 のリポは feature 拡張より整理を優先

## 4. Abandoned public repos: archive recommendation / revival conditions

### knishioka/english-note-maker
Recommendation:
- **即archiveはしない**。教育系ポートフォリオとのシナジーがまだあるため、Q2中は復活判断を保留。

Revival conditions:
- kanji-practice / math-worksheet と共通化できる印刷基盤の切り出し先として使う
- 罫線ノート需要が再確認される
- 既存 open issue を起点に 1PR で改善できる明確テーマがある

Archive trigger:
- 2026-Q2 末までに再開がなければ archive 候補

### knishioka/td-mcp-server
Recommendation:
- **archive 寄り**。需要再確認が取れない限り保守優先度は低い。

Revival conditions:
- Treasure Data を使う明確な業務/個人ユースケースが再発生
- 他MCPリポと共通基盤化する実験対象として意味がある

Archive trigger:
- 次回月次レビュー時点でも用途が不明なら archive 推奨

### knishioka/meditation-chrome-extension
Recommendation:
- **archive 推奨**。現ポートフォリオの中核テーマから外れている。

Revival conditions:
- 個人利用が継続しており、オフライン拡張として再開する明確理由がある
- Chrome拡張の学習/実験枠として再定義する

### knishioka/remotion-math-education
Recommendation:
- **archive 寄り**。教育テーマとの接続はあるが、現行の印刷教材群と開発トラックが分かれている。

Revival conditions:
- 動画教材を配布する明確な教育戦略が立つ
- worksheet系から派生する動画生成ニーズが確認される

## 5. PM retrospective (issue quality loop)

Source: monitoring/issue-tracker.jsonl

- 4月レビュー時点の resolved PM issues: 2件
  - cost-management-mcp #146 → merged same day, score A
  - math-worksheet #48 → merged in 1 day, score A
- open PM issues still pending: ib-sec-mcp #103, kanji-practice #20/#21, english-note-maker #19

Takeaway:
- maintenance / bugfix 系は resolve-issue-ready 品質が高い
- 4月は backlog の多い repo で新規 Issue を増やすより、既存 PM issue の処理率を優先した方がよい

## 6. Overall judgment

- Public portfolioの主戦場は **教育アプリ群** と **MCPサーバ群** に収束している
- 4月の戦略は「新規分散」ではなく **共通基盤化 + WIP圧縮 + abandoned整理** が妥当
- archive 候補を明確にしたことで、注力対象は次の6本に絞れる:
  - kanji-practice
  - math-worksheet
  - freee-mcp
  - cost-management-mcp
  - ib-sec-mcp
  - simple-bookkeeping
