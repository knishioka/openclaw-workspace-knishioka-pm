# kagoshima-community-kl Knowledge Base

## Overview

- Repo: knishioka/kagoshima-community-kl
- Primary language (GitHub): TypeScript
- License: none
- Default branch: main
- Created: 2026-05-05
- Updated: 2026-06-05
- Collected: 2026-06-12

## Tech Stack

- package.json: present
- Dependencies (sample): clsx, lucide-react, next, next-intl, react, react-dom, tailwind-merge
- Dev dependencies (sample): @axe-core/playwright, @commitlint/cli, @commitlint/config-conventional, @eslint/eslintrc, @playwright/test, @tailwindcss/postcss, @testing-library/jest-dom, @testing-library/react, @testing-library/user-event, @types/node, @types/react, @types/react-dom
- npm scripts (keys): build, check, dev, format, format:check, lint, prepare, start, test, test:coverage, test:e2e, test:visual, test:visual:update, test:watch, typecheck
- pyproject.toml: not found
- requirements.txt: not found

## Architecture / Patterns

- React/Next.js UI

## Tech Decisions (from PRs/commits)

- [2026-06-05] fix(seo): derive site URL from Vercel production domain -- `https://kagoshima-community-kl.vercel.app/ja/events/sea-kagoshima-2026` を Facebook にシェアしてもプレビューが表示されなかった。 (source: PR #34)
- [2026-05-17] feat(seo): add AI discovery metadata -- Adds machine-readable discovery signals for AI/search agents and structured data for the localized KL Kagoshima Association site. (source: PR #31)
- [2026-05-08] feat(events): add Tasik Puteri golf candidate -- ## Summary Adds Tasik Puteri Golf & Country Club as the golf venue candidate on the SEA Kagoshima Malaysia event page. The section uses candidate-stage wording, includes official/map links, and summarizes public review themes with a caution (source: PR #28)
- [2026-05-08] fix(events): clarify KL orientation diagram -- Clarifies the airport and city-centre orientation diagram on the Southeast Asia Kagoshima gathering page. (source: PR #27)
- [2026-05-08] feat(events): add dedicated southeast asia gathering page -- Adds a dedicated URL for the 14th Southeast Asia Kagoshima Association Malaysia Gathering and turns `/events` into a lightweight event listing page. (source: PR #26)
- [2026-05-08] feat(events): update hakka venue illustration -- Updates the Hakka Restaurant venue illustration to better match the provided real storefront reference, especially the green awning and visible signage. (source: PR #25)
