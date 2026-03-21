# dotfiles

이 저장소는 zsh 환경과 핵심 CLI 도구를 새 맥으로 안전하게 이식하기 위한 설정 모음입니다.

## 목차
- [설치 가이드](#설치-가이드)
  - [1) 기본 설치 (셸 설정 링크)](#1-기본-설치-셸-설정-링크)
  - [2) CLI 도구 설치 (선택)](#2-cli-도구-설치-선택)
  - [왜 install.sh 하나로 운영하는가](#왜-installsh-하나로-운영하는가)
- [설정 확장 가이드](#설정-확장-가이드)
  - [1) 새 설정 추가](#1-새-설정-추가)
  - [2) 새 도구 추가](#2-새-도구-추가)
- [동기화 가이드 (예시)](#동기화-가이드-예시)
- [주요 파일 설명](#주요-파일-설명)
- [공식 문서 참고](#공식-문서-참고)

## 설치 가이드

### 1) 기본 설치 (셸 설정 링크)
공통 zsh 설정 파일을 심볼릭 링크로 연결하고 문법 검증까지 수행합니다.

```bash
cd ~/dotfiles
./install.sh
```

개인 설정 파일이 없으면 자동으로 생성됩니다.
- `~/.zshrc.local` (원본: `zsh/.zshrc.local.example`)

### 2) CLI 도구 설치 (선택)
새 맥에서 `jq`, `fzf`, `zoxide`, `fd`, `direnv`, `tmux` 같은 핵심 CLI를 함께 설치하려면 옵션을 사용합니다.

```bash
cd ~/dotfiles
./install.sh --with-brew
```

이 명령은 루트의 `Brewfile`을 기준으로 `brew bundle`을 실행합니다.

### 왜 install.sh 하나로 운영하는가

| 항목 | install.sh | install.sh --with-brew |
|---|---|---|
| 목적 | 셸 설정 연결/검증 | 셸 설정 + CLI 패키지 복원 |
| 기본 사용 여부 | 기본 | 선택 |
| 장점 | 안전한 기본 진입점 | 새 맥 이관 시간 단축 |

## 설정 확장 가이드

### 1) 새 설정 추가

| 단계 | 할 일 |
|---|---|
| 1 | 공통/개인 위치 결정 (`zsh/conf/*` vs `~/.zshrc.local`) |
| 2 | 설정 작성 |
| 3 | 적용 (`source ~/.zshrc`) |
| 4 | 검증 (`zsh -n ~/.zshrc`) |
| 5 | 공통 설정만 git 반영 |

중요:
- `~/.zshrc.local`은 개인 전용 파일이며 커밋 대상이 아닙니다.
- 예시 파일(`zsh/.zshrc.local.example`)만 저장소에 포함합니다.

### 2) 새 도구 추가

도구 추가는 아래 순서를 고정하면 가장 안전합니다.

| 단계 | 할 일 |
|---|---|
| 1 | 설치 (`brew install <tool>`) |
| 2 | `Brewfile` 반영 (`brew "<tool>"`) |
| 3 | zsh 초기화 코드 추가 (`zsh/conf/toolchains.zsh` 등) |
| 4 | 적용/검증 (`source ~/.zshrc`, `command -v <tool>`) |
| 5 | 커밋/푸시 |

예시 1: `fd + fzf` 조합

```zsh
if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi
```

예시 2: `direnv`

```zsh
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi
```

예시 3: `tmux`(개인 설정 권장)

```zsh
if command -v tmux >/dev/null 2>&1; then
  ta() { tmux attach-session -t main 2>/dev/null || tmux new-session -s main }
fi
```

참고:
- `bgt`는 현재 설치 경로를 확인한 뒤(예: `command -v bgt`) 초기화 방식이 확정되면 추가하세요.

## 동기화 가이드 (예시)

예시: 현재 맥에 `jq`를 추가하고 다른 맥에 반영

```bash
# 현재 맥
cd ~/dotfiles
brew install jq
printf '\nbrew "jq"\n' >> Brewfile
git add Brewfile
git commit -m "chore: add jq to Brewfile"
git push
```

```bash
# 다른 맥
cd ~/dotfiles
git pull
./install.sh --with-brew
source ~/.zshrc
```

## 주요 파일 설명

<table>
  <thead>
    <tr>
      <th>대구분</th>
      <th>소구분</th>
      <th>파일</th>
      <th>형식</th>
      <th>역할</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td rowspan="2">실행 진입점</td>
      <td rowspan="2">쉘 시작 파일</td>
      <td><code>zsh/.zshrc</code></td>
      <td>Zsh 설정</td>
      <td>zsh 로딩 시작점</td>
    </tr>
    <tr>
      <td><code>zsh/.zprofile</code></td>
      <td>Zsh 설정</td>
      <td>로그인 셸 초기 경로 설정</td>
    </tr>
    <tr>
      <td rowspan="6">공통 zsh 모듈</td>
      <td rowspan="6">기능 모듈</td>
      <td><code>zsh/conf/core.zsh</code></td>
      <td>Zsh 설정</td>
      <td>캐시/테마 기본 로딩</td>
    </tr>
    <tr>
      <td><code>zsh/conf/plugins.zsh</code></td>
      <td>Zsh 설정</td>
      <td>oh-my-zsh 및 plugin 로딩</td>
    </tr>
    <tr>
      <td><code>zsh/conf/aliases.zsh</code></td>
      <td>Zsh 설정</td>
      <td>공통 alias 모음</td>
    </tr>
    <tr>
      <td><code>zsh/conf/path.zsh</code></td>
      <td>Zsh 설정</td>
      <td>PATH 기본 정책</td>
    </tr>
    <tr>
      <td><code>zsh/conf/toolchains.zsh</code></td>
      <td>Zsh 설정</td>
      <td>도구체인 초기화</td>
    </tr>
    <tr>
      <td><code>zsh/.p10k.zsh</code></td>
      <td>Zsh 설정</td>
      <td>프롬프트 스타일</td>
    </tr>
    <tr>
      <td rowspan="2">개인 설정</td>
      <td rowspan="2">개인 전용 파일</td>
      <td><code>zsh/.zshrc.local.example</code></td>
      <td>Zsh 설정 예시</td>
      <td>개인 설정 템플릿</td>
    </tr>
    <tr>
      <td><code>~/.zshrc.local</code></td>
      <td>Zsh 설정</td>
      <td>개인 경로/비밀값 (비커밋)</td>
    </tr>
    <tr>
      <td rowspan="2">설치/패키지</td>
      <td rowspan="2">자동화</td>
      <td><code>install.sh</code></td>
      <td>Shell Script</td>
      <td>환경 점검 + 백업 + 링크 + 선택적 Brewfile 설치</td>
    </tr>
    <tr>
      <td><code>Brewfile</code></td>
      <td>Homebrew Bundle</td>
      <td>핵심 CLI 선언 목록</td>
    </tr>
  </tbody>
</table>

## 공식 문서 참고
- Homebrew Brew Bundle: https://docs.brew.sh/Brew-Bundle-and-Brewfile
- fzf shell integration: https://github.com/junegunn/fzf#setting-up-shell-integration
- zoxide 초기화: https://github.com/ajeetdsouza/zoxide
- fd + fzf 조합: https://github.com/sharkdp/fd#using-fd-with-fzf
- direnv zsh hook: https://direnv.net/docs/hook.html
- jq manual: https://jqlang.org/manual/
