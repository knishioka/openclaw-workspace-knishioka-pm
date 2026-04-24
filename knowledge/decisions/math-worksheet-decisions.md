# math-worksheet Design Decisions

## 2026-04-16: fix(fraction): 分数パターンがbasicテンプレにフォールバックしてA4から溢れる問題を修正

- **What**: fix(fraction): 分数パターンがbasicテンプレにフォールバックしてA4から溢れる問題を修正
- **Why**: No summary captured.
- **Source**: PR #59

## 2026-04-16: fix(hissan): 3桁×2桁のかけ算が2枚に分かれる問題と横線の幅を修正

- **What**: fix(hissan): 3桁×2桁のかけ算が2枚に分かれる問題と横線の幅を修正
- **Why**: No summary captured.
- **Source**: PR #58

## 2026-04-12: feat: 数字なぞり書きプリント機能（幼児向け）

- **What**: feat: 数字なぞり書きプリント機能（幼児向け）
- **Why**: No summary captured.
- **Source**: PR #56

## 2026-04-11: refactor: Singapore Math を教育的に本質的なパターンのみに整理

- **What**: refactor: Singapore Math を教育的に本質的なパターンのみに整理
- **Why**: No summary captured.
- **Source**: PR #55

## 2026-03-30: feat: Add Singapore Math problems for Grade 4-6 (Primary 4-6)

- **What**: feat: Add Singapore Math problems for Grade 4-6 (Primary 4-6)
- **Why**: No summary captured.
- **Source**: PR #53

## 2026-03-29: feat: Add automated verification layer for math problem generators

- **What**: feat: Add automated verification layer for math problem generators
- **Why**: - Add runtime assertions (`assertValidAnswer`, `assertNoDuplicateNames`, `assertNonEmptyText`) that catch bugs at generation time - Add 110 property-based tests generating 200+ samples per generator/grade — verifying name uniqueness, mathematical correctness,…
- **Source**: PR #52

## 2026-03-29: fix: 1年生+1/+2たし算の2列レイアウトで列ごとに問題が重複するバグを修正

- **What**: fix: 1年生+1/+2たし算の2列レイアウトで列ごとに問題が重複するバグを修正
- **Why**: - `generateAddPlusN`で問題数がプール（0〜9の10通り）を超えた場合、同じシャッフル順で巡回するため2列目が1列目の丸コピーになっていたバグを修正 - プール使い切り時に再シャッフルすることで、列ごとの構造的重複を防止 - 同じパターンを持つ`generateAddTo10`も併せて修正
- **Source**: PR #51

## 2026-03-28: feat: add Singapore Math word problem patterns

- **What**: feat: add Singapore Math word problem patterns
- **Why**: 概要 - Singapore Mathの問題タイプ4種をGrade 1-6に追加
- **Source**: PR #47
