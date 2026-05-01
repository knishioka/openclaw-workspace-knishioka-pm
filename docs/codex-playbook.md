<!-- version: 2026-05-01 -->

# Codex Playbook

> Source: [AGENTS.md](../AGENTS.md). このドキュメントは AGENTS.md の Codex 自動解決まわり（Auto-Resolve via Codex / PR Description Standards / Codex Prompting Guidelines）を切り出したもの。

## Auto-Resolve via Codex

Issue 作成後、Codex CLI の `resolve-issue` スキルを使って自動的に draft PR を作成する。
Codex には「コードを書く」だけでなく「自分で検証してPR本文に結果を書き込む」ところまでをループさせる。
Ken の手動検証コストを最小化するのが目的。

### ローカルリポパス

repos.yaml のリポ名からローカルパスを解決する:

- Public repos: `/Users/ken/Developer/private/{name}`
- Private repos: `/Users/ken/Developer/private/{name}`

### 実行フロー

```bash
# 1. ローカルリポを最新に同期
cd /Users/ken/Developer/private/{repo_name}
git fetch origin
git checkout main && git pull origin main

# 2. Codex で Issue を解決し、検証 + PR本文整形まで完走させる
#    プロンプトは "Codex Prompting Guidelines" 章の標準テンプレを使う
codex exec -C /Users/ken/Developer/private/{repo_name} \
  --full-auto \
  "$(cat <<'EOF'
/resolve-issue #{issue_number}

実装後は必ず以下のループを完走させてから draft PR を作成してください。

【検証 (Verification)】
1. プロジェクト標準のチェックを順に実行する。コマンドは package.json / pyproject.toml /
   Makefile / Taskfile などから検出する。該当しないものはスキップ。
   - build, lint, format, typecheck, unit test, (該当時) integration / e2e
2. 失敗があれば最大3回まで自己修正コミットを積んで再実行する。
3. それでも残った失敗は隠さず PR 本文に ❌ で明示する。

【PR 本文】
- workspace の AGENTS.md "PR Description Standards" に従い **日本語** で記述する。
- 動作確認テーブル、受け入れ条件のチェック、影響範囲、レビュー観点を必ず埋める。
- 推測を断定として書かない。確認できていないものは「未検証」と書く。

【ルール】
- ファイル削除や破壊的変更が必要なら PR 本文の "影響範囲 / リスク" に明記する。
- docs/ / AGENTS.md / scripts/ / config/repos.yaml は変更しない（workspace 側のガード）。
- コミットメッセージ・ブランチ名・PRタイトルは英語、PR本文は日本語。
EOF
)"

# 3. PR が作成されたら gh で draft に変換（resolve-issue が通常PRを作る場合）
pr_number=$(gh pr list -R {owner}/{name} --head "$(git branch --show-current)" --json number --jq '.[0].number')
if [ -n "$pr_number" ]; then
  gh pr ready --undo -R {owner}/{name} "$pr_number" 2>/dev/null || true
fi
```

### 検証コマンドの自動検出

リポ別の標準コマンド (Codex は AGENTS.md / CLAUDE.md > package.json scripts > 慣例 の順で検出):

| 言語 / 環境     | build               | lint                      | format                     | typecheck           | test                |
| --------------- | ------------------- | ------------------------- | -------------------------- | ------------------- | ------------------- |
| Node (npm/pnpm) | `npm run build`     | `npm run lint`            | `npm run format`           | `npm run typecheck` | `npm test`          |
| Python (uv)     | `uv build` (該当時) | `uv run ruff check .`     | `uv run ruff format .`     | `uv run mypy .`     | `uv run pytest`     |
| Python (poetry) | -                   | `poetry run ruff check .` | `poetry run ruff format .` | `poetry run mypy .` | `poetry run pytest` |
| Rust            | `cargo build`       | `cargo clippy`            | `cargo fmt`                | -                   | `cargo test`        |
| Go              | `go build ./...`    | `golangci-lint run`       | `go fmt ./...`             | `go vet ./...`      | `go test ./...`     |

存在しないコマンドは省略（埋め草で書かない）。リポ独自のスクリプト (`make ci` 等) があればそれを優先する。

### Lint 不在リポの扱い

リポによっては lint / formatter が未導入のケースがある。Codex は **無いものを勝手に install しない**。

