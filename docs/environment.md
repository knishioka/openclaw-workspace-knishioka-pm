<!-- version: 2026-05-02 (Issue #17) -->

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

**Canonical rule (絶対):** 監視リポは `~/Developer/private/{name}` のみを使
う。`~/Developer/{name}` 直下など、`/private` 配下を経由しないパスに clone
してはならない。`scripts/codex-resolve.sh` は
`LOCAL_REPO_BASE=~/Developer/private` を唯一の起点として解決するので、外側
の clone は cron / auto-resolve から見えず、ステートが二重化する事故源にな
る。

重複 clone (例: `~/Developer/cost-management-mcp`) の物理整理は Issue #17 で対
応する: `scripts/bootstrap-workspace.sh` が `--apply` 時にも警告のみで削除し
ないため、検出 → `reports/spike-clone-duplicates-{date}.md` に記録 → Ken が
手動で `rm -rf` する手順 (本リポは絶対に自動削除しない)。

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

手順 2 の clone 一括チェック / 一括実 clone は
[`scripts/bootstrap-workspace.sh`](#scriptsbootstrap-workspacesh) で自動化済み (Issue #16)。

## scripts/bootstrap-workspace.sh

新マシンや障害復旧時に、依存ツールの存在と `config/repos.yaml` の全リポの
clone 状況を一括チェックする。デフォルトは dry-run (副作用なし)。

```bash
# 人間向けレポート (dry-run)
bash scripts/bootstrap-workspace.sh

# 構造化出力 (CI / 他 script から parse 可能)
bash scripts/bootstrap-workspace.sh --json | jq '.summary'

# 未 clone リポを実 clone (idempotent)
bash scripts/bootstrap-workspace.sh --apply
```

挙動:

- `~/Developer/private/{name}/.git` の有無を全件チェック。
- `--apply` で未 clone を `gh repo clone` (既存は skip、`status: abandoned` / `on-hold` は自動 clone しない)。
- `~/Developer/{name}` (private 配下以外) の重複 clone を ⚠️ で警告のみ。
  削除は Issue #17 / Ken の手動レビュー前提 (本スクリプトは絶対に削除しない)。
- `--json` は `{deps, mode, repos: [...], summary}` を返す。

Exit codes:

| Code | 意味                                  |
| ---- | ------------------------------------- |
| 0    | success                               |
| 2    | 依存ツール不足                        |
| 3    | config/repos.yaml が読めない          |
| 4    | `--apply` 中に `gh repo clone` が失敗 |

## 必要な依存ツール

| ツール               | 最低 version | 用途                                                                  |
| -------------------- | ------------ | --------------------------------------------------------------------- |
| bash                 | 4.x          | `scripts/*` (associative array や `mapfile` を使う前提)               |
| gh                   | 2.30+        | GitHub API (issue / PR / repo)                                        |
| codex                | 0.124+       | auto-resolve (`scripts/codex-resolve.sh` から起動)                    |
| jq                   | 1.6+         | `issue-tracker.jsonl` 解析 / 集計                                     |
| yq                   | 4.x          | `repos.yaml` 構造化読み出し (`scripts/bootstrap-workspace.sh` が使用) |
| gtimeout (coreutils) | 9.x          | `codex exec` のタイムアウト制御。fallback で `timeout` も可           |
| markdownlint-cli2    | 0.13+        | CI lint (`.github/workflows/check.yml`)                               |

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
bash scripts/bootstrap-workspace.sh --apply  # 全リポ一括 clone
```

## 障害復旧 (Reset Procedure)

1. `gh repo clone knishioka/openclaw-workspace-knishioka-pm ~/.openclaw/workspace-knishioka-pm` で再取得する (clone 先ディレクトリ名を明示する。デフォルトでは `openclaw-workspace-knishioka-pm` になり canonical path とずれる)。
2. `bash scripts/bootstrap-workspace.sh --apply` で `config/repos.yaml` の全リポを canonical path (`~/Developer/private/{name}`) に一括 clone する。
3. cron 設定 (`~/.openclaw/cron/jobs.json`) は別リポ管理外なので、個別バックアップ (`~/.openclaw/cron/jobs.json.bak.*`) から復元する。テンプレ化は Issue #11 で対応予定。
4. 「新リポを監視対象に追加する手順」の手順 3 (dry-run) を 1 件通せば、playbook 注入経路が生きていることを確認できる。

## 関連ドキュメント

- [`docs/codex-playbook.md`](codex-playbook.md) — auto-resolve のプロンプト / PR Description Standards
- [`docs/pm-policy.md`](pm-policy.md) — Issue 作成基準 / Frequency Control / Knowledge Rules
- [`AGENTS.md`](../AGENTS.md) — Safety Rules / Cron Jobs / Documents 索引
