# PR 템플릿

```md
**요약**
- {무엇을 변경했는지 1~2줄}

**이유**
- {왜 필요한지 1~2줄}

**검증**
- {실행한 검증 2~4개}

**참고**
- {영향 범위/주의사항, 없으면 생략}
```

## PR 생성 예시

```bash
# 1) 템플릿 파일 작성
cat > /tmp/pr-body.md <<'EOPR'
**요약**
- ...

**이유**
- ...

**검증**
- ...
EOPR

# 2) PR 생성
gh pr create --base main --head <branch> --title "<title>" --body-file /tmp/pr-body.md
```
