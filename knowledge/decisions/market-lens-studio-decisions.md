# market-lens-studio Design Decisions

Updated: 2026-05-15

## 2026-05-13: fix(note): avoid preview jq permission prompts

- **What**: ## Summary Moves preview JSON construction for `/note:write` into the `note:preview-save` skill so auto workflows do not need top-level `jq | tee` commands that can miss Claude...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #178

## 2026-05-05: fix(workflow): unblock jq + tee pipelines for /note:write --auto runs

- **What**: ## Description `/note:suggest --auto` → `/note:write` の自動実行パイプラインが Step 4.1 (Save Preview) で繰り返し止まっていた問題を修正します。 `jq -n --arg ... --rawfile ... | tee /tmp/...`...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #177

## 2026-04-18: fix(note): wire NOTE_SESSION_COOKIE through scripts and CI

- **What**: ## Summary PR #171 のフォローアップ。merge 後に判明した残課題を解消し、CI も同時に動くようにする。 ### 1. `NotePublishTool` を構築している全スクリプトで `session_cookie` を渡す **根本原因**: `pydantic_settings` は `.env` を Settings...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #173

## 2026-04-17: fix(note): add Origin/Referer headers to login & remove redundant mkdir

- **What**: ## Summary `/note:write` のフロー中で発生していた2つの問題を解消。 ### 1. `mkdir -p data/diagrams` の権限プロンプト撲滅 `generate_custom_chart.py:456` と `generate_mermaid_diagram.py:166` ですでに...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #171

## 2026-04-17: feat(retrospect): persist per-article generation metadata

- **What**: Closes #167 ## Summary - Adds `scripts/note/save_generation_metadata.py` to persist per-article generation metadata to `data/generation_metadata/{note_id}.json` at publish time...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #170

## 2026-04-17: feat(ci): add weekly retrospective GitHub Actions workflow

- **What**: ## Summary Closes #168. Adds `.github/workflows/retrospect-weekly.yml` that automates the weekly article-performance retrospective. - **Schedule:** every Monday 09:00 JST...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #169

## 2026-04-17: feat(retrospect): add weekly article retrospective skill and fact-check archive

- **What**: ## Summary Closes #165 (partial: tasks A, C, D) - `/note:retrospect` slash command で過去1週間の公開記事を分析し、改善点を GitHub Issue として起票可能に - 記事単位の fact-check 結果をアーカイブ保存し、事後の振り返りデータを蓄積 ##...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #166

## 2026-04-16: feat(ci): notify Slack and create Issue on write-article failures

- **What**: ## Summary - 記事生成ワークフロー (`write-article.yml`) の失敗時に **GitHub Issue 起票** + **Slack 通知** を行い、緊急対応できるようにする - 従来の step failure に加え、Claude セッションが完了しても `ci_publish_output.json`...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #163

## 2026-04-16: refactor(note): harden /note:write workflow after 2026-04-15 GS run

- **What**: ## Summary Post-mortem refactor after the 2026-04-15 autonomous Goldman Sachs Q1 2026 article run, which shipped with 3 fact-check issues (notably EPS consensus `16.30ドル` vs...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #162

## 2026-04-15: feat(note): strengthen duplicate detection + fix DAL eyecatch

- **What**: ## Summary 直近1か月（3/13〜4/13）の投稿26本を分析し、以下の2件を対処: 1. **DAL記事 (`nf36d69d976d5`) のアイキャッチ欠損を修復** — 4/10公開の「DAL Q1決算」のみeyecatchがnullだったため再生成・アップロード済み (コード変更なし) 2. **重複検出ロジックの強化** —...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #161
