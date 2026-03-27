# OpenClaw 自動PMデモ -- 勉強会プレゼン台本

## 全体の流れ（15分想定）

```
導入 (2分)  → 課題提示 + OpenClawの紹介
設定 (2分)  → ファイル3つ見せる「これだけ」
実演1 (3分) → cronで自律レポート生成
実演2 (3分) → ターミナルで対話
実演3 (3分) → 複数エージェントによる分析
まとめ (2分) → ナレッジ蓄積 + 今後の展望
```

---

## 0. 導入（2分）

### 話すこと

> 「個人で開発していると、リポジトリがどんどん増えていきます。
> 自分の場合は40個くらいあって、半分以上は数ヶ月触ってない状態です。
>
> CIが壊れてるのに気づかない。Issueが溜まっていく。
> 久しぶりに触ろうとすると「あれ、これ何で作ったんだっけ」となる。
>
> これを解決するために、OpenClawに自動PMをやらせてみました。
> OpenClawは自律型のAIエージェントプラットフォームで、
> ワークスペースにMarkdownファイルを数個置くだけで、
> エージェントが勝手にリポを監視してくれるようになります。」

---

## 1. セットアップの簡単さ（2分）

### 話すこと

> 「必要なファイルは3つだけです。」

### やること

ターミナルで3つのファイルを順番に見せる。

```bash
# 1. 監視対象のリポリスト
cat config/repos.yaml
```

> 「これが監視対象。owner と name を書くだけです。
> 10リポ登録していて、active なものから半年以上放置のものまで入れています。
> priority で高い順にチェックされます。」

```bash
# 2. 健康判定の基準
cat config/thresholds.yaml
```

> 「これが健康の基準。7日以内に活動があれば GREEN、
> 30日放置で YELLOW、90日で RED。
> CIが落ちていたら即 RED。この閾値は自由に変えられます。」

```bash
# 3. エージェントの行動規則
head -30 AGENTS.md
```

> 「これがエージェントへの指示書。
> 重要なのは Safety Rules の部分で、"Observe and suggest only" と書いてあります。
> 勝手にIssueを閉じたりPRをマージしたりはしない。あくまで報告と提案だけ。
> あと Interactive Mode のセクションで、質問されたときの答え方も定義しています。」

---

## 2. 自律動作: cronでレポート自動生成（3分）

### 話すこと

> 「この3ファイルを置いたら、あとはcronジョブを登録するだけです。
> 毎週日曜にヘルスチェック、毎朝タスク提案、毎週金曜にナレッジ抽出。
> 3つのジョブが自動で走ります。」

### やること

```bash
# 登録済みのcronジョブを見せる
openclaw cron list
```

> 「knishioka-pm のジョブが3つ見えます。
> weekly-repo-health を手動トリガーしてみましょう。」

```bash
# ヘルスチェックを手動トリガー
openclaw cron run b1a2c3d4-e5f6-7890-abcd-100000000001
```

> 「バックグラウンドで走り始めました。
> 10リポ分のGitHub APIを叩いて、健康診断して、レポートを生成して、
> git commit までやってくれます。5-6分かかるので、先にレポートの結果を見ましょう。」

(事前に生成済みのレポートを見せる)

```bash
# レポートを見せる
cat reports/latest-health.md | head -20
```

> 「RED が5つ、YELLOW が2つ、GREEN が3つ。
> cost-management-mcp は143日放置でCIも壊れている。
> ib-sec-mcp は6日前に触ったばかりだけどCIが落ちてる。
> こういうのを毎週自動で教えてくれます。」

```bash
# OpenClawが自動コミットしたことを見せる
git log --oneline -5
```

> 「git log を見ると、OpenClawが自分でコミットしています。
> "chore: weekly repo health report" — 人が何もしなくてもレポートが更新されていく。」

---

## 3. 対話: ターミナルから質問する（3分）

### 話すこと

> 「レポートだけじゃなく、対話もできます。
> ターミナルからOpenClawに直接聞いてみましょう。」

### やること

```bash
# 全体の状況を聞く
openclaw agent --agent knishioka-pm -m "全体の状況を教えて" --thinking medium
```

(約20秒で回答が返る)

> 「20秒くらいで返ってきました。
> RED 5つの内訳、CIが壊れてるリポ、Issue が溜まってるリポ、
> そして "次の一手" を優先順位付きで提案してくれています。
> 人間がやったら全リポの状況確認だけで30分はかかる作業です。」

```bash
# 特定のリポについて深掘り
openclaw agent --agent knishioka-pm -m "cost-management-mcpどうなってる？何をすべき？" --thinking medium
```

> 「特定のリポについて聞くと、さらに詳しく答えてくれます。
> CI failure の具体的な原因まで調べて、修復手順を提案してくれる。
> 半年ぶりに触るリポでも、一瞬でキャッチアップできます。」

---

## 4. 複数エージェント: 役割を分けた分析（3分）

### 話すこと

> 「OpenClawのエージェントは、サブエージェントを起動して役割分担もできます。
> PMエージェントが "レビュアー" と "ストラテジスト" を並列で動かして、
> それぞれの分析結果を統合するということが可能です。
> 実際にやってみましょう。」

