# CLI 치트시트

이 문서는 `Brewfile`에 들어있는 CLI를 빠르게 익히기 위한 짧은 사용 가이드입니다.
공식 문서를 기준으로, 자주 쓰는 형태만 간단히 정리했습니다.

## 매일 자주 쓰는 도구

| 도구 | 언제 쓰는지 | 먼저 익힐 명령 | 공식 링크 |
|---|---|---|---|
| `git` | 변경 확인, 브랜치 작업 | `status`, `switch -c`, `log --oneline --graph` | https://git-scm.com/ |
| `gh` | PR 확인/생성/체크 | `pr status`, `pr create`, `pr checks` | https://cli.github.com/ |
| `ripgrep` | 코드/문자열 검색 | `rg "text"` | https://github.com/BurntSushi/ripgrep |
| `fd` | 파일 빠르게 찾기 | `fd name`, `fd -e ts` | https://github.com/sharkdp/fd |
| `fzf` | 목록에서 빠르게 고르기 | `history | fzf`, `fd . | fzf` | https://github.com/junegunn/fzf |
| `zoxide` | 자주 가는 폴더 이동 | `z project`, `zi` | https://github.com/ajeetdsouza/zoxide |
| `jq` | JSON 보기/필터링 | `jq .`, `jq -r '.key'` | https://jqlang.org/ |

### `git`
```bash
git status
git switch -c feature/my-work
git pull --rebase origin main
git log --oneline --graph --decorate -10
```

### `gh`
```bash
gh auth status
gh pr status
gh pr create --fill
gh pr checks <번호>
```

### `ripgrep`
```bash
rg "TODO"
rg "useEffect" src
rg --glob "*.md" "Brewfile"
```

### `fd`
```bash
fd Brewfile
fd -e md docs
fd conf zsh
```

### `fzf`
```bash
history | fzf
fd . | fzf
git branch | fzf
```

팁:
- `CTRL-R`: 이전 명령 검색
- `CTRL-T`: 파일 선택
- `ALT-C`: 폴더 이동

### `zoxide`
```bash
z dotfiles
z coding
zi
```

### `jq`
```bash
cat data.json | jq .
cat data.json | jq '.items[0]'
cat data.json | jq -r '.name'
```

## 프로젝트/환경 관리 도구

| 도구 | 언제 쓰는지 | 먼저 익힐 명령 | 공식 링크 |
|---|---|---|---|
| `direnv` | 프로젝트별 환경변수 자동 적용 | `direnv allow` | https://direnv.net/ |
| `nvm` | Node 버전 전환 | `nvm ls`, `nvm install`, `nvm use` | https://github.com/nvm-sh/nvm |
| `openjdk` | Java 실행 확인 | `java -version` | https://openjdk.org/ |
| `tmux` | 터미널 세션 유지 | `new`, `attach`, `ls` | https://github.com/tmux/tmux/wiki |

### `direnv`
```bash
echo 'export APP_ENV=local' > .envrc
direnv allow
```

팁:
- `.envrc`는 내용을 보고 승인한 뒤 `direnv allow`를 실행합니다.
- 프로젝트마다 다른 환경변수를 둘 때 가장 편합니다.

### `nvm`
```bash
nvm ls
nvm install 20
nvm use 20
```

### `openjdk`
```bash
java -version
javac -version
```

### `tmux`
```bash
tmux new -s main
tmux ls
tmux attach -t main
```

## API/점검 도구

| 도구 | 언제 쓰는지 | 먼저 익힐 명령 | 공식 링크 |
|---|---|---|---|
| `httpie` | REST API 빠른 호출 | `http GET`, `http POST` | https://httpie.io/ |
| `grpcurl` | gRPC API 확인/호출 | `list`, `describe`, `invoke` | https://github.com/fullstorydev/grpcurl |
| `watch` | 명령 반복 실행 | `watch -n 2` | https://formulae.brew.sh/formula/watch |
| `telnet` | 포트 연결 확인 | `telnet host port` | https://formulae.brew.sh/formula/telnet |

### `httpie`
```bash
http GET https://api.github.com/repos/pasudo123/dotfiles
http POST https://httpbin.org/post name=pasudo role=dev
```

### `grpcurl`
```bash
grpcurl localhost:9090 list
grpcurl localhost:9090 describe my.package.Service
grpcurl -d '{"id":1}' localhost:9090 my.package.Service/Get
```

### `watch`
```bash
watch -n 2 "date"
watch -n 3 "ls -al"
```

### `telnet`
```bash
telnet localhost 5432
telnet example.com 80
```

## 추천 사용 흐름

1. 문자열은 `rg`, 파일은 `fd`로 먼저 찾습니다.
2. 결과가 많으면 `fzf`로 골라서 이동합니다.
3. 자주 가는 폴더는 `zoxide`로 바로 이동합니다.
4. 프로젝트 환경변수는 `direnv`, 런타임 버전은 `nvm`으로 관리합니다.
5. API 확인은 REST면 `httpie`, gRPC면 `grpcurl`을 먼저 씁니다.

## 참고

- 깊게 배울 때는 표의 공식 링크를 먼저 보는 것이 가장 안전합니다.
- 이 문서는 “처음 바로 써보는 용도”라서 복잡한 옵션은 일부러 넣지 않았습니다.
