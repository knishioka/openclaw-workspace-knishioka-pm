# Monthly Portfolio Review (2026-04)

As of: 2026-04-01 (Asia/Kuala_Lumpur)

## Summary

- Public repos: 10
  - Active (≤30d): 5
  - Dormant (31–90d): 2
  - Abandoned (≥91d): 3
- Private repos: 7
  - Active (≤30d): 4
  - Dormant (31–90d): 0
  - Abandoned (≥91d): 3 (うち on-hold: 2)

## 1) Last 1 month trend (monitoring/health-trend.jsonl)

※ このトレンドは **2026-03-27 から記録開始**（過去1ヶ月分の十分な履歴はまだ無し）。直近3サンプルの傾向のみ。

- Samples: 3 (2026-03-27, 03-28, 03-29)
- Aggregate status (各日同一): GREEN 3 / YELLOW 2 / RED 5
- Status changes observed: なし

## 2) Activity classification (by last push)

### Active (≤30d)
- knishioka/math-worksheet (0d)
- knishioka/freee-mcp (0d)
- knishioka/cost-management-mcp (4d)
- knishioka/kanji-practice (10d)
- knishioka/ib-sec-mcp (10d)

### Dormant (31–90d)
- knishioka/simple-bookkeeping (65d)
- knishioka/english-note-maker (89d)

### Abandoned (≥91d)
- knishioka/td-mcp-server (241d)
- knishioka/meditation-chrome-extension (275d)
- knishioka/remotion-math-education (287d)

## 3) Overhead hotspots (issues/PRs)

Open counts (now):
- knishioka/freee-mcp: open issues 1 / open PRs 15
- knishioka/simple-bookkeeping: open issues 37 / open PRs 8
- knishioka/ib-sec-mcp: open issues 2 / open PRs 4
- knishioka/cost-management-mcp: open issues 3 / open PRs 3

Interpretation:
- **freee-mcp / simple-bookkeeping は “処理待ち” がボトルネック化**（PR/Issue が積み上がり）。
  - 次の1手は「新規を増やす」より **棚卸し（stale close / PR優先順位付け / まとめてmerge）** が効く。

## 4) Cross-repo analysis (knowledge/repos/*.md)

### 4.1 Common tech (統合・共通化の余地)
- MCP server 群（freee-mcp / ib-sec-mcp / cost-management-mcp / td-mcp-server）
  - 共通パターン: MCP server/tool integration, CLI-style usage, runtime schema validation
  - 依存の共通: dotenv, zod（複数 repo）
  - **提案: “mcp-toolkit” 的な共通基盤**
    - Zod schema 定義・エラーハンドリング、ページング、認可/トークン導線、共通 logging を抽出
    - 目的: 各 MCP repo の PR レビュー負荷を下げる（同じ修正の横展開を減らす）

- Education web apps（kanji-practice / math-worksheet / english-note-maker）
  - 共通: React(+react-dom), react-to-print, zustand, Playwright
  - **提案: 印刷(A4)まわりを共通コンポーネント化**
    - print CSS / margin / font / pagination の共通化
    - 目的: バグ修正の横展開（学習系サイトの安定稼働）

### 4.2 “過剰工数” シグナル
- freee-mcp: open PRs 15 → レビュー/マージ待ちが滞留
- simple-bookkeeping: open issues 37 / PRs 8 → トリアージ負荷が高い

## 5) Abandoned repos: archive recommendation or revival conditions

### Archive 推奨（現状）
- knishioka/meditation-chrome-extension
  - 275日更新なし / open issue/PR 0 → **アーカイブでOK**（復活は必要が出たときに unarchive）
- knishioka/remotion-math-education
  - 287日更新なし / open issue/PR 0 → **アーカイブでOK**

### 条件付き（先に片付けてから判断）
- knishioka/td-mcp-server
  - 241日更新なし だが open PR 2 →
    - 復活条件: 「Treasure Data を今後も MCP で使う」なら、まず PR を整理して最小限で green に戻す
    - 使わないなら: **PR を close/整理 → アーカイブ**

## 6) Private repos (分類のみ / 詳細は非記載)

- Active: market-lens-studio / workflow-engine / household-finance / ut-gymnastics
- Abandoned: jgrants-app / line-advisor (on-hold) / story-bridge (on-hold)

## 7) PM Retrospective (monitoring/issue-tracker.jsonl, since 2026-03-01)

- Issues created: 7
- Resolved: 2 (merged)
- Open: 5
- Avg days_to_resolve (resolved only): ~0.5 days
- Type mix: maintenance 2 / bugfix 3 / feature 1 / improvement 1

## Recommended next actions (次の1ヶ月)

1) freee-mcp: PR 15 本の “棚卸し週” を作る（優先度ラベル付け → まとめてmerge/close）
2) simple-bookkeeping: open issue 37 のトリアージ（stale ラベル運用 + 重複整理）
3) Abandoned 2件（meditation-chrome-extension / remotion-math-education）をアーカイブ候補として扱う（必要なら Issue 化するが、まずは意思決定だけで良い）
4) MCP 群の共通基盤（schema/error/logging/pagination）を軽量に切り出し検討（Issue にするなら 1 repo だけを起点に）
