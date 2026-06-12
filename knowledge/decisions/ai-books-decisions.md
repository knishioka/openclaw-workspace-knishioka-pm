# ai-books Design Decisions

## 2026-06-10: ops(web): post-deploy production smoke check

- **What**: ops(web): post-deploy production smoke check
- **Why**: #167 — 本番デプロイ後スモークチェック。CI が green でも Vercel 本番は環境変数ミス・`viewer_ro` 権限ドリフト・Supabase Auth 設定変更で壊れうるため、本番 URL を日次 (+ `workflow_dispatch`) で probe し、失敗時は重複排除付きで issue を自動起票する。
- **Source**: PR #177

## 2026-06-10: feat(mcp): expose etax_preflight tool with optional local XSD validation

- **What**: feat(mcp): expose etax_preflight tool with optional local XSD validation
- **Why**: #159 で実装した申告前チェック (filing preflight) を MCP tool として公開し、AI エージェントが「申告可 / 要修正」を **1 コール**で確認できるようにした。あわせて、これまで CI でしか走っていなかった公式 XSD 検証を `validate_xsd=True` で申告前にも実行できるようにし、申告直前の最終確認を 1 ツールに集約した。
- **Source**: PR #176

## 2026-06-10: feat(etax): supply KOA210 filer header from a local profile

- **What**: feat(etax): supply KOA210 filer header from a local profile
- **Why**: KOA210(一般用) のヘッダ欄 (申告者の住所等) は #78 の spec が値マッピングに集中して**空欄**で出力しており、取込後に e-Tax ソフトで毎年手入力する必要があった。本 PR は手編集前提の TOML プロフィール (`~/.ai-books/etax/profile.toml`) から**平文ヘッダセルを自動供給**する (#160)。
- **Source**: PR #172

## 2026-06-10: feat(etax): filing preflight data-completeness checks

- **What**: feat(etax): filing preflight data-completeness checks
- **Why**: 申告前に「自分の実データが e-Tax 申告可能な状態か」を 1 回でまとめて判定する report 層モジュール `src/ai_books/etax/preflight.py` を追加します。これまで分散していた検証 (export 時のスキーマ検証 / CI の XSD 検証) に対し、実データに対する **データ完全性チェック + 決算書→KOA210 マッピングの dry-run** を 1 か所に集約し、「申告可 (ok) / 要修正 (error・理由全件)」を
- **Source**: PR #170

## 2026-06-10: fix(devx): repair invalid Claude permission rule + lint settings.json in pre-commit

- **What**: fix(devx): repair invalid Claude permission rule + lint settings.json in pre-commit
- **Why**: `.claude/settings.json` の deny ルール `"Bash(git push:* --force)"` は invalid（`:*` は specifier 末尾必須）。Claude Code は起動時にこれをサイレントにスキップするため:
- **Source**: PR #168

## 2026-06-09: fix(web): improve viewer accessibility affordances

- **What**: fix(web): improve viewer accessibility affordances
- **Why**: read-only viewer のテーブル見出し、現在地ナビ、横スクロール、キーボードフォーカス、ページタイトルを改善しました。表示属性とスタイル中心の変更で、DB 書込経路や集計ロジックは変更していません。
- **Source**: PR #157
