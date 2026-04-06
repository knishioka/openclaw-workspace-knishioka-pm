As of: 2026-04-06
Summary: RED 5 / YELLOW 1 / GREEN 4

>> Changes this month:
  cost-management-mcp: RED → GREEN (2026-03-28 に CI 修復、更新再開)
  english-note-maker: YELLOW → RED (94日 inactive で Abandoned 入り)
  math-worksheet: GREEN 維持 (3月末に Singapore Math + 検証層追加)
  freee-mcp: GREEN 維持 (3月末時点で 5日 inactive、分析系ツール群を拡張)

>> Risks / Blockers:
  ib-sec-mcp  CI failure 継続、RED 4週連続、open PR 4件
  simple-bookkeeping  85日 inactive だが open issue 37件 / open PR 8件 で過剰工数
  freee-mcp  active だが open PR 15件 でレビュー待ち滞留リスク
  english-note-maker  94日 inactive、単独維持だと投資対効果が低い
  td-mcp-server  245日 inactive、MCP群の中で最も長期停止
  meditation-chrome-extension  279日 inactive、直近需要の裏付けなし
  remotion-math-education  292日 inactive、単独プロダクトとして停止状態

>> Next actions:
  Portfolio: TypeScript MCP共通基盤の切り出しを検討（freee-mcp / cost-management-mcp の schema validation・tool registry・transport 対応）
  Portfolio: 教育系共通基盤の切り出しを検討（kanji-practice / math-worksheet / english-note-maker の印刷レイアウト検証・問題生成QA・URL設定共有）
  ib-sec-mcp: CI failure 解消を最優先、PR滞留を先に減らす
  simple-bookkeeping: 新規開発より backlog 圧縮を優先、Issue/PR の棚卸しが必要
  freee-mcp: 15 PR をテーマ別にまとめてレビューし、未着手PRの期限ルールを決める
  td-mcp-server: Archive 候補。復活条件は Treasure Data 利用再開 or Python MCP共通基盤化の対象になること
  meditation-chrome-extension: Archive 候補。復活条件は Chrome拡張再開ニーズ or offline音声資産の再利用先が明確になること
  remotion-math-education: Archive 候補。復活条件は教育動画配信ニーズの再発生 or worksheet系との連携要件が出ること
  english-note-maker: 即archiveまでは不要。maintenance-only 扱いにし、復活条件は家庭学習ニーズ再発生 or worksheet family 統合時

>> Confirmed:
  kanji-practice  15日前更新 GREEN
  math-worksheet  6日前更新 GREEN
  freee-mcp  6日前更新 GREEN
  cost-management-mcp  9日前更新 GREEN
  market-lens-studio  Active
  workflow-engine  Active
  household-finance  Active
  ut-gymnastics  Active
  jgrants-app  Abandoned
  line-advisor  Abandoned (on-hold)
  story-bridge  Abandoned (on-hold)

## Portfolio classification

### Public repos
- Active (<=30 days): kanji-practice, math-worksheet, ib-sec-mcp, freee-mcp, cost-management-mcp
- Dormant (31-90 days): simple-bookkeeping
- Abandoned (90+ days): english-note-maker, td-mcp-server, meditation-chrome-extension, remotion-math-education

### Private repos
- Active (<=30 days): market-lens-studio, workflow-engine, household-finance, ut-gymnastics
- Dormant (31-90 days): none
- Abandoned (90+ days): jgrants-app, line-advisor, story-bridge

## Cross-repo analysis

### 共通技術・統合機会
1. MCP server 共通基盤
   - freee-mcp / cost-management-mcp は TypeScript + MCP + zod + tool registry という共通構成。
   - 共通化候補: tool metadata 定義、runtime schema validation、stdio/HTTP transport、認証設定、CIテンプレート。
   - ib-sec-mcp / td-mcp-server を含めて「MCP server playbook」を docs/テンプレート化すると、新規MCP立ち上げと保守の再利用性が高い。

2. 教育系 worksheet 共通基盤
   - kanji-practice / math-worksheet / english-note-maker はいずれも印刷前提の Web UI で、A4収まり・ページング・問題生成品質が主要リスク。
   - 共通化候補: print layout checker、Playwright QA harness、URL/state schema、共有 UI controls、テンプレート別ページ計測。
   - math-worksheet の automated verification layer は他教育系にも移植価値が高い。

3. 検証文化の横展開
   - math-worksheet は property-based / Playwright 検証を先行導入。
   - kanji-practice は回帰テスト強化が進んでいる。
   - この2つのやり方を freee-mcp / cost-management-mcp の tool-level regression に横展開すると、MCP群の品質が安定しやすい。

### 過剰工数のリポ
- simple-bookkeeping: open issue 37 / open PR 8 に対して 85日 inactive。保守負債が最も重い。
- freee-mcp: open PR 15。開発は活発だがレビュー滞留が大きい。
- ib-sec-mcp: open PR 4 + CI failure 継続。実装速度に対して安定化が追いついていない。

## Abandoned repo recommendations
- english-note-maker: Archive ではなく maintenance-only 推奨。kanji/math と統合できる時だけ再投資。
- td-mcp-server: Archive 推奨。Treasure Data 利用再開か、Python MCP共通化の実験台が必要になったら復活。
- meditation-chrome-extension: Archive 推奨。瞑想体験を再開する明確な個人需要が出た時のみ復活。
- remotion-math-education: Archive 推奨。動画教材を本気でやる段階まで凍結でよい。

## Monthly PM retrospective
- 今月の正の変化は、cost-management-mcp の CI復旧と、math-worksheet / kanji-practice の教育品質改善。
- 今月の構造問題は、MCP群と教育系で似た基盤を個別実装していること、そして simple-bookkeeping / freee-mcp の backlog 圧力。
- 来月は「新規着手を増やす」より「共通基盤化と backlog 圧縮」に寄せた方が、ポートフォリオ全体の効率が上がる。