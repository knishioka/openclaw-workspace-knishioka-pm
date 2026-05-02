<!-- version: 2026-05-02 -->

# Workspace Environment

> "リポはどこにあるか / 何が必要か / dirty な checkout をどう扱うか" の正
> 本。cron / Codex / 人間がすべて同じ前提で動くために、暗黙だった環境ルー
> ルをここに集約する。Phase 0 (Issue #15) は **純粋な文書化** で、振る舞
> いの変更は伴わない。

## Canonical Paths

| 用途                                    | パス                                 | 備考                                                              |
| --------------------------------------- | ------------------------------------ | ----------------------------------------------------------------- |
| 監視リポ checkout (public + private)    | `~/Developer/private/{name}`         | `config/repos.yaml` の `repos:` / `private_repos:` 全件で同じ規約 |
| Workspace (本リポ knishioka-pm)         | `~/.openclaw/workspace-knishioka-pm` | cron / 全 session の root                                         |
| Wave-based 作業 worktree (本リポ Issue) | `<workspace>/.claude/worktrees/{N}`  | `/resolve-issue` などの並列作業先                                 |
| Codex 一時隔離先 (主リポ dirty 時)      | `/tmp/{name}-issue-{N}`              | Codex 内部の現行挙動。本ドキュメントで明文化                      |

`~/Developer/cost-management-mcp` のような **`/private` 配下を経由しない重
複 clone は canonical ではない**。`scripts/codex-resolve.sh` は
`LOCAL_REPO_BASE=/Users/ken/Developer/private` を唯一の起点として解決する
ので、外側の clone は cron / auto-resolve から見えない。重複 clone の物理
整理は Issue #12 で対応する。

## Workspace 内 worktree vs 監視リポ直接作業

| シナリオ                            | 作業場所                                                               | 起動経路                                      |
| ----------------------------------- | ---------------------------------------------------------------------- | --------------------------------------------- |
| 本リポ (knishioka-pm) の Issue 並列 | `<workspace>/.claude/worktrees/{N}`                                    | `/resolve-issue {N}` (worktree skill)         |
| 監視リポへの auto-resolve (cron)    | `~/Developer/private/{name}` (clean) / `/tmp/{name}-issue-{N}` (dirty) | `scripts/codex-resolve.sh {owner}/{name} {N}` |
| 監視リポへの手動 PR 作業 (Ken 対話) | `~/Developer/private/{name}` 直接                                      | Ken のローカル shell                          |

`<workspace>/.claude/worktrees/` は **本リポの Wave 用**。監視リポの作業を
ここに置かない (リポ境界を越えると `gh` の auto-detect が壊れる)。

## Uncommitted Changes ポリシー

| 起動経路                              | 主 checkout が dirty な場合                                                                                   |
| ------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| Codex auto-resolve (cron)             | **stash しない / pop しない**。`/tmp/{name}-issue-{N}` に隔離して作業 (現行 Codex 挙動)。主 checkout は不可侵 |
| `/resolve-issue` interactive (本リポ) | worktree skill が `<workspace>/.claude/worktrees/{N}` を切るので主 checkout は無関係                          |
| 監視リポでの手動作業 (Ken)            | Ken が commit / stash / 別ブランチで判断。自動化なし                                                          |

**stash + 終了時 pop を採らない理由**: pop が conflict すると stash list
に残ったまま放置されやすく、次回起動時に古い stash と新しい変更が混ざる
事故が起こる。「主 checkout には絶対に触れない」を不変条件として保つ方
が安全。

## 新リポを監視対象に追加する手順

1. `config/repos.yaml` の `repos:` (public) または `private_repos:` (private) に追記する。最低限のキー: `owner`, `name`, `language`, `priority`, `category`
2. ローカル clone を canonical path に作成する:

   ```bash
   gh repo clone {owner}/{name} ~/Developer/private/{name}
   ```

3. dry-run で playbook 注入が成立することを確認する:

   ```bash
   bash scripts/codex-resolve.sh --dry-run {owner}/{name} 999
   ```

   出力末尾の `# Task` セクションに `/resolve-issue #999` と対象リポ名が
   含まれていれば OK。`'{name}' not found in repos.yaml` が出る場合は手
   順 1 のキー名を確認する。

4. `monitoring/issue-tracker.jsonl` への記録は次回 cron 実行から自動。
   手動 backfill は不要 (Phase 3 の `playbook_version` / `lint_available`
   仕様に従う)。

bootstrap script (`scripts/bootstrap-workspace.sh`) の自動化は Issue #11
で対応する。それまでは上記を手動で実行する。

## 必要な依存ツール

| ツール               | 最低 version | 用途                                                                |
| -------------------- | ------------ | ------------------------------------------------------------------- |
| bash                 | 4.x          | `scripts/*` (associative array や `mapfile` を使う前提)             |
| gh                   | 2.30+        | GitHub API (issue / PR / repo)                                      |
| codex                | 0.124+       | auto-resolve (`scripts/codex-resolve.sh` から起動)                  |
| jq                   | 1.6+         | `issue-tracker.jsonl` 解析 / 集計                                   |
| yq                   | 4.x          | `repos.yaml` 構造化読み出し (将来用 / 現行スクリプトは grep で代用) |
| gtimeout (coreutils) | 9.x          | `codex exec` のタイムアウト制御。fallback で `timeout` も可         |
| markdownlint-cli2    | 0.13+        | CI lint (`.github/workflows/check.yml`)                             |

確認コマンド:

```bash
bash --version | head -1
gh --version | head -1
codex --version
jq --version
yq --version
gtimeout --version | head -1
markdownlint-cli2 --version
```

新マシン初期化の起点:

```bash
brew install gh jq yq coreutils bash
npm i -g @openai/codex@latest markdownlint-cli2
gh auth login
```

## 障害復旧 (Reset Procedure)

1. `~/.openclaw/workspace-knishioka-pm` を `gh repo clone knishioka/openclaw-workspace-knishioka-pm` で再取得する。
2. `~/Developer/private/` 配下に `config/repos.yaml` の各リポを clone する (順序不問)。
3. cron 設定 (`~/.openclaw/cron/jobs.json`) は別リポ管理外なので、個別バックアップ (`~/.openclaw/cron/jobs.json.bak.*`) から復元する。テンプレ化は Issue #11 で対応予定。
4. 「新リポを監視対象に追加する手順」の手順 3 (dry-run) を 1 件通せば、playbook 注入経路が生きていることを確認できる。

## 関連ドキュメント

- [`docs/codex-playbook.md`](codex-playbook.md) — auto-resolve のプロンプト / PR Description Standards
- [`docs/pm-policy.md`](pm-policy.md) — Issue 作成基準 / Frequency Control / Knowledge Rules
- [`AGENTS.md`](../AGENTS.md) — Safety Rules / Cron Jobs / Documents 索引
