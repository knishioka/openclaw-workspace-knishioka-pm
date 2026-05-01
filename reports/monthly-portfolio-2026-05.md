# Monthly Portfolio Review — 2026-05

As of: 2026-05-01
Period: 2026-04-01 → 2026-05-01

Summary (public repos): GREEN 6 / YELLOW 0 / RED 4
Summary (private repos): GREEN 4 / YELLOW 1 (household-finance) / on-hold 2

---

## Portfolio Classification

### Active (< 30 days inactive)

| Repo | Days Inactive | Status | Notes |
|------|--------------|--------|-------|
| kanji-practice | 5 | GREEN | 学習プリセット・フォント改善・写経深化 |
| math-worksheet | 5 | GREEN | 幼児向け数字なぞり書き・URL state 追加 |
| english-note-maker | 5 | GREEN | フォニックスモード・穴埋め改善 |
| ib-sec-mcp | 10 | GREEN | FastMCP 3.x 移行完了 |
| freee-mcp | 10 | GREEN | structured output 初実装、Zod 4 移行 |
| cost-management-mcp | ~35 | GREEN | CI 修復済み、ほぼ安定 |
| *market-lens-studio* | 11 | GREEN | weekly retrospective CI 稼働中 |
| *workflow-engine* | 1 | GREEN | LLM Sonnet 4.6 更新済み |
| *ut-gymnastics* | 14 | GREEN | SSL 証明書・セキュリティ修復 |
| *jgrants-app* | 14 | GREEN | Anthropic prompt caching 導入 |

### Dormant (30–90 days inactive)

| Repo | Days Inactive | Status | Notes |
|------|--------------|--------|-------|
| *household-finance* | 51 | YELLOW | 最終コミット 2026-03-09 |

### Abandoned (> 90 days inactive)

| Repo | Days Inactive | Notes |
|------|--------------|-------|
| simple-bookkeeping | ~96 | open issues 30件, open PRs 8件 |
| td-mcp-server | ~271 | open PRs 2件 (stale) |
| meditation-chrome-extension | ~305 | 活動なし |
| remotion-math-education | ~318 | 活動なし |

*on-hold: line-advisor, story-bridge (除外)*

---

## Changes This Month (April 2026)

- **ib-sec-mcp**: RED → GREEN（FastMCP 3.x 移行, CI 修復 × 2）
- **english-note-maker**: RED → GREEN（フォニックスモード追加 PR#23）
- **cost-management-mcp**: RED → GREEN (3/28 CI 修復)
- **simple-bookkeeping**: YELLOW → RED (92日→106日 非活性)

---

## Risks / Blockers

- **simple-bookkeeping** RED 3週連続 + open issue 30件 + PR 8件が放置
  - priority=medium、外部ユーザーなし → 月次レビューでアーカイブ推奨対象
- **freee-mcp**: open PR 15件の PR バックログが解消されていない
  - 高品質な実装が積み上がっているが main への統合率が低い
  - Ken の PR review が bottleneck の可能性
- **cost-management-mcp**: days_inactive が 35日に近づいてきた
  - open issue 3件 + open PR 3件が停滞

---

## Abandoned Repo Analysis

### td-mcp-server (271日 inactive)
- Treasure Data との公式関係なし、外部ユーザーなし、Issues なし
- Open PR 2件 (stale): そのまま放置
- **推奨: アーカイブ。復活条件なし。** Ken 承認待ち。

### meditation-chrome-extension (305日 inactive)
- Issues/PR なし、ロードマップなし、ユーザー需要シグナルなし
- **推奨: アーカイブ。** Ken 承認待ち。

### remotion-math-education (318日 inactive)
- math-worksheet が同等の教育ニーズをカバー（機能的に superseded）
- Issues/PR なし
- **推奨: アーカイブ。** Ken 承認待ち。

