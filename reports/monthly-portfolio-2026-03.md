# Monthly Portfolio Review (2026-03)

As of: 2026-03-29

Summary (public repos, latest health snapshot 2026-03-28): RED 5 / YELLOW 2 / GREEN 3

## 1) Portfolio activity classification (based on last push)

### Public repos
- **Active (<=30d)**
  - knishioka/math-worksheet (0d)
  - knishioka/cost-management-mcp (1d)
  - knishioka/kanji-practice (7d)
  - knishioka/ib-sec-mcp (7d)
  - knishioka/freee-mcp (22d)
- **Dormant (30–90d)**
  - knishioka/simple-bookkeeping (62d)
  - knishioka/english-note-maker (86d)
- **Abandoned (90d+)**
  - knishioka/td-mcp-server (238d)
  - knishioka/meditation-chrome-extension (272d)
  - knishioka/remotion-math-education (284d)

### Private repos (names + classification only)
- **Active (<=30d)**
  - knishioka/workflow-engine (0d)
  - knishioka/market-lens-studio (6d)
  - knishioka/household-finance (20d)
  - knishioka/ut-gymnastics (21d)
- **Dormant (30–90d)**
  - knishioka/jgrants-app (89d)
- **Abandoned (90d+)**
  - knishioka/line-advisor (256d) *(on-hold)*
  - knishioka/story-bridge (274d) *(on-hold)*

## 2) Repo health trend (last month)

- `monitoring/health-trend.jsonl` は **2026-03-27 / 03-28 の2点のみ**（過去1ヶ月の推移としてはデータ不足）。
- 2点間ではステータス分布は同一（GREEN 3 / YELLOW 2 / RED 5）。

## 3) Cross-repo analysis (knowledge/repos/*.md)

### 共通技術・統合機会
- **Education系（kanji-practice / math-worksheet / english-note-maker）**
  - 共通: 「印刷・PDF生成」「A4収まり」「レイアウト崩れ検知」。
  - 統合案: `print-layout-check` 的な共通ライブラリ/スクリプト（Playwright + DOM計測 + A4閾値）を切り出し、各リポに再利用。
- **MCP server系（freee-mcp / cost-management-mcp / td-mcp-server / ib-sec-mcp）**
  - 共通: tool registry、schema validation（特にTSは Zod）、auth/環境変数、エラー整形、ページング。
  - 統合案: TS向けに `@knishioka/mcp-kit`（tool登録/メタデータ/共通エラー/ENV検証）を作り、freee-mcp と cost-management-mcp を先行移植。

### 過剰工数/キュー詰まり傾向（public health snapshotより）
- knishioka/freee-mcp: **open PR 15**（キュー過多。マージ/クローズ判断の時間がボトルネック化しやすい）
- knishioka/simple-bookkeeping: **open issues 36 / open PR 8**（トリアージ不足 or スコープ過大のサイン）
- knishioka/ib-sec-mcp: **CI failure + open PR 4**（まずCIを緑に戻すのが最優先）

## 4) Abandoned repos: archive 推奨 / 復活条件（KBベース）

- knishioka/td-mcp-server（Treasure Data MCP）
  - 推奨: **アーカイブ候補**（長期未更新）。
  - 復活条件: Treasure Data を再度使う/顧客案件が再発したら、mypy/CIの再有効化＋依存更新を最初のマイルストーンに。
- knishioka/meditation-chrome-extension（オフライン音声の瞑想拡張）
  - 推奨: **アーカイブ候補**（機能は完結しており、運用計画がないなら凍結が自然）。
  - 復活条件: Chrome Web Store 公開 or 個人利用を継続する意思が出たタイミングで、Manifest/依存更新と最小E2Eを追加。
- knishioka/remotion-math-education（Remotion動画生成）
  - 推奨: **アーカイブ候補**（初期コミットのみ）。
  - 復活条件: 「筆算動画」を教育プロダクトとして本当に使う意思が出たら、まず動画テンプレの1本完成＋レンダリングCIを作る。

## 5) PM Retrospective (2026-03) — issue-tracker

- 2026-03 に PM作成 Issue: **6件**
  - merged: 1（Quality: A, days_to_resolve: 0）
  - open: 5
- 所感:
  - cost-management-mcp は **Issue→PR→即日解決**ができており、Issue品質は良好。
  - ib-sec-mcp / 教育3リポに open が溜まってきているので、次月は **「新規Issue増やす」より「既存openを減らす」寄り**が安全。
