# dotfiles

이 저장소는 zsh 환경을 안전하게 이식하고 동기화하기 위한 설정 모음입니다.
첫 이관에서는 **기능 변경 없이 파일만 분리**하는 것을 원칙으로 합니다.

## 목차
- [설치 가이드](#설치-가이드)
  - [A. 현재 맥에 처음 적용](#a-현재-맥에-처음-적용)
  - [B. 새 맥/새 환경에서 시작](#b-새-맥새-환경에서-시작)
  - [설치 경로 선택 기준](#설치-경로-선택-기준)
- [설정 확장 가이드](#설정-확장-가이드)
  - [1) 새 설정 추가](#1-새-설정-추가)
  - [2) 새 도구 추가](#2-새-도구-추가)
- [동기화 가이드 (예시)](#동기화-가이드-예시)
- [주요 파일 설명](#주요-파일-설명)
  - [대구분 1: 실행 진입점](#대구분-1-실행-진입점)
  - [대구분 2: 공통 zsh 모듈](#대구분-2-공통-zsh-모듈)
  - [대구분 3: 개인 설정](#대구분-3-개인-설정)
  - [대구분 4: 설치/운영 스크립트](#대구분-4-설치운영-스크립트)
  - [대구분 5: 운영 문서](#대구분-5-운영-문서)

## 설치 가이드

### A. 현재 맥에 처음 적용
이미 사용 중인 맥에서 dotfiles를 처음 붙일 때 사용합니다.

```bash
cd ~/dotfiles
./bootstrap.sh
```

`bootstrap.sh`는 환경 점검(Homebrew, oh-my-zsh, plugin) 후 `install.sh`를 실행합니다.

### B. 새 맥/새 환경에서 시작
새 맥/새 계정처럼 깨끗한 환경에서 시작할 때 사용합니다.

```bash
# 1) 저장소 받기
git clone <your-repo> ~/dotfiles
cd ~/dotfiles

# 2) 링크 설치
./install.sh

# 3) 개인 설정 파일 만들기
cp zsh/.zshrc.local.example ~/.zshrc.local
```

그다음 `~/.zshrc.local`에 개인 경로를 입력하고 필요한 도구를 설치하세요.

### 설치 경로 선택 기준

| 상황 | 실행 |
|---|---|
| 현재 사용 중인 맥에서 첫 적용 | `./bootstrap.sh` |
| 새 맥/새 환경에서 시작 | `./install.sh` |

## 설정 확장 가이드

### 1) 새 설정 추가
공통 설정인지 개인 설정인지 먼저 구분합니다.

- 공통 설정(커밋 대상): `zsh/conf/*.zsh`
- 개인 설정(커밋 금지): `~/.zshrc.local`

중요:
- `~/.zshrc.local`은 **개인 전용 파일**이며 저장소 커밋 대상이 아닙니다.
- `.gitignore`에 `zsh/.zshrc.local`이 등록되어 있고, 예시 파일(`zsh/.zshrc.local.example`)만 커밋합니다.

적용/검증:

```bash
source ~/.zshrc
zsh -n ~/.zshrc
```

### 2) 새 도구 추가
새 도구는 아래 5단계로 추가하면 안전합니다.

1. 설치 확인

```bash
command -v <tool-name>
```

2. 위치 선택
- 도구 초기화: `zsh/conf/toolchains.zsh`
- alias: `zsh/conf/aliases.zsh`
- PATH: `zsh/conf/path.zsh`

3. 조건부 로딩 작성(필수)

```zsh
if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"
fi

if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi
```

4. 적용/검증

```bash
source ~/.zshrc
command -v fzf direnv
```

5. 동기화
- 공통 설정 변경만 git에 반영합니다.
- 개인값은 `~/.zshrc.local`에만 유지합니다.

## 동기화 가이드 (예시)

예시: 현재 맥에서 `ll` alias를 추가하고 다른 맥으로 동기화하는 흐름

```bash
# 현재 맥에서
cd ~/dotfiles
printf "\nalias ll='ls -al'\n" >> zsh/conf/aliases.zsh
source ~/.zshrc
alias ll

git add zsh/conf/aliases.zsh README.md
# README 변경이 없으면 README.md는 제외

git commit -m "chore: add ll alias"
git push
```

```bash
# 다른 맥에서
cd ~/dotfiles
git pull
./install.sh
source ~/.zshrc
alias ll
```

## 주요 파일 설명

### 대구분 1: 실행 진입점
#### 소구분: 쉘 시작 파일

| 파일 | 형식 | 역할 |
|---|---|---|
| `zsh/.zshrc` | Zsh 설정 | zsh 로딩 시작점 |
| `zsh/.zprofile` | Zsh 설정 | 로그인 셸 초기 경로 설정 |

### 대구분 2: 공통 zsh 모듈
#### 소구분: 기능 모듈

| 파일 | 형식 | 역할 |
|---|---|---|
| `zsh/conf/core.zsh` | Zsh 설정 | 캐시/테마 기본 로딩 |
| `zsh/conf/plugins.zsh` | Zsh 설정 | oh-my-zsh 및 plugin 로딩 |
| `zsh/conf/aliases.zsh` | Zsh 설정 | 공통 alias 모음 |
| `zsh/conf/path.zsh` | Zsh 설정 | PATH 기본 정책 |
| `zsh/conf/toolchains.zsh` | Zsh 설정 | nvm/rbenv/sdkman/zoxide 초기화 |
| `zsh/.p10k.zsh` | Zsh 설정 | 프롬프트 스타일 설정 |

### 대구분 3: 개인 설정
#### 소구분: 개인 전용 파일

| 파일 | 형식 | 역할 |
|---|---|---|
| `zsh/.zshrc.local.example` | Zsh 설정 예시 | 개인 설정 템플릿 |
| `~/.zshrc.local` | Zsh 설정 | 개인 경로/비밀값 (비커밋) |

### 대구분 4: 설치/운영 스크립트
#### 소구분: 자동화

| 파일 | 형식 | 역할 |
|---|---|---|
| `install.sh` | Shell Script | 백업 + 심볼릭 링크 설치 |
| `bootstrap.sh` | Shell Script | 환경 점검 후 설치 실행 |

### 대구분 5: 운영 문서
#### 소구분: 규칙/가이드

| 파일 | 형식 | 역할 |
|---|---|---|
| `README.md` | Markdown | 사용자 운영 가이드 |
| `Agents.md` | Markdown | 규칙 문서 인덱스 |
| `docs/agents/*.md` | Markdown | 에이전트 규칙/템플릿 SSoT |
