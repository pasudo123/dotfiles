# dotfiles

이 저장소는 zsh 환경을 이식하고 동기화하기 위한 설정 모음입니다.

## 목차
- [설치 가이드](#설치-가이드)
  - [A. 기본 설치 (권장)](#a-기본-설치-권장)
  - [왜 install.sh 하나로 운영하는가](#왜-installsh-하나로-운영하는가)
- [설정 확장 가이드](#설정-확장-가이드)
  - [1) 새 설정 추가](#1-새-설정-추가)
  - [2) 새 도구 추가](#2-새-도구-추가)
- [동기화 가이드 (예시)](#동기화-가이드-예시)
- [주요 파일 설명](#주요-파일-설명)

## 설치 가이드

### A. 기본 설치 (권장)
모든 환경에서 기본으로 `install.sh`를 사용합니다.

```bash
cd ~/dotfiles
./install.sh
```

새 맥에서는 추가로 개인 파일을 만듭니다.

```bash
cp zsh/.zshrc.local.example ~/.zshrc.local
```

### 왜 install.sh 하나로 운영하는가

| 항목 | install.sh |
|---|---|
| 기본 사용 여부 | 단일 진입점 |
| 환경 점검 | 포함(경고 출력) |
| 설치/백업/검증 | 포함 |
| 장점 | 명령이 하나라 혼동이 적음 |

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

| 단계 | 할 일 |
|---|---|
| 1 | 설치 확인 (`command -v <tool>`) |
| 2 | 위치 선택 (`toolchains`, `aliases`, `path`) |
| 3 | 조건부 로딩 작성 (`if command -v ...`) |
| 4 | 적용/검증 (`source ~/.zshrc`, `command -v <tool>`) |
| 5 | 공통 설정만 git 반영 |

예시:

```zsh
if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"
fi

if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi
```

## 동기화 가이드 (예시)

예시: 현재 맥에서 alias를 추가하고 다른 맥에 반영

```bash
# 현재 맥
cd ~/dotfiles
printf "\nalias ll='ls -al'\n" >> zsh/conf/aliases.zsh
source ~/.zshrc
git add zsh/conf/aliases.zsh
git commit -m "chore: add ll alias"
git push
```

```bash
# 다른 맥
cd ~/dotfiles
git pull
./install.sh
source ~/.zshrc
```

## 주요 파일 설명

| 대구분 | 소구분 | 파일 | 형식 | 역할 |
|---|---|---|---|---|
| 실행 진입점 | 쉘 시작 파일 | `zsh/.zshrc` | Zsh 설정 | zsh 로딩 시작점 |
| 실행 진입점 | 쉘 시작 파일 | `zsh/.zprofile` | Zsh 설정 | 로그인 셸 초기 경로 설정 |
| 공통 zsh 모듈 | 기능 모듈 | `zsh/conf/core.zsh` | Zsh 설정 | 캐시/테마 기본 로딩 |
| 공통 zsh 모듈 | 기능 모듈 | `zsh/conf/plugins.zsh` | Zsh 설정 | oh-my-zsh 및 plugin 로딩 |
| 공통 zsh 모듈 | 기능 모듈 | `zsh/conf/aliases.zsh` | Zsh 설정 | 공통 alias 모음 |
| 공통 zsh 모듈 | 기능 모듈 | `zsh/conf/path.zsh` | Zsh 설정 | PATH 기본 정책 |
| 공통 zsh 모듈 | 기능 모듈 | `zsh/conf/toolchains.zsh` | Zsh 설정 | 도구체인 초기화 |
| 공통 zsh 모듈 | 기능 모듈 | `zsh/.p10k.zsh` | Zsh 설정 | 프롬프트 스타일 |
| 개인 설정 | 개인 전용 파일 | `zsh/.zshrc.local.example` | Zsh 설정 예시 | 개인 설정 템플릿 |
| 개인 설정 | 개인 전용 파일 | `~/.zshrc.local` | Zsh 설정 | 개인 경로/비밀값 (비커밋) |
| 설치/운영 스크립트 | 자동화 | `install.sh` | Shell Script | 환경 점검 + 백업 + 링크 설치 |
