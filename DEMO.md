# OpenClaw 自動PMデモ -- 勉強会用ノート

## 伝えたいこと

### メインメッセージ

**「repos.yaml にリポを書いて AGENTS.md を置くだけで、OpenClawが勝手にPMしてくれる」**

### 3つのポイント

1. **セットアップの簡単さ**
   - repos.yaml: 監視したいリポをリストするだけ
   - AGENTS.md: エージェントの行動規則（テンプレートから数分で作れる）
   - あとはcronを登録すればOpenClawが自律的に動き始める

2. **OpenClawが自律的に価値を生む**
   - 放置リポの健康診断 → 問題を早期発見
   - タスク提案 → 「次に何をすべきか」を自動で教えてくれる
   - ナレッジ蓄積 → 各リポの技術的判断・設計意図を自動で記録し続ける

3. **対話もできる**
   - ターミナルから「cost-management-mcpどうなってる？」と聞ける
   - OpenClawが蓄積したナレッジと最新の健康データを元に回答
   - 放置していたリポの状況を一瞬で把握できる

### なぜOpenClawなのか

- **知識の連続性**: セッションをまたいでナレッジが蓄積される（MEMORY.md + knowledge/）
- **自律動作**: cronでスケジューリングすれば、人が指示しなくても定期チェックが走る
- **ワークスペース分離**: PM用ワークスペースに閉じるので、他のワークスペースに影響しない
- **設定がコードとして管理できる**: repos.yaml, AGENTS.md, thresholds.yaml が全てGitで管理される

---

## デモフロー (10分想定)

### Step 1: セットアップを見せる (2分)

**見せるファイル:**

- `config/repos.yaml` → 「これが監視対象。10リポ、publicのみ」
- `config/thresholds.yaml` → 「健康の基準。30日放置でYELLOW、90日でRED」
- `AGENTS.md` → 「エージェントの行動規則。Observe and suggest only」

**トーク:**

> 「個人プロジェクトって放置しがちですよね。40個くらいリポがあって、半分くらいは数ヶ月触ってない。
> OpenClawのワークスペースを作って、この3ファイルを置くだけで自動PMが始まります。」

### Step 2: cronトリガーでOpenClawが自律動作 (3分)

**実行:**

```bash
# cron job IDで手動トリガー
openclaw cron run b1a2c3d4-e5f6-7890-abcd-100000000001
```

**見せるもの:**

- `openclaw cron list` で3つのジョブが登録されていることを見せる
- トリガー後、`openclaw cron list` で `running` → `ok` に変わるのを見せる
- 完了後、`git log --oneline -3` でOpenClawが自動コミットしたことを見せる
- `reports/latest-health.md` を開いてRED/YELLOW/GREEN のサマリーテーブル

**トーク:**

> 「日曜20時に自動で走ります。今は手動トリガーします。
> 10リポを巡回して健康診断 → レポート生成 → gitコミットまで全部自動。
> REDが5つ。CI壊れてるのが2つ、半年以上放置が3つ。」

**所要時間の目安:** cronジョブ実行に約5-6分かかるので、先にトリガーしてStep 1の説明中にバックグラウンドで走らせると良い。

### Step 3: ターミナルで対話 (3分)

**実行:**

```bash
# 全体の状況を聞く（約20秒で回答）
openclaw agent --agent knishioka-pm -m "全体の状況を教えて" --thinking medium

# 特定リポについて深掘り
openclaw agent --agent knishioka-pm -m "cost-management-mcpの状態を教えて。何をすべき？" --thinking medium

# JSON出力でプログラマブルに使える
openclaw agent --agent knishioka-pm -m "REDステータスのリポだけ教えて" --json
```

**期待する応答例（実測済み）:**

「全体の状況を教えて」に対して:

- GREEN 3 / YELLOW 2 / RED 5 の内訳
- CI failureのリポ（ib-sec-mcp, cost-management-mcp）を最優先で指摘
- 滞留（simple-bookkeeping: Issue 36件）を検出
- 長期放置3リポにアーカイブ提案
- 具体的な「次の一手」を優先順位付きで提示

応答時間: 約20-25秒

**トーク:**

> 「放置してたリポについて聞くと、OpenClawが健康データを元に答えてくれる。
> 何をすべきかの優先順位も出してくれるので、久しぶりに触るリポでもすぐにキャッチアップできる。
> これ、人間がやったら全リポの状況確認だけで30分はかかる作業です。」

**トーク:**

> 「放置してたリポについて聞くと、OpenClawが健康データとナレッジを元に答えてくれる。
> 何をすべきかの優先順位も出してくれるので、久しぶりに触るリポでもすぐにキャッチアップできる。」

### Step 4: ナレッジ蓄積の結果 (2分)

**見せるもの:**

- `knowledge/repos/kanji-practice-kb.md` を開く
- 技術スタック、依存関係、最近のPRから抽出された設計判断

**トーク:**

> 「これが毎週金曜に自動更新されるナレッジベース。
> コミットやPRから技術的な判断理由を自動抽出してくれる。
> 半年後にリポを触るとき、これがあるのとないのでは全然違う。」

---

## 想定Q&A

**Q: privateリポは対象にできる？**
A: できる。このデモはpublicリポのみだが、gh CLIが認証されていればprivateリポも同じように監視可能。repos.yamlに追加するだけ。

**Q: Notion連携は？**
A: タスク提案をNotionタスクとして自動作成することも可能。今回のデモでは見せていないが、既存のNotion MCPツールと組み合わせれば数行の設定で実現できる。

**Q: 他のプラットフォーム（GitLab等）は？**
A: scriptsを差し替えれば対応可能。OpenClawのワークスペース設計はプラットフォーム非依存。

**Q: コストは？**
A: cronジョブ1回あたりのLLM呼び出しは軽量（thinking: low/medium）。1日1回のタスク提案 + 週2回のレポートで月数ドル程度。

**Q: 似たツールとの違いは？**
A: GitHub Insightsやrenovateは特定機能に特化。OpenClawは「PMとしての判断」ができる点が違う。放置リポをアーカイブすべきか復活させるべきか、コンテキストを持って提案できる。

---

## クイックリファレンス（デモ時コピペ用）

### 前提条件

```bash
# OpenClawゲートウェイが起動していること
openclaw gateway status

# knishioka-pm エージェントが認識されていること
openclaw agents list
```

### Cron操作

```bash
# ジョブ一覧
openclaw cron list

# 手動トリガー
openclaw cron run b1a2c3d4-e5f6-7890-abcd-100000000001  # weekly-repo-health
openclaw cron run b1a2c3d4-e5f6-7890-abcd-100000000002  # daily-task-suggest
openclaw cron run b1a2c3d4-e5f6-7890-abcd-100000000003  # weekly-knowledge-extract
```

### 対話

```bash
# 全体の状況
openclaw agent --agent knishioka-pm -m "全体の状況を教えて" --thinking medium

# 特定リポの状態
openclaw agent --agent knishioka-pm -m "cost-management-mcpどうなってる？" --thinking medium

# タスク提案
openclaw agent --agent knishioka-pm -m "今一番やるべきことは？" --thinking medium

# ナレッジ確認
openclaw agent --agent knishioka-pm -m "kanji-practiceの技術スタックを教えて" --thinking medium
```

### 成果物の確認

```bash
# OpenClawが自動コミットしたか確認
cd /Users/ken/.openclaw/workspace-knishioka-pm && git log --oneline -5

# 最新レポート
cat reports/latest-health.md
cat reports/latest-tasks.md

# ナレッジベース
ls knowledge/repos/
ls knowledge/decisions/
```
