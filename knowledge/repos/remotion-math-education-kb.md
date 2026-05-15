# remotion-math-education Knowledge Base

## Overview

- Repo: knishioka/remotion-math-education
- Description: Math education video generator with Remotion -- inactive since 2025-06
- Primary language (GitHub): TypeScript
- Category / Priority: education / low
- Status: abandoned
- License: none
- Default branch: main
- Created: 2025-06-17
- Updated: 2025-06-17
- Collected: 2026-05-15

## Tech Stack

- Runtime dependencies: @remotion/cli, @remotion/player, @types/react, @types/react-dom, react, react-dom, remotion, typescript
- npm scripts: build, dev, render, upgrade
- pyproject.toml: not found
- requirements.txt: not found
- README signal: # 🧮 Remotion Math Education Video Generator Remotionを使用した高品質な筆算教育動画生成システム ## ✨ 特徴 - **4K対応**: 3840x2160の超高解像度動画 - **プロ品質**: 60fps、h264コーデック、CRF18の高品質設定 - **React製**: TypeScriptとReactを使用したモダンな開発環境 - **カスタマイズ可能**:...

## Architecture / Patterns

- Browser/app code uses package-managed TypeScript/JavaScript workflow with explicit build/test scripts.
- Learning-content rendering balances pedagogy, layout density, and printable output constraints.
- Worksheet/problem generation is configuration-driven, with preview/verification loops used to catch A4 overflow.

## Competitive Landscape (notes)

No competitive research captured in this weekly rotation.

## Tech Decisions (from recent PRs/commits)

- [2025-06-17] Update .gitignore to explicitly exclude all video file formats (source: commit de2472e)
- [2025-06-17] Initial commit: Remotion-based math education video generator (source: commit 6c32f01)
