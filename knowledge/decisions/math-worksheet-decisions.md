# math-worksheet Design Decisions

## 2026-03-22: feat: 1年生向け入門計算パターン5種を追加

- **What**: feat: 1年生向け入門計算パターン5種を追加
- **Why**: ## Summary - 小さい子向けのより簡単な計算問題パターン5種を1年生に追加 - **+1のたし算** / **+2のたし算**: 固定値を足すシンプルな計算 - **かずをかぞえよう**: ○や★などのシンボルを数える問題 - **○をつかったたし算**: 2グループのシンボルを合わせる - **○をつかったひき算**: シンボルから取り除いた残りを答える - シンボルは20px・5個ごとに改行で視認性を確保 - `PATTERN_COUNT_OVERRIDES`で 
- **Source**: PR #46

## 2026-03-07: refactor: pattern-generators.ts を学年・カテゴリ別ファイルに分割

- **What**: refactor: pattern-generators.ts を学年・カテゴリ別ファイルに分割
- **Why**: - `src/lib/generators/pattern-generators.ts` (2,776行) を10ファイルに分割 - `src/lib/generators/patterns/` ディレクトリを新設 - 公開インターフェースは変更なし（`index.ts` の import 2行のみ変更） 
- **Source**: PR #44

## 2026-03-07: chore: Playwright MCPを復活させ playwright-cli の使い分けを整理する

- **What**: chore: Playwright MCPを復活させ playwright-cli の使い分けを整理する
- **Why**: - Playwright MCP は `.mcp.json` に既に設定済みであることを確認 - `scripts/check-print-layout.mjs` は CI/ローカル向け自動チェックとして維持 - CLAUDE.md の「Playwright CLIによるレイアウト確認」セクションを「レイアウト確認」に改名し、2ツールの使い分けを明記 
- **Source**: PR #43

## 2026-03-07: feat(url): URLで問題設定を直接指定できるようにする

- **What**: feat(url): URLで問題設定を直接指定できるようにする
- **Why**: - URLクエリパラメータで問題設定を直接指定可能に（`?grade=4&type=basic&pattern=add-single-digit&cols=2&count=10`） - Zustand `persist` ミドルウェア（localStorage）を削除し、URLを唯一の状態源に変更 - 不正なURLパラメータはデフォルト値にフォールバック、`problemCount`はテンプレート上限でクランプ 
- **Source**: PR #38

## 2026-03-06: fix(anzan): add anzan print template to prevent PDF overflow

- **What**: fix(anzan): add anzan print template to prevent PDF overflow
- **Why**: - **Root cause**: `anzan-pair-sum` and other anzan patterns used the `basic` template (`minProblemHeight: 40px`), causing PDFs to render as 2 pages (measured 1489px vs A4's 1123px) - Add `'anzan'` ProblemType with dedicated print template ( 
- **Source**: PR #34

## 2026-03-06: feat(anzan): implement sequential calculation and mixed mental math patterns

- **What**: feat(anzan): implement sequential calculation and mixed mental math patterns
- **Why**: ## Summary - Implement 3 new anzan (mental math) patterns: pair-sum, reorder, and mixed - Extend `BasicProblem` type with multi-operand support - Update rendering for multi-operand expressions 
- **Source**: PR #33
