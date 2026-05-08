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
- Updated: 2026-05-05
- Collected: 2026-05-08

## Tech Stack

- package.json: not found (or not accessible via GitHub contents API)
- Dependencies (sample): not found
- Dev dependencies (sample): not found
- npm scripts (keys): not found
- pyproject.toml: present
- requirements.txt: present
- README signal: # Market Lens Studio マーケットデータ・ニュースを元に、note記事、Xポスト用テキスト、画像を自動生成・投稿するシステム。 ## Features - **市場データ取得**: 日本株（東証）、米国株（NYSE/NASDAQ）の指数・銘柄データ - **自動分析**: センチメント推定、シナリオ生成 - **コンテンツ生成**: note記事、Xポスト、画像の自動生成 - **自動投稿**: note.com、X（Twitter）への投稿 ## Quick Start ### Prerequisites - Python 3.10+

## Architecture / Patterns

- Python-based application with repo-specific service boundaries
- Incremental feature delivery through PR-sized vertical slices
- Automation and deployment concerns handled alongside product logic

## Competitive Landscape (notes)

[2026-04-17] TradingView's feature surface keeps raising the baseline for market workspaces with many chart modalities (candles, range, Heikin Ashi, Renko, volume profile variants) aimed at fast noise reduction and intraday context switching. That suggests users increasingly expect analysis systems to preserve context, not just output one-off reports. (ref: https://www.tradingview.com/features/)
[2026-04-17] Koyfin positions around **global coverage**, fast multi-asset overview, and comprehensive analysis in a single daily workspace. For this repo, the differentiator is automated insight-to-publication flow, but the competitive gap is a reusable analyst workspace layer that feeds the article generator. (ref: https://www.koyfin.com/features/)

Potential feature candidates for this repo:
- Add **engagement-driven topic selection**: retrospect_week.pyのエンゲージメント指標をsuggest_topics.pyのスコアリングにフィードバックし、高エンゲージメントなカテゴリの記事を優先するループを作る。
- Add **saved market-workspace snapshots** (watchlists, key charts, macro checklist, thesis notes) as first-class inputs to article generation and retrospectives.
- Add **alert-to-briefing workflows** that turn market events or screening hits into a draft article / X thread package with preserved cross-asset context.

## Tech Decisions (from PRs/commits)

- [2026-05-05] fix(workflow): unblock jq + tee pipelines for /note:write --auto runs -- /note:suggest --auto → /note:write の自動実行パイプラインが Step 4.1 (Save Preview) で繰り返し止まっていた問題を修正します。 (source: PR #177)
- [2026-04-18] fix(note): wire NOTE_SESSION_COOKIE through scripts and CI -- PR #171 のフォローアップ。merge 後に判明した残課題を解消し、CI も同時に動くようにする。 (source: PR #173)
- [2026-04-17] fix(note): add Origin/Referer headers to login & remove redundant mkdir -- /note:write のフロー中で発生していた2つの問題を解消。 (source: PR #171)
- [2026-04-17] feat(retrospect): persist per-article generation metadata -- t for clean integration with /note:write Step 5.3b (non-blocking) 12 fields captured (note_id, published_at, writing_style, article_type, persona, category_tags, claude_cost_usd, input_tokens, output_tokens, quality_gates_fired, eyecatch_status, diagrams_gen... (source: PR #170)
- [2026-04-17] feat(ci): add weekly retrospective GitHub Actions workflow -- Closes #168. (source: PR #169)
- [2026-04-17] feat(retrospect): add weekly article retrospective skill and fact-check archive -- Closes #165 (partial: tasks A, C, D) /note:retrospect slash command で過去1週間の公開記事を分析し、改善点を GitHub Issue として起票可能に 記事単位の fact-check 結果をアーカイブ保存し、事後の振り返りデータを蓄積 決定的データ収集スクリプト。Claude API 不要。 (source: PR #166)
- [2026-04-16] feat(ci): notify Slack and create Issue on write-article failures -- 記事生成ワークフロー (write-article.yml) の失敗時に **GitHub Issue 起票** + **Slack 通知** を行い、緊急対応できるようにする 従来の step failure に加え、Claude セッションが完了しても ci_publish_output.json が生成されない／note_id が空という **サイレント失敗** も検知 schedule gate / guard による正当スキップ（本日投稿済みなど「記事を作らない仕様」）はそのまま残す 1. (source: PR #163)
- [2026-04-16] refactor(note): harden /note:write workflow after 2026-04-15 GS run -- No summary captured. (source: PR #162)
