# Monthly Portfolio Review (2026-04)

As of: 2026-04-12
Summary: RED 5 / YELLOW 1 / GREEN 4

>> Changes this month:
- cost-management-mcp: RED → GREEN（2026-03-28 に復旧、CI修復PR #147 が即日マージ）
- english-note-maker: 4月上旬は RED 域だったが、2026-04-11 に再始動し Active に復帰
- kanji-practice / ib-sec-mcp: PM起票Issue が 2026-04-11 に解決、直近の改善サイクルは機能している
- Public portfolio: 現在は Active 6 / Dormant 1 / Abandoned 3 に再編

>> Risks / Blockers:
- freee-mcp  open PR 15件でWIP過多。機能追加より統合・棚卸し優先。
- simple-bookkeeping  76日無更新 + open issue 37件 / open PR 8件。最も過剰工数の兆候が強い。
- td-mcp-server  252日無更新。用途再確認が取れない限り archive 寄り。
- meditation-chrome-extension / remotion-math-education  286日超無更新。現ポートフォリオの主戦場から外れている。

>> Next actions:
- MCP横断: freee-mcp / cost-management-mcp / ib-sec-mcp / td-mcp-server の共通基盤候補を整理する
- 教育系横断: kanji-practice / math-worksheet / english-note-maker の印刷QA・設定共有・復習導線を共通化候補として整理する
- freee-mcp / simple-bookkeeping: 4月後半は新規拡張よりWIP圧縮を優先する
- Abandoned public repos: 下記の復活条件を満たさなければ段階的に archive 判断へ進める

>> Confirmed:
- kanji-practice  最終更新0日前 Active
- math-worksheet  最終更新0日前 Active
- ib-sec-mcp  最終更新1日前 Active
- freee-mcp  最終更新11日前 Active
- cost-management-mcp  最終更新15日前 Active
- english-note-maker  最終更新0日前 Active

## 1. Portfolio classification

### Public repos

#### Active (30日以内にコミットあり)
- knishioka/kanji-practice — 0日
- knishioka/math-worksheet — 0日
- knishioka/ib-sec-mcp — 1日
- knishioka/freee-mcp — 11日
- knishioka/cost-management-mcp — 15日
- knishioka/english-note-maker — 0日

#### Dormant (30-90日)
- knishioka/simple-bookkeeping — 76日

#### Abandoned (90日+)
- knishioka/td-mcp-server — 252日
- knishioka/meditation-chrome-extension — 286日
- knishioka/remotion-math-education — 298日

### Private repos

> Private repos are listed by name + classification only.

- knishioka/market-lens-studio — Active
- knishioka/workflow-engine — Active
- knishioka/household-finance — Dormant
- knishioka/ut-gymnastics — Dormant
- knishioka/jgrants-app — Abandoned

### On-hold (excluded from recommendations / notifications)
- knishioka/line-advisor — on-hold / Abandoned
- knishioka/story-bridge — on-hold / Abandoned

## 2. Past-month trend (from monitoring/health-trend.jsonl)

- 観測期間の public health は **GREEN 3 / YELLOW 2 / RED 5**（2026-03-27）から **GREEN 4 / YELLOW 1 / RED 5**（2026-04-05）へ改善
- 最大の改善は **cost-management-mcp**。143日停滞の RED から復帰した
- 最大の悪化は **english-note-maker**。4月上旬時点では 94日無更新で RED 化したが、その後 2026-04-11 に再始動
- 月間を通して RED が続いたのは **ib-sec-mcp / td-mcp-server / meditation-chrome-extension / remotion-math-education**
- **simple-bookkeeping** は月間通して backlog 圧が高いまま YELLOW 維持

## 3. Cross-repo analysis

### 3.1 Common technology / integration opportunities

#### A. MCP server common foundation
Target repos:
- freee-mcp
- cost-management-mcp
- ib-sec-mcp
- td-mcp-server

