As of: 2026-05-05
Summary: Active 10 / Dormant 1 / Abandoned 6

PM judgment: ポートフォリオ全体は「教育プロダクト群 + MCP群」が前進中。整理対象は、長期停止した public リポと backlog が重すぎる 2 リポです。

## 1. Portfolio snapshot

### Active (30日以内にコミット)
- knishioka/kanji-practice, 3日前, education, public
- knishioka/math-worksheet, 1日前, education, public
- knishioka/ib-sec-mcp, 4日前, mcp, public
- knishioka/freee-mcp, 2日前, mcp, public
- knishioka/cost-management-mcp, 2日前, mcp, public
- knishioka/english-note-maker, 1日前, education, public
- knishioka/market-lens-studio, 1日前, private
- knishioka/workflow-engine, 3日前, private
- knishioka/ut-gymnastics, 20日前, private
- knishioka/jgrants-app, 20日前, private

### Dormant (30-90日)
- knishioka/household-finance, 57日前, private

### Abandoned (90日以上)
- knishioka/simple-bookkeeping, 100日前, fintech, public
- knishioka/td-mcp-server, 275日前, mcp, public
- knishioka/meditation-chrome-extension, 309日前, tool, public
- knishioka/remotion-math-education, 321日前, education, public
- knishioka/line-advisor, 293日前, private, on-hold
- knishioka/story-bridge, 312日前, private, on-hold

## 2. Past-month trend (from monitoring/health-trend.jsonl)

- Public monitored set improved in mid-April: 2026-04-05 was GREEN 4 / YELLOW 1 / RED 5, while 2026-04-12 through 2026-04-26 held at GREEN 6 / RED 4.
- Early May slipped slightly to GREEN 5 / RED 5 because `cost-management-mcp` regressed from GREEN to RED on CI while still remaining actively developed.
- `ib-sec-mcp` recovered from RED to GREEN during April and stayed active.
- `english-note-maker` also recovered from stale/RED state into active GREEN during April.
- `simple-bookkeeping` crossed the 90-day inactivity line during April and is now operationally abandoned, with backlog still heavy.
- The long-idle public pool (`td-mcp-server`, `meditation-chrome-extension`, `remotion-math-education`) remained unchanged throughout the month.

## 3. Cross-repo analysis

### Common technology / integration opportunities
1. MCP共通基盤の抽出余地が大きい
   - `freee-mcp`, `cost-management-mcp`, `ib-sec-mcp`, `td-mcp-server` はいずれも「tool-per-capability」「schema validation」「外部API adapter」という似た形。
   - 共通化候補: structured output helper, auth/config validation, error taxonomy, CI/security workflow, long-running task pattern。
   - 特に KB 上で `freee-mcp` は structured output を先行導入、`ib-sec-mcp` は structured output / elicitation の導入余地が明確。ここを横展開できる。

2. 教育系プリント生成の共通プロダクト面が見えている
   - `kanji-practice`, `math-worksheet`, `english-note-maker` は全て A4 print-first generator。
   - 共通化候補: preset/share URL, layout verifier, printable component primitives, cumulative review / spaced retrieval preset。
   - `remotion-math-education` の「動画化」自体は止まっているが、学習コンテンツ資産は education cluster に再利用可能。

3. 学習理論ベースの差別化が education 群の共通テーマ
   - `kanji-practice` と `math-worksheet` の KB では、どちらも spaced / interleaved / retrieval practice が次の差別化軸として繰り返し出ている。
   - 単発プリント生成ではなく、復習混在プリセットや progression flow を cluster 横断で設計すると再利用効率が高い。

### Repos with excessive maintenance load
- `simple-bookkeeping`: open issues 37, open PRs 8。活動停止に対して backlog が重すぎる。
- `freee-mcp`: open issues 2, open PRs 17。活発だが PR 滞留が大きく、レビュー待ち負債が蓄積している。
- `ib-sec-mcp`: open PRs 5。まだ制御可能だが、活発さに対してやや積み上がり始めている。

## 4. Abandoned public repos: archive / revival conditions

### Recommend archive
- `knishioka/td-mcp-server`
  - 理由: 9か月超停止、直近の merged PR signal なし、MCP共通基盤の本流は `freee-mcp` / `cost-management-mcp` / `ib-sec-mcp` 側に移っている。
  - 復活条件: Treasure Data を実際に再利用する明確な案件が出ること、または MCP 共通基盤抽出の検証先として必要になること。

- `knishioka/meditation-chrome-extension`
  - 理由: 10か月超停止、未消化 backlog もなく、現ポートフォリオの中心テーマから外れている。
  - 復活条件: Chrome 拡張の個人利用ニーズが再発し、Manifest V3 対応や音声UX改善をやる具体目的があること。

- `knishioka/remotion-math-education`
  - 理由: ほぼ初期実験のまま停止。教育資産は `math-worksheet` 側に寄せた方が現状の勝ち筋に合う。
  - 復活条件: 「印刷物ではなく動画教材が必要」という明確な配布チャネルや利用者仮説が立つこと。

### Archive unless a tight restart plan is chosen
- `knishioka/simple-bookkeeping`
  - 理由: 100日停止に加え、open issues 37 / open PRs 8 で保守負債が大きい。現状は active product というより backlog warehouse。
  - 復活条件: (1) 対象ユーザーを自分用の青色申告に再限定, (2) backlog を 1テーマに圧縮, (3) まず PR と Issue を大幅整理して 30日以内に小さく再始動すること。

## 5. Recommended portfolio focus for next month

1. MCP群は「機能追加」より共通化と backlog 整理を優先
   - `freee-mcp` の PR滞留圧縮
   - `cost-management-mcp` の CI安定化
   - `ib-sec-mcp` を structured output / safer tool UX の先行実装候補にする

2. Education群は shareability と review generation に寄せる
   - `kanji-practice` / `math-worksheet` / `english-note-maker` で preset, review flow, printable QA の共通思想を揃える

3. 停止 public リポは減らす
   - 最低でも `td-mcp-server`, `meditation-chrome-extension`, `remotion-math-education` の archive 判断を今月中に行う
   - `simple-bookkeeping` は revive するなら再始動条件を先に決める

## 6. Confirmed
- Public active leaders are `kanji-practice`, `math-worksheet`, `ib-sec-mcp`, `freee-mcp`, `cost-management-mcp`, `english-note-maker`.
- Private portfolio remains active overall, but details are intentionally omitted here beyond names and classification.
