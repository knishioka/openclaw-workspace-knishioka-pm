# jgrants-app Design Decisions

## 2026-04-15: feat(ai): Anthropic prompt caching for Claude routes (#94)

- **What**: feat(ai): Anthropic prompt caching for Claude routes (#94)
- **Why**: Closes #94
- **Source**: PR #96

## 2025-11-23: enhance: Implement password reset with Resend (#89)

- **What**: enhance: Implement password reset with Resend (#89)
- **Why**: 概要
- **Source**: PR #90

## 2025-11-07: test: Add E2E and integration tests for Claude API

- **What**: test: Add E2E and integration tests for Claude API
- **Why**: 概要
- **Source**: PR #88

## 2025-11-06: test: add comprehensive test coverage for organization management APIs (#72)

- **What**: test: add comprehensive test coverage for organization management APIs (#72)
- **Why**: No summary captured.
- **Source**: PR #86

## 2025-11-06: enhance: Add audit logging for critical operations (#71)

- **What**: enhance: Add audit logging for critical operations (#71)
- **Why**: 概要
- **Source**: PR #85

## 2025-11-06: fix: Prevent authenticated users from accessing login/register pages (#80)

- **What**: fix: Prevent authenticated users from accessing login/register pages (#80)
- **Why**: 概要
- **Source**: PR #84

## 2025-11-04: Add edge runtime fetch polyfills for Jest

- **What**: Add edge runtime fetch polyfills for Jest
- **Why**: - add a comprehensive polyfill in `jest.setup.ts` that reuses Next.js edge runtime fetch primitives when the jsdom environment does not expose them - ensure TextEncoder/TextDecoder and Web Streams APIs are available before loading the edge runtime shims - reta…
- **Source**: PR #83

## 2025-11-04: test: polyfill fetch APIs for jest

- **What**: test: polyfill fetch APIs for jest
- **Why**: - reuse Next.js edge runtime primitives to polyfill Request/Response and related web APIs for Jest - add TextEncoder/TextDecoder and stream polyfills so NextRequest can instantiate under jsdom - keep a jest mock fetch that proxies to the edge implementation wh…
- **Source**: PR #82
