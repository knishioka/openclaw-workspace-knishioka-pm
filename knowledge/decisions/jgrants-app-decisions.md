# jgrants-app Design Decisions

## 2025-11-03: enhance: Standardize error handling and response format (#66)

- **What**: enhance: Standardize error handling and response format (#66)
- **Why**: APIエンドポイント全体で統一されたエラーハンドリングとレスポンス形式を実装しました。これにより、エラー発生時の原因特定が容易になり、ユーザー体験と開発者体験の両方が向上します。
- **Source**: PR #74

## 2025-11-02: enhance: Add tab navigation to application detail page (#64)

- **What**: enhance: Add tab navigation to application detail page (#64)
- **Why**: 申請作成後、ユーザーがスケジュール管理や書類編集機能に迷わずアクセスできるよう、申請詳細ページにタブナビゲーションと編集リンクを追加しました。
- **Source**: PR #65

## 2025-11-02: enhance: Add application creation flow from subsidy pages (#58)

- **What**: enhance: Add application creation flow from subsidy pages (#58)
- **Why**: Implement comprehensive user flow from subsidy discovery to application creation, addressing the "cannot find where to start application" user pain point identified in Issue #58.
- **Source**: PR #63

## 2025-11-02: enhance: Implement skeleton UI for organization info on subsidies page (#57)

- **What**: enhance: Implement skeleton UI for organization info on subsidies page (#57)
- **Why**: Implements skeleton UI for the organization information block on the subsidies search page to improve loading UX and prevent layout shift.
- **Source**: PR #62

## 2025-11-02: fix: Fix favorite button not working due to missing subsidy auto-save (#59)

- **What**: fix: Fix favorite button not working due to missing subsidy auto-save (#59)
- **Why**: 補助金検索結果からお気に入りボタンをクリックしても、補助金がお気に入りに追加されない404エラーを修正しました。jGrants APIから取得した補助金情報がローカルDBに保存されていなかったため、お気に入り追加時の外部キー制約チェックで失敗していました。
- **Source**: PR #61

## 2025-11-01: enhance: Implement skeleton UI for dashboard loading (#56)

- **What**: enhance: Implement skeleton UI for dashboard loading (#56)
- **Why**: Replaced simple spinner with skeleton UI to improve perceived performance and prevent layout shift (CLS improvement) on the dashboard page.
- **Source**: PR #60
