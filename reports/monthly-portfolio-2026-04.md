# Monthly Portfolio Review (2026-04)

As of: 2026-04-02 (Asia/Kuala_Lumpur)

## Summary

- Activity classification (public): **Active 5 / Dormant 1 / Abandoned 4**
- Activity classification (private): **Active 4 / Dormant 0 / Abandoned 3**（※うち **on-hold 2**）
- Health trend (last 30 days): `monitoring/health-trend.jsonl` は **2026-03-27〜2026-03-29 の3点のみ**（月次傾向の解像度は低い）
  - この3点では **GREEN 3 / YELLOW 2 / RED 5 で横ばい**
- PM Issue throughput (last 30 days, from `monitoring/issue-tracker.jsonl`): **Created 6 / Merged 2 / Open 4 / Avg days_to_resolve 0.5 / Quality A=2**

---

## 1) Repo activity classification (by last push)

### Public

| Repo | Last push (KL) | Class |
|---|---:|---|
| knishioka/math-worksheet | 2026-04-01 | Active |
| knishioka/freee-mcp | 2026-03-31 | Active |
| knishioka/cost-management-mcp | 2026-03-28 | Active |
| knishioka/kanji-practice | 2026-03-22 | Active |
| knishioka/ib-sec-mcp | 2026-03-21 | Active |
| knishioka/simple-bookkeeping | 2026-01-26 | Dormant |
| knishioka/english-note-maker | 2026-01-01 | Abandoned |
| knishioka/td-mcp-server | 2025-08-03 | Abandoned |
| knishioka/meditation-chrome-extension | 2025-06-30 | Abandoned |
| knishioka/remotion-math-education | 2025-06-18 | Abandoned |

### Private（reports では詳細禁止のため、分類のみ）

| Repo | Class | Notes |
|---|---|---|
| knishioka/workflow-engine | Active |  |
| knishioka/market-lens-studio | Active |  |
| knishioka/household-finance | Active |  |
| knishioka/ut-gymnastics | Active |  |
| knishioka/jgrants-app | Abandoned |  |
| knishioka/line-advisor | Abandoned | on-hold |
| knishioka/story-bridge | Abandoned | on-hold |

---

## 2) Cross-repo analysis (from knowledge/repos/*.md)

### A. MCP servers: 共通基盤化の余地が大きい

対象: `freee-mcp` (TS), `cost-management-mcp` (TS), `ib-sec-mcp` (Py), `td-mcp-server` (Py)

KBから見える共通点:
- MCP tool 定義・登録・メタデータ返却、CallTool の routing
- 入力バリデーション（TSは **zod** が強い共通項）
- ページング / リトライ / rate-limit / auth（freeeの auto-pagination、IBは外部Gateway依存）
- テストの型（TSは handler/unit、IBは integration-heavy）

統合機会（提案）:
- TS MCP向けに `@knishioka/mcp-toolkit`（または mono-repo内 `packages/mcp-kit`）を用意し、以下を集約
  - zod schema → JSON schema / tool metadata 変換
  - pagination helpers / error normalization
  - 共通の logger・debug フラグ・env 読み込み
  - テスト用の共通fixture（ListTools/CallToolのプロトコルテストは cost-management-mcp が先行）
- Py MCPは `ib-sec-mcp` の外部依存（Client Portal Gateway）を前提に、共通化は薄めでOK（むしろ integration テストのテンプレだけ共有）

### B. Education apps: A4印刷・レイアウト保証の共通基盤化

対象: `kanji-practice`, `math-worksheet`, `english-note-maker`

KBから見える共通点:
- ブラウザで生成 → **A4印刷/PDF** が主価値
- レイアウトのバグは頻出（A4はみ出し、ページング、余白、行高）
- Playwright を「印刷品質の自動検査」に使う流れが強い（math-worksheet/english-note-maker）

統合機会（提案）:
- `print-layout-check` の共通ユーティリティ（A4高さpx、overflow検出、ページカウント検算、余白/フォントのガード）
- 設定のURLエンコード（math-worksheetが先行）を kanji/english に横展開 → 再現性・共有が上がる

### C. 「過剰工数」兆候（Issue/PRが多すぎる）

直近 health-trend（2026-03-29 時点）から:
- `freee-mcp`: **open PR 15**（レビュー/マージ待ち滞留のリスク）
- `simple-bookkeeping`: **open issue 36 / open PR 8**（運用負荷が高い。Dormantなのに backlog が厚い）
- `ib-sec-mcp`: open PR 4（CI failing が続くとコスト増）

---

## 3) Abandoned repos: アーカイブ推奨 or 復活条件

### Public

- knishioka/english-note-maker（Abandoned: last push 2026-01-01）
  - 推奨: **Archive候補（またはメンテ最小）**
  - 復活条件: A4レイアウト系の共通基盤化（上記B）が走るなら、その検証先として復帰価値あり

- knishioka/td-mcp-server（Abandoned: last push 2025-08-03）
  - 推奨: **Archive候補**（再着手の見込みが立つまで）
  - 復活条件: Treasure Data を業務で再度使う／workflow-engine と連携する具体案件が出たら再始動

- knishioka/meditation-chrome-extension（Abandoned: last push 2025-06-30）
  - 推奨: **Archive推奨**（プロダクト化/公開予定がないなら保守コストの割に価値が薄い）
  - 復活条件: Chrome Web Store 公開や音声/楽曲の権利整理など「公開の前提」が整った時

- knishioka/remotion-math-education（Abandoned: last push 2025-06-18）
  - 推奨: **Archive推奨**（プロトタイプのまま）
  - 復活条件: 動画教材の配信要件（YouTube/社内、学習単元、制作フロー）が固まったら再開

### Private（詳細禁止のため方針だけ）

- knishioka/jgrants-app: Archive候補（復活は案件発生時）
- knishioka/line-advisor: on-hold のため現状維持（Archiveは判断保留）
- knishioka/story-bridge: on-hold のため現状維持（Archiveは判断保留）

---

## 4) Next actions (proposal)

- MCP:
  - freee-mcp / cost-management-mcp で共通化できる最小単位（schema/metadata, error normalization, pagination）を切り出す設計メモを作る
- Education:
  - A4レイアウト自動検査（Playwright）を3リポ横断で再利用できる形に寄せる（共通スクリプト or 小ライブラリ）
- Backlog pressure:
  - freee-mcp: open PR 15 → 「マージ基準の一本化（ラベル/優先度/CI必須）」だけでも滞留が減る
  - simple-bookkeeping: Dormantなのに open issue 36 → 優先度の再スコープ（close提案はKen承認が必要）