- 検出 heuristic: `command -v {tool} >/dev/null` で解決できない / `npm run lint` 等が `Missing script` で落ちる → "lint 未導入" と判定する。
- 判定したら以下の運用にする:
  1. 動作確認テーブルの該当行は `⚠️ n/a (Linter未導入)` を記録（`✅` で塗らない、行の省略もしない）。
  2. PR 本文に **「Linterが未導入のため lint をスキップ」** を 1 行残す（影響範囲 / リスク または レビュー観点で言及してよい）。
  3. issue-tracker.jsonl の `lint_available` を `false`、`lint_skipped_reason` を `"no_lint_configured"` または `"command_not_found"` で記録する。
  4. ESLint / Ruff / golangci-lint 等の **新規導入は別 Issue** に切り出す（このPRでは導入しない）。
- 一時的に install パッケージを追加して lint を通す行為は禁止。本来の lint コマンドが解決できない事実を隠さない。

### 制約

- **1 Issue ずつ逐次処理**（並列実行しない）
- codex が AGENTS.md を見つけられない場合、CLAUDE.md をプロジェクトコンテキストとして使用する（codex は自動的に読む）
- codex exec のタイムアウト: 15分（`--timeout 900` 相当）
- 自己修正の試行は **最大3回**。それを超えたら諦めて ❌ 明示で draft PR にする (失敗を隠さない)
- 失敗した場合: issue-tracker.jsonl に `"auto_resolve": "failed"` を記録し、次の Issue に進む
- PR 作成後: issue-tracker.jsonl に `"auto_resolve": "draft_pr_created", "pr": N` を記録

### issue-tracker.jsonl 拡張フィールド

```json
{
  "repo": "knishioka/math-worksheet",
  "issue": 48,
  "type": "bugfix",
  "created": "2026-03-28",
  "status": "open",
  "auto_resolve": "draft_pr_created",
  "pr": 51,
  "codex_duration_sec": 342,
  "playbook_version": "2026-05-01",
  "lint_available": true,
  "lint_skipped_reason": null,
  "verification": {
    "build": "pass",
    "lint": "pass",
    "typecheck": "pass",
    "test": "pass",
    "self_fix_attempts": 0
  }
}
```

`auto_resolve` の値: `"pending"` | `"in_progress"` | `"draft_pr_created"` | `"failed"` | `"skipped"`
`verification` 各項目: `"pass"` | `"fail"` | `"warn"` | `"skipped"` | `"n/a"`
`playbook_version` の値: `docs/codex-playbook.md` 先頭の `<!-- version: YYYY-MM-DD -->` から抽出した日付文字列。`scripts/codex-resolve.sh` が起動時に stderr へ `[codex-resolve] start repo=... issue=... playbook_version=YYYY-MM-DD timeout=...s` という形式の 1 行を出力するので、cron 側は `grep -oE 'playbook_version=[0-9]{4}-[0-9]{2}-[0-9]{2}'` 等で部分一致して capture する（行頭一致では取れない点に注意）。
`lint_available` の値: `true` (lint コマンドが解決できた) / `false` (未導入 or 見つからない)。
`lint_skipped_reason` の値: `lint_available=false` のときのみ設定。`"no_lint_configured"` (script 未定義) / `"command_not_found"` (バイナリ不在) / `null` (lint_available=true)。

JSONL は **append-only**。既存レコードに新フィールドを遡及追加しない（`playbook_version` 不在の旧レコードはそのまま残す）。

## PR Description Standards (Codex Auto-PR)

Codex が draft PR を生成するときは、以下の構造を **日本語** で必ず含める。
人間レビュアー (Ken) が PR タブの最初の画面で「マージしてよいか」「どこを重点的に見るか」を即判断できる粒度を目指す。

### テンプレート

```markdown
## 概要

{1〜3文で「何を」「なぜ」変えたか。Issue の Problem/Why を要約}

Closes #{issue_number}

## 変更内容

- {ファイル / モジュール単位の主要変更を箇条書き}
- {追加・修正・削除を分けて書く}
- {自動生成ファイル (lockfile, snapshot 等) は別行で「自動更新」と明示}

## 動作確認 (Verification)

| 項目                       | コマンド              | 結果        |
| -------------------------- | --------------------- | ----------- |
| Build                      | `{build_command}`     | ✅ pass     |
| Lint                       | `{lint_command}`      | ✅ 0 errors |
| Format                     | `{format_command}`    | ✅ pass     |
| Typecheck                  | `{typecheck_command}` | ✅ pass     |
| Unit test                  | `{test_command}`      | ✅ N passed |
| (該当時) E2E / Integration | `{e2e_command}`       | ✅ pass     |

> コマンド欄は前章「検証コマンドの自動検出」表からリポの言語に合わせて埋める。該当しない行は省略。

実行ログ要約: {自己修正で直したエラー、許容した warning、未対応の理由など。なければ「初回成功」}

## 受け入れ条件 (Acceptance Criteria)

Issue の Acceptance Criteria を一行ずつ転記し、満たした方法を添える:

- [x] {条件1} → {検証方法 / 該当ファイル}
- [x] {条件2} → {...}
- [ ] {未達があれば理由を1文で}

## スコープ外 (Non-goals)

- {このPRで対応していないこと}
- {follow-up Issue が必要なら #N で参照}

## 影響範囲 / リスク

- 影響API: {変更した公開 API。なければ「なし（内部のみ）」}
- 互換性: {破壊的変更の有無、移行手順}
- ロールバック: {差し戻し手順。`git revert` で十分かどうか}

## レビュー観点 (Review Focus)

レビュアーに重点的に見てほしい箇所を1〜3点。多くしすぎない:

- `{path/to/file}:L{N}` — {観点を1文で}
- {...}

## スクリーンショット / 出力例

UI / CLI / レポート出力に変化がある場合のみ画像 or コードブロックを貼る。

---

Generated by Codex auto-resolve / Reviewed by knishioka-pm
```

