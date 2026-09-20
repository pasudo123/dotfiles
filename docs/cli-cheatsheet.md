# CLI 치트시트

이 문서는 `Brewfile`에 들어있는 CLI를 빠르게 익히기 위한 짧은 사용 가이드입니다.
공식 문서를 기준으로, 자주 쓰는 형태만 간단히 정리했습니다.

## 매일 자주 쓰는 도구

| 도구 | 언제 쓰는지 | 먼저 익힐 명령 | 공식 링크 |
|---|---|---|---|
| `git` | 변경 확인, 브랜치 작업 | `status`, `switch -c`, `log --oneline --graph` | [공식 문서](https://git-scm.com/) |
| `gh` | PR 확인/생성/체크 | `pr status`, `pr create`, `pr checks` | [공식 문서](https://cli.github.com/) |
| `ripgrep` | 코드/문자열 검색 | `rg "text"` | [공식 문서](https://github.com/BurntSushi/ripgrep) |
| `fd` | 파일 빠르게 찾기 | `fd name`, `fd -e ts` | [공식 문서](https://github.com/sharkdp/fd) |
| `fzf` | 목록에서 빠르게 고르기 | `history \| fzf`, `fd . \| fzf` | [공식 문서](https://github.com/junegunn/fzf) |
| `zoxide` | 자주 가는 폴더 이동 | `z project`, `zi` | [공식 문서](https://github.com/ajeetdsouza/zoxide) |
| `jq` | JSON 보기/필터링 | `jq .`, `jq -r '.key'` | [공식 문서](https://jqlang.org/) |
| `bat` | 구문 강조와 줄 번호를 포함해 파일 보기 | `bat README.md` | [공식 문서](https://github.com/sharkdp/bat) |

<details>
<summary><code>git</code> - 변경 확인과 브랜치 작업</summary>

```bash
# 현재 변경 상태 확인
git status

# 새 작업 브랜치 생성
git switch -c feature/my-work

# main 기준으로 최신 이력 가져오기
git pull --rebase origin main

# 최근 커밋 흐름 보기
git log --oneline --graph --decorate -10
```

</details>

<details>
<summary><code>gh</code> - GitHub PR 확인과 생성</summary>

```bash
# GitHub 로그인 상태 확인
gh auth status

# 내 PR/리뷰 상태 확인
gh pr status

# 현재 브랜치 기준으로 PR 생성
gh pr create --fill

# PR 체크 상태 확인
gh pr checks <번호>
```

</details>

<details>
<summary><code>ripgrep</code> - 코드와 문자열 검색</summary>

```bash
# TODO 문자열 찾기
rg "TODO"

# src 디렉토리 안에서 useEffect 찾기
rg "useEffect" src

# Markdown 파일에서 Brewfile 찾기
rg --glob "*.md" "Brewfile"
```

</details>

<details>
<summary><code>fd</code> - 파일 이름 기준으로 빠르게 찾기</summary>

```bash
# 이름에 Brewfile이 들어가는 파일 찾기
fd Brewfile

# docs 안에서 md 파일만 찾기
fd -e md docs

# zsh 안에서 conf가 들어간 파일 찾기
fd conf zsh
```

</details>

<details>
<summary><code>fzf</code> - 목록에서 빠르게 골라서 선택하기</summary>

```bash
# 이전 명령 목록에서 다시 찾기
history | fzf

# 파일 목록 중 하나를 선택하기
fd . | fzf

# 브랜치 목록에서 선택하기
git branch | fzf
```

팁:
- `CTRL-R`: 이전 명령 검색
- `CTRL-T`: 파일 선택
- `ALT-C`: 폴더 이동

</details>

<details>
<summary><code>zoxide</code> - 자주 가는 폴더로 빠르게 이동하기</summary>

```bash
# dotfiles와 관련된 폴더로 이동
z dotfiles

# coding과 관련된 폴더로 이동
z coding

# 후보를 보고 선택해서 이동
zi
```

</details>

<details>
<summary><code>jq</code> - JSON 보기와 값 추출</summary>

```bash
# JSON 전체를 보기 좋게 출력
cat data.json | jq .

# 첫 번째 아이템 확인
cat data.json | jq '.items[0]'

# 문자열 값만 깔끔하게 추출
cat data.json | jq -r '.name'
```

</details>

<details>
<summary><code>bat</code> - 파일 내용을 읽기 좋게 출력하기</summary>

```bash
# Markdown 파일을 구문 강조와 함께 확인
bat README.md

# 줄 번호 없이 출력
bat --style=plain README.md
```

</details>

## 프로젝트/환경 관리 도구

| 도구 | 언제 쓰는지 | 먼저 익힐 명령 | 공식 링크 |
|---|---|---|---|
| `direnv` | 프로젝트별 환경변수 자동 적용 | `direnv allow` | [공식 문서](https://direnv.net/) |
| `nvm` | Node 버전 전환 | `nvm ls`, `nvm install`, `nvm use` | [공식 문서](https://github.com/nvm-sh/nvm) |
| `openjdk` | Java 실행 확인 | `java -version` | [공식 문서](https://openjdk.org/) |
| `tmux` | 터미널 세션 유지 | `new`, `attach`, `ls` | [공식 문서](https://github.com/tmux/tmux/wiki) |

<details>
<summary><code>direnv</code> - 프로젝트별 환경변수 자동 적용</summary>

```bash
# 프로젝트 전용 환경변수 파일 만들기
echo 'export APP_ENV=local' > .envrc

# 파일 내용을 확인한 뒤 적용 허용
direnv allow
```

팁:
- `.envrc`는 내용을 보고 승인한 뒤 `direnv allow`를 실행합니다.
- 프로젝트마다 다른 환경변수를 둘 때 가장 편합니다.

</details>

<details>
<summary><code>nvm</code> - Node 버전 관리</summary>

```bash
# 설치된 Node 버전 목록 확인
nvm ls

# 원하는 버전 설치
nvm install 20

# 현재 셸에서 사용할 버전 전환
nvm use 20
```

</details>

<details>
<summary><code>openjdk</code> - Java 실행 환경 확인</summary>

```bash
# Java 런타임 버전 확인
java -version

# Java 컴파일러 버전 확인
javac -version
```

</details>

<details>
<summary><code>tmux</code> - 터미널 세션 유지</summary>

```bash
# main 이름으로 새 세션 만들기
tmux new -s main

# 현재 세션 목록 확인
tmux ls

# main 세션에 다시 붙기
tmux attach -t main
```

</details>

## API/점검 도구

| 도구 | 언제 쓰는지 | 먼저 익힐 명령 | 공식 링크 |
|---|---|---|---|
| `httpie` | REST API 빠른 호출 | `http GET`, `http POST` | [공식 문서](https://httpie.io/) |
| `grpcurl` | gRPC API 확인/호출 | `list`, `describe`, `invoke` | [공식 문서](https://github.com/fullstorydev/grpcurl) |
| `watch` | 명령 반복 실행 | `watch -n 2` | [공식 문서](https://formulae.brew.sh/formula/watch) |
| `telnet` | 포트 연결 확인 | `telnet host port` | [공식 문서](https://formulae.brew.sh/formula/telnet) |

<details>
<summary><code>httpie</code> - REST API 빠르게 호출하기</summary>

```bash
# GET 요청 보내기
http GET https://api.github.com/repos/pasudo123/dotfiles

# JSON 값을 포함해 POST 요청 보내기
http POST https://httpbin.org/post name=pasudo role=dev
```

</details>

<details>
<summary><code>grpcurl</code> - gRPC 서비스 확인과 호출</summary>

```bash
# 서버에 있는 서비스 목록 보기
grpcurl localhost:9090 list

# 서비스 설명 확인
grpcurl localhost:9090 describe my.package.Service

# JSON 데이터를 넣어 메서드 호출
grpcurl -d '{"id":1}' localhost:9090 my.package.Service/Get
```

</details>

<details>
<summary><code>watch</code> - 명령을 반복 실행하며 보기</summary>

```bash
# 2초마다 시간 확인
watch -n 2 "date"

# 3초마다 현재 파일 목록 확인
watch -n 3 "ls -al"
```

</details>

<details>
<summary><code>telnet</code> - 포트 연결 가능 여부 확인</summary>

```bash
# 로컬 DB 포트 확인
telnet localhost 5432

# 원격 서버의 80 포트 확인
telnet example.com 80
```

</details>

## 추천 사용 흐름

1. 문자열은 `rg`, 파일은 `fd`로 먼저 찾습니다.
2. 결과가 많으면 `fzf`로 골라서 이동합니다.
3. 자주 가는 폴더는 `zoxide`로 바로 이동합니다.
4. 프로젝트 환경변수는 `direnv`, 런타임 버전은 `nvm`으로 관리합니다.
5. API 확인은 REST면 `httpie`, gRPC면 `grpcurl`을 먼저 씁니다.

## 참고

- 깊게 배울 때는 표의 공식 링크를 먼저 보는 것이 가장 안전합니다.
- 이 문서는 “처음 바로 써보는 용도”라서 복잡한 옵션은 일부러 넣지 않았습니다.
