# Agents.md

이 문서는 에이전트 작업 규칙의 **SSoT(단일 진실 공급원) 인덱스**입니다.
세부 규칙은 아래 링크 문서에서 관리합니다.

## 규칙 문서
- 작업 원칙/브랜치 전략: [docs/agents/workflow.md](docs/agents/workflow.md)
- PR 작성 규칙: [docs/agents/pr-guidelines.md](docs/agents/pr-guidelines.md)
- PR 템플릿: [docs/agents/pr-template.md](docs/agents/pr-template.md)

## 빠른 요약
1. `main`에서 직접 작업하지 않고, 항상 작업 브랜치를 생성한다.
2. 변경 후 PR을 생성하고 링크를 공유한다.
3. PR 머지 후 로컬/리모트 브랜치를 삭제하고 `main`으로 복귀한다.
4. PR 본문은 `##` 헤딩 대신 `**라벨 + 불릿**` 형식을 사용한다.