### セクション必須度

| セクション         | 必須                                  |
| ------------------ | ------------------------------------- |
| 概要 + Closes      | 常に必須                              |
| 変更内容           | 常に必須                              |
| 動作確認           | 常に必須 (該当しない項目は行ごと省略) |
| 受け入れ条件       | 常に必須                              |
| スコープ外         | 常に必須 (空でも「なし」と明記)       |
| 影響範囲 / リスク  | 常に必須                              |
| レビュー観点       | 常に必須 (1点でも書く)                |
| スクリーンショット | UI / 出力変化があるときのみ           |

### 書き方のルール

- **隠さない**: 失敗・未検証・warning は ❌ / ⚠️ / 「未検証」で明示する。Codex が「直せなかった」状態でPR本文を成功で塗らない。
- **推測を断定にしない**: コードを読んだだけで実行していないチェックは「コード上では満たしているが未実行」と書く。
- **言語**: 本文は日本語。コマンド名・ファイルパス・コミットメッセージ・PRタイトル・ブランチ名は英語のまま。
- **量**: 各セクション 3〜7 行を目安。長くなるなら follow-up Issue に切り出す。
- **再現性**: コマンドはコピペで動く形で書く (`./scripts/x.sh` のようにリポ root 起点)。
- **レビュー観点**: 「全体的に確認お願いします」のような中身のない記述は禁止。

## Codex Prompting Guidelines

Codex に作業を投げるときの共通方針 (web 調査ベース)。Issue 自動解決 / 修正依頼 / レビュー
依頼すべてに適用する。

### 原則

1. **Goals + Constraints で書く。step-by-step で railroad しない。**
   - 良い例: 「全テスト green にしてから draft PR を出す。3回失敗したら ❌ で記録」
   - 悪い例: 「まず npm install、次に npm test、次に...」(リポ毎の差を吸収できない)
2. **検証ループを必ず含める。**
   - "実装 → 検証 → 直す → 再検証" を 1 プロンプトで完走させる。
   - 検証コマンドはリポ側の AGENTS.md / CLAUDE.md / package.json に書いておけば Codex が拾う。
3. **「good」の定義を明示する。**
   - 何をもって完了かを書く: 「全 Acceptance Criteria が [x]、CI 全 green、PR description が
     workspace AGENTS.md の "PR Description Standards" に準拠」
4. **失敗は隠さず明示。**
   - ❌ や「未検証」を許容することで、Codex に成功を捏造させない。
5. **AGENTS.md レイヤーを活用。**
   - workspace AGENTS.md (このファイル) = ポリシー / PR フォーマット / 配信ルール
   - 各リポ AGENTS.md / CLAUDE.md = 検証コマンド / アーキ概要 / コーディング規約
   - Codex は両方を読むので、ポリシーと技術詳細を分けて書く。

### 標準プロンプト構造

```
{タスク要約 (1行)}

【目標】
- {達成すべきこと}

【制約】
- {触ってはいけないファイル / 守るべき互換性}

【検証】
- {成功の定義となるコマンド}

【出力】
- {何を残すか: コミット / draft PR / レポート / コメント}
```

このテンプレを `codex exec` のプロンプトに埋め込む。

### Anti-patterns (避けるべき書き方)

- 「いい感じに直して」 → "good" の定義がないので Codex がレビュー指摘の出やすい実装をする
- 「テストは書かなくていい」 → 検証ループが回らないので品質が保証できない
- 手順を逐次プロンプトで送る → context が分断され Codex が判断できない
- リポ側 AGENTS.md と矛盾する指示 → workspace 側を上書きしないと Codex が混乱する
