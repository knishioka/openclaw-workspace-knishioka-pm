# market-lens-studio Knowledge Base

## Overview

- Repo: knishioka/market-lens-studio
- Description: Market analysis studio
- Primary language (GitHub): Python
- Category / Priority: tool / high
- Status: active
- License: none
- Default branch: main
- Created: 2025-11-14
- Updated: 2026-05-13
- Collected: 2026-05-15

## Tech Stack

- Runtime dependencies: none detected
- pyproject.toml: present
- requirements.txt: present
- README signal: # Market Lens Studio マーケットデータ・ニュースを元に、note記事、Xポスト用テキスト、画像を自動生成・投稿するシステム。 ## Features - **市場データ取得**: 日本株（東証）、米国株（NYSE/NASDAQ）の指数・銘柄データ - **自動分析**: センチメント推定、シナリオ生成 - **コンテンツ生成**: note記事、Xポスト、画像の自動生成 - **自動投稿**:...

## Architecture / Patterns

- Product value depends on stable ingestion/workflow orchestration and clear operator feedback.

## Competitive Landscape (notes)

No competitive research captured in this weekly rotation.

## Tech Decisions (from recent PRs/commits)

- [2026-05-13] fix(note): avoid preview jq permission prompts -- ## Summary Moves preview JSON construction for `/note:write` into the `note:preview-save` skill so auto workflows do not need top-level `jq | tee` commands that can miss Claude... (source: PR #178)
- [2026-05-05] fix(workflow): unblock jq + tee pipelines for /note:write --auto runs -- ## Description `/note:suggest --auto` → `/note:write` の自動実行パイプラインが Step 4.1 (Save Preview) で繰り返し止まっていた問題を修正します。 `jq -n --arg ... --rawfile ... | tee /tmp/...`... (source: PR #177)
- [2026-04-18] fix(note): wire NOTE_SESSION_COOKIE through scripts and CI -- ## Summary PR #171 のフォローアップ。merge 後に判明した残課題を解消し、CI も同時に動くようにする。 ### 1. `NotePublishTool` を構築している全スクリプトで `session_cookie` を渡す **根本原因**: `pydantic_settings` は `.env` を Settings... (source: PR #173)
- [2026-04-17] fix(note): add Origin/Referer headers to login & remove redundant mkdir -- ## Summary `/note:write` のフロー中で発生していた2つの問題を解消。 ### 1. `mkdir -p data/diagrams` の権限プロンプト撲滅 `generate_custom_chart.py:456` と `generate_mermaid_diagram.py:166` ですでに... (source: PR #171)
- [2026-04-17] feat(retrospect): persist per-article generation metadata -- Closes #167 ## Summary - Adds `scripts/note/save_generation_metadata.py` to persist per-article generation metadata to `data/generation_metadata/{note_id}.json` at publish time... (source: PR #170)
- [2026-04-17] feat(ci): add weekly retrospective GitHub Actions workflow -- ## Summary Closes #168. Adds `.github/workflows/retrospect-weekly.yml` that automates the weekly article-performance retrospective. - **Schedule:** every Monday 09:00 JST... (source: PR #169)
- [2026-04-17] feat(retrospect): add weekly article retrospective skill and fact-check archive -- ## Summary Closes #165 (partial: tasks A, C, D) - `/note:retrospect` slash command で過去1週間の公開記事を分析し、改善点を GitHub Issue として起票可能に - 記事単位の fact-check 結果をアーカイブ保存し、事後の振り返りデータを蓄積 ##... (source: PR #166)
- [2026-04-16] feat(ci): notify Slack and create Issue on write-article failures -- ## Summary - 記事生成ワークフロー (`write-article.yml`) の失敗時に **GitHub Issue 起票** + **Slack 通知** を行い、緊急対応できるようにする - 従来の step failure に加え、Claude セッションが完了しても `ci_publish_output.json`... (source: PR #163)