### やること

```bash
# PMにサブエージェントの起動を指示
openclaw agent --agent knishioka-pm --thinking medium --timeout 120 -m \
  "cost-management-mcp について sessions_spawn で reviewer と strategist を起動して分析して。reviewer はCI failure原因の調査、strategist は復活 vs アーカイブの判断をそれぞれ担当。"
```

> 「PMエージェントがreviewerとstrategistを並列で起動しました。
> 結果が返ってくるまで少し待ちましょう。」

(yield で非同期になるので、同じセッションにフォローアップ)

```bash
# 結果を聞く
openclaw agent --agent knishioka-pm -m "reviewer と strategist の結果をまとめて、PMとして最終判断を出して" --thinking medium
```

> 「reviewer は CI failure の原因を特定しました。
> workflow ファイル内の変数再宣言エラーで、1行直せば治る。
>
> strategist は star 0、外部需要なし、Issue だけ溜まっている状態を見て、
> 明確な用途がなければアーカイブ推奨と判断。
>
> PMはこの2つを統合して最終判断を出しています。
> 復活するなら最小コストで CI を直してから判断、
> やる気が出なければアーカイブ。具体的で実行可能な提案です。」

---

## 5. まとめ（2分）

### 話すこと

> 「ここまでで見せたのは3つです。
>
> 1つ目: セットアップの簡単さ。
> repos.yaml でリポを指定、thresholds.yaml で基準を定義、
> AGENTS.md でエージェントの行動規則を書く。この3ファイルだけ。
>
> 2つ目: 自律動作。
> cronジョブが毎週レポートを生成し、自分でコミットしてくれる。
> 人が何もしなくても、プロジェクトの健康状態が常に可視化されている。
>
> 3つ目: 対話と判断。
> 単なるモニタリングツールではなく、PMとしての判断ができる。
> 複数の視点（レビュアー、ストラテジスト）を並列で動かして、
> 統合的な判断を出せる。
>
> 一番の価値はナレッジの蓄積です。
> 毎週金曜にコミット履歴やPRから技術的な判断理由を抽出して、
> リポごとのナレッジベースを自動で更新し続ける。
> 半年後にリポを触るとき、これがあるのとないのでは全然違います。
>
> 全てのファイルは GitHub で公開しているので、興味があれば見てみてください。」

```bash
# ナレッジファイルがあれば見せる
ls knowledge/repos/
```

---

## 想定Q&A

**Q: privateリポは対象にできる？**
A: できる。このデモはpublicリポのみだが、gh CLIが認証されていればprivateリポも同じように監視可能。repos.yamlに追加するだけ。

**Q: Notion連携は？**
A: タスク提案をNotionタスクとして自動作成することも可能。既存のNotion MCPツールと組み合わせれば数行の設定で実現できる。

**Q: 他のプラットフォーム（GitLab等）は？**
A: scriptsを差し替えれば対応可能。OpenClawのワークスペース設計はプラットフォーム非依存。

**Q: コストは？**
A: cronジョブ1回あたりのLLM呼び出しは軽量（thinking: low/medium）。1日1回のタスク提案 + 週2回のレポートで月数ドル程度。

**Q: 似たツールとの違いは？**
A: GitHub InsightsやRenovateは特定機能に特化。OpenClawは「PMとしての判断」ができる点が違う。放置リポをアーカイブすべきか復活させるべきか、コンテキストを持って提案できる。

**Q: ワークスペースを分ける基準は？**
A: ドメインが違えば分ける。この PM ワークスペースの中でサブエージェント（reviewer / strategist）を spawn するのは同じワークスペース内で十分。チーム監視や個人アシスタントなど、knowledge や tools が全く異なる場合にワークスペースを分離する。

---

## デモ前チェックリスト

```bash
# 1. OpenClawゲートウェイが起動しているか
openclaw gateway status

# 2. knishioka-pm エージェントが認識されているか
openclaw agents list

# 3. レポートが事前に生成されているか
cat reports/latest-health.md | head -5

# 4. gitが最新か
git log --oneline -3
```

## コマンドまとめ（コピペ用）

```bash
# --- セットアップ確認 ---
cat config/repos.yaml
cat config/thresholds.yaml
head -30 AGENTS.md

# --- cron ---
openclaw cron list
openclaw cron run b1a2c3d4-e5f6-7890-abcd-100000000001

# --- レポート確認 ---
cat reports/latest-health.md | head -20
git log --oneline -5

# --- 対話 ---
openclaw agent --agent knishioka-pm -m "全体の状況を教えて" --thinking medium
openclaw agent --agent knishioka-pm -m "cost-management-mcpどうなってる？何をすべき？" --thinking medium

# --- 複数エージェント ---
openclaw agent --agent knishioka-pm --thinking medium --timeout 120 -m \
  "cost-management-mcp について sessions_spawn で reviewer と strategist を起動して分析して。reviewer はCI failure原因の調査、strategist は復活 vs アーカイブの判断をそれぞれ担当。"
openclaw agent --agent knishioka-pm -m "reviewer と strategist の結果をまとめて、PMとして最終判断を出して" --thinking medium

# --- ナレッジ ---
ls knowledge/repos/
```
