# english-note-maker Design Decisions

## 2025-11-12: Allow printing up to 20 pages

- **What**: Allow printing up to 20 pages
- **Why**: - Update page count max from 5 to 20 in index.html - Update README.md to reflect new page limit 
- **Source**: PR #18

## 2025-11-12: Add more math problem types

- **What**: Add more math problem types
- **Why**: Not explicitly stated in PR/commit body (see source) 
- **Source**: PR #17

## 2025-11-11: Set up Claude Code Web development

- **What**: Set up Claude Code Web development
- **Why**: - Add SessionStart hook for automatic dependency installation - Configure npm install with PUPPETEER_SKIP_DOWNLOAD for remote env - Install Playwright browsers for e2e testing - Only run hook in remote environment (Claude Code on the Web) - 
- **Source**: PR #16

## 2025-11-05: fix: keep phrase practice print within a4

- **What**: fix: keep phrase practice print within a4
- **Why**: Not explicitly stated in PR/commit body (see source) 
- **Source**: PR #15

## 2025-11-05: fix: auto-adjust layouts to fit a4 output

- **What**: fix: auto-adjust layouts to fit a4 output
- **Why**: ## 背景 - 既存の警告表示だけでは実際のPDF出力でA4外にはみ出すケースが解消されず、利用者が都度ページ数や項目数を手動調整する必要があった - レイアウト診断で検出した問題をフロー内で即座に解消し、印刷プレビューの段階で安定したA4収まりを保証する仕組みが求められていた - HTML の構造不備がCIでのみ検知される状態だったため、ローカル段階で同じ品質チェックを実施できるよう整備したい 
- **Source**: PR #14

## 2025-11-05: [fix] 印刷レイアウトの復旧と問題ページングの改善

- **What**: [fix] 印刷レイアウトの復旧と問題ページングの改善
- **Why**: ## 概要 - 印刷用CSSを統一設定に合わせて修正し、不要な要素が印刷される不具合を解消 - 例文・単語・フレーズのページングロジックを拡張し、複数ページ印刷時に各ページがA4サイズ内でユニークな内容になるよう調整 - フレーズ練習の表示件数を行高に応じて制限し、キャッシュをリセットするイベント処理を追加 
- **Source**: PR #13