Observed commonality:
- MCP server という共通ドメイン
- tool metadata, schema validation, transport, auth/config, CI の反復実装が多い
- TypeScript系とPython系に分かれているが、運用観点の共通ルールはまとめられる

Integration opportunity:
- 共通MCP checklist / template を整備
- 含める項目: tool命名規約, 設定schema, transport方針, テストマトリクス, docs/release運用

Expected payoff:
- 新規MCP repo の立ち上げを短縮
- 仕様変更追従を横断でやりやすくする
- PM Issue の acceptance criteria を共通化できる

#### B. Education worksheet common foundation
Target repos:
- kanji-practice
- math-worksheet
- english-note-maker
- remotion-math-education（adjacent only）

Observed commonality:
- A4印刷前提のブラウザ生成
- レイアウト崩れ検知、ページ収まり、設定保存、問題再生成の課題が共通
- KB上でも print QA と generator correctness への投資が重複している

Integration opportunity:
- 共通 worksheet core 候補:
  - print layout QA harness
  - URL/state 永続化パターン
  - 生成結果の回帰チェック
  - 「間違えた問題を再生成」系の復習導線

Expected payoff:
- 教育系リポの UX/品質を横断で底上げできる
- 新しい教材アプリを増やす時の初速が上がる
- ポートフォリオとしての一貫性が強くなる

### 3.2 Repos with likely over-investment / excessive work-in-progress

- **freee-mcp**: open PR 15件。最もレビュー滞留コストが高い。
- **simple-bookkeeping**: open issue 37件 / open PR 8件。再始動前に棚卸しが必要。
- **ib-sec-mcp**: open PR 4件。改善速度は高いが、安定化とのバランス管理が必要。

Recommendation:
- 4月後半は「新規着手」より「WIP圧縮」を優先
- 目安として open PR > 10 または open issue > 30 は feature 拡張より整理を優先

## 4. Abandoned public repos: archive recommendation / revival conditions

### knishioka/td-mcp-server
Recommendation:
- **archive 寄り**。他MCP群と比べて直近の事業/学習上の軸が弱い。

Revival conditions:
- Treasure Data を使う明確なユースケースが戻る
- MCP共通基盤化の検証対象として再利用する

Archive trigger:
- 次回月次レビューでも用途が曖昧なら archive 推奨

### knishioka/meditation-chrome-extension
Recommendation:
- **archive 推奨**。現ポートフォリオの中心領域と接続が薄い。

Revival conditions:
- 個人利用が続いていて、オフライン拡張として再開理由がある
- Chrome extension の実験枠として位置づけ直す

### knishioka/remotion-math-education
Recommendation:
- **archive 寄り**。教育テーマとの接続はあるが、現行の worksheet 系と開発トラックが分離している。

Revival conditions:
- 動画教材を出す明確な教育戦略が立つ
- worksheet 系から派生する動画需要が確認される

## 5. PM retrospective (issue quality loop)

Source: monitoring/issue-tracker.jsonl

- 4月レビュー時点で PM 起票6件は **全件 merged / quality score A**
  - ib-sec-mcp #103
  - cost-management-mcp #146
  - kanji-practice #20
  - kanji-practice #21
  - math-worksheet #48
  - english-note-maker #19
- 平均解決日数は約 **9.3日**
- maintenance / bugfix だけでなく feature も resolve-issue-ready 品質を維持できた

Takeaway:
- PM Issue の品質は十分高い
- 4月後半は新規Issue増加より、 backlog が大きい repo の整理テーマに絞る方が良い

## 6. Overall judgment

- 主戦場は引き続き **教育アプリ群** と **MCPサーバ群**
- 今月の実態は「分散」より **収束**。english-note-maker の再始動で教育系3本のまとまりも強くなった
- 次の一手は **共通基盤化 + WIP圧縮 + archive判断の明確化**
- 現時点の注力候補は次の7本:
  - kanji-practice
  - math-worksheet
  - english-note-maker
  - freee-mcp
  - cost-management-mcp
  - ib-sec-mcp
  - simple-bookkeeping