### simple-bookkeeping (96日 inactive)
- 30件の open issues、8件の open PRs（旧開発 run 由来）
- repos.yaml は `status: dormant` だが実態は abandoned 相当
- 個人確定申告ツールとして潜在価値はあるが、household-finance + freee-mcp で補完可能
- **推奨: `status: abandoned` に変更 + stale PR/Issue を整理。** Ken 承認後に実施。

---

## Cross-Repo Analysis

### 共通基盤: Education Sites

3 サイト（kanji-practice, math-worksheet, english-note-maker）の共通実装機会:

| 共通要素 | 現状 | 統合機会 |
|----------|------|----------|
| A4 レイアウトエンジン | 各リポで独立実装 | shared util ライブラリ化 |
| 難易度プリセット定義 | kanji に learner preset 実装済み | math/english にも同パターン適用可能 |
| spaced retrieval | kanji で concept 浮上 | math でも cumulative review preset が自然 |

→ ただし 3 リポが別 GitHub Pages として独立動作しているため、統合のコストが高い。現時点では KB に知見を蓄積して個別改善を続けるのが現実的。

### 共通基盤: MCP Ecosystem

3 サーバー（ib-sec-mcp, freee-mcp, cost-management-mcp）の共通観察:

| 要素 | 状況 |
|------|------|
| MCP SDK version | freee-mcp 1.29.0 (latest), ib-sec-mcp FastMCP 3.x, cost-management-mcp 未確認 |
| Structured output | freee-mcp が先行実装（freee_kpi_dashboard PR#178）|
| Zod 4 | freee-mcp・cost-management-mcp 移行済み。ib-sec-mcp は Python → 無関係 |
| Elicitation / resource links | 未実装。MCP spec 2025-06-18 で追加された機能 |

→ structured output の実装パターンを freee-mcp から ib-sec-mcp へ展開する機会（portfolio/positions tools）。

### Fintech Integration Opportunity

household-finance（取引分類・Notion連携）と freee-mcp（会計API）は補完関係にある。
household-finance の分類ルールを freee-mcp の仕訳整合性チェックにフィードバックするフロー（例: 取引先別カテゴリが freee と一致しているか検証）は統合価値がある。

### 過剰工数リポ

| Repo | Open Issues | Open PRs | 懸念 |
|------|-------------|----------|------|
| simple-bookkeeping | 30 | 8 | 開発が止まった後のバックログ |
| freee-mcp | 1 | 15 | 実装が進むが review が追いつかない |
| ib-sec-mcp | 0 | 5 | 直近 focus-task で追加、monitoring 継続 |

---

## PM Retrospective (April 2026)

### 集計

| 指標 | 値 |
|------|-----|
| 期間 (4月) Issue 作成数 | 7 件 |
| 期間 Resolve 数 (merged) | 4 件 |
| 30日 Resolve 率 | 57% → **50-80% 帯** → 次回以降 max 1 Issue/回 |
| 全期間作成数 | 13 件 |
| 全期間 Resolve 数 | 10 件 |
| 全期間 Resolve 率 | 77% |
| 平均 days_to_resolve | 5.6 日 |
| Quality Score 分布 | A: 10件 / 未評価: 3件 |

### 所見

- **品質は高い**: 全 Quality Score A（Issue 修正なしで PR マージ）
- **解決速度は速い**: 平均 5.6 日、同日解決が 5 件（Codex auto-resolve が効いている）
- **バックログは少ない**: open PM Issue が現在 3 件（all within last 5 days）
- **Resolve 率 57% で制限モード入り**: 3件が open だがどれも直近数日の作成なので、次週以降に大半がクローズされる見込み
- **feature Issue 比率**: 全 13 件中 feature/improvement 5 件（38%）→ 健全な比率

### フィードバック

- Score D / C なし → Issue テンプレートの変更不要
- auto_resolve "skipped" が 1 件（kanji-practice #31）: QA bugfix は Codex で自動解決できないケースあり → 次回も skip で構わない
- freee-mcp の PR バックログ（15件）は PM Issue の問題ではなく Ken の review 待ち → PM からは「review 促進」をレポートで伝える

---

## Education Site Analysis

