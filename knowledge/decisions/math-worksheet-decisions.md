# math-worksheet Design Decisions

## 2026-04-16: fix(hissan): 3桁×2桁のかけ算が2枚に分かれる問題と横線の幅を修正

- **What**: fix(hissan): 3桁×2桁のかけ算が2枚に分かれる問題と横線の幅を修正
- **Why**: 4年生「3桁×2桁のかけ算の筆算」で報告された2つの問題を修正：
- **Source**: PR #58

## 2026-04-12: feat: 数字なぞり書きプリント機能（幼児向け）

- **What**: feat: 数字なぞり書きプリント機能（幼児向け）
- **Why**: - 幼児（年長）向けの数字（0〜9）書き方練習プリントを新規追加 - 1行ごとに「数字ラベル | お手本（書き順番号・矢印付き）| なぞり書き×3 | 自由練習×3」を横並びで表示 - 学年セレクターに「幼児（年長）」を追加。選択時は自動で「数字なぞり書き」モードに切り替わる - 文字サイズは既存の列レイアウト（1/2/3列）で調整可能（1列=最大、3列=最小）
- **Source**: PR #56

## 2026-04-11: refactor: Singapore Math を教育的に本質的なパターンのみに整理

- **What**: refactor: Singapore Math を教育的に本質的なパターンのみに整理
- **Why**: Singapore Math のパターンを教育的価値の観点で見直し、本質的なものだけを残しました。
- **Source**: PR #55

## 2026-03-30: feat: Add Singapore Math problems for Grade 4-6 (Primary 4-6)

- **What**: feat: Add Singapore Math problems for Grade 4-6 (Primary 4-6)
- **Why**: - Add 10 new Singapore Math problem patterns covering Grade 4-6 (Primary 4-6) curriculum - Grade 4: fraction-of-a-set, decimal word problems - Grade 5: ratio, percentage, speed/distance/time, volume - Grade 6: algebra, advanced ratio, circl
- **Source**: PR #53

## 2026-03-29: feat: Add automated verification layer for math problem generators

- **What**: feat: Add automated verification layer for math problem generators
- **Why**: ## Summary - Add runtime assertions (`assertValidAnswer`, `assertNoDuplicateNames`, `assertNonEmptyText`) that catch bugs at generation time - Add 110 property-based tests generating 200+ samples per generator/grade — verifying name uniquen
- **Source**: PR #52

## 2026-03-29: fix: 1年生+1/+2たし算の2列レイアウトで列ごとに問題が重複するバグを修正

- **What**: fix: 1年生+1/+2たし算の2列レイアウトで列ごとに問題が重複するバグを修正
- **Why**: ## Summary - `generateAddPlusN`で問題数がプール（0〜9の10通り）を超えた場合、同じシャッフル順で巡回するため2列目が1列目の丸コピーになっていたバグを修正 - プール使い切り時に再シャッフルすることで、列ごとの構造的重複を防止 - 同じパターンを持つ`generateAddTo10`も併せて修正
- **Source**: PR #51