### 教育軸チェック (learner-1: 年齢 6歳, 小1入学 2026-04)

**learner-1 プロファイル**: 算数は小3-4相当先取り、漢字は漢検10級→9級目標、英語はインター歴約1年 (writing 弱め)

**kanji-practice**
- 9級読み / 9級書き取り / 8級先取り のプリセットが追加済み（PR#26）
- 現在の推奨: `9級読みプリセット` で 2年生漢字の読み定着を優先
- 次のステップ: 読みが 8 割定着したら `9級書き取りプリセット` に移行
- 写経モードの練習行数可変化（1-3行）は反復練習に有効 → `sentencePracticeRows: 3` を試す価値あり

**math-worksheet**
- learner-1 の水準（小3-4相当）に合う設定: 3年生「3桁×1桁」→「3桁×2桁」への移行期
- 幼児向け数字なぞり書き（PR#56,#60-63）は learner-1 には易しすぎる
- URL state 機能（PR#38）で先生・親へのプリント設定共有が容易になった
- **推奨設定**: `3年生 / 3桁×1桁 かけ算 / 2列 / 20問`。安定したら `3桁×2桁` へ

**english-note-maker**
- フォニックスモード追加（PR#23）: learner-1 の「音と文字の対応」強化ニーズに合致
- cloze（穴埋め）モードも改善済み（PR#20, #21）: 写経→穴埋めの移行段階にある learner-1 に最適
- **推奨設定**: `フォニックスモード / 基本ワードファミリー（-at, -an, -it）/ 2ページ`

### Site QA 確認結果 (2026-05-01)

| サイト | 確認内容 | 結果 |
|--------|----------|------|
| kanji-practice | 9級プリセット UI 表示 | ✅ OK |
| math-worksheet | 幼児メニュー表示 | ✅ OK |
| english-note-maker | フォニックスメニュー表示 | ✅ OK |

新機能 3 件すべて本番で正常動作を確認。詳細 QA（生成内容検証）は weekly-repo-health で実施予定。

### 推奨設定サマリー (2026-05-01)

```
kanji-practice:
  プリセット: 9級読み → 定着後に9級書き取り
  写経: sentencePracticeRows=3 で反復量を最大化

math-worksheet:
  学年: 3年生, 問題タイプ: 3桁×1桁かけ算, 列: 2列, 20問
  安定したら 3桁×2桁 へ移行

english-note-maker:
  モード: フォニックス（-at/-an/-it ワードファミリー）, 2ページ
  慣れたら 穴埋め（cloze）モードと交互に使用
```

---

## Feature Discovery (Next Candidates)

| Repo | Feature | 根拠 | Priority |
|------|---------|------|----------|
| kanji-practice | cumulative review preset（前回漢字との混合復習） | spaced retrieval 理論 + 学習プリセット実装済みを活かせる | high |
| ib-sec-mcp | structured output for portfolio/positions | freee-mcp が先行実装、MCP spec 2025-06-18 | medium |
| math-worksheet | spiral review preset（学年横断の混合問題） | 同 spaced retrieval トレンド | medium |
| freee-mcp | TaskManager-based long-running report | MCP SDK 1.30 pre-release、財務レポートが重い | medium |

---

## Next Actions

1. **アーカイブ推奨（Ken 承認待ち）**:
   - `td-mcp-server`, `meditation-chrome-extension`, `remotion-math-education` → アーカイブ
   - `simple-bookkeeping` → `status: abandoned` へ変更 + stale PR/Issue 整理

2. **freee-mcp PR backlog**:
   - open PR 15 件が積み上がっている。Ken の review を促す

3. **次回 focus-task（月曜）**:
   - 30日 resolve 率 57% → max 1 issue/回
   - kanji-practice の cumulative review preset が最優先候補

4. **weekly-repo-health（日曜）**:
   - 新機能（kanji プリセット・math 幼児・english フォニックス）の詳細 QA を実施

---

*Generated by knishioka-pm | 2026-05-01*
