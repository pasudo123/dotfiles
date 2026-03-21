# dotfiles

이 저장소는 zsh 환경을 안전하게 백업/이식하기 위한 설정 모음입니다.
첫 이관에서는 **기능 변경 없이 파일만 분리**하는 것을 원칙으로 합니다.

## 0) 처음 1번만 설치 (현재 맥 기준)

```bash
cd ~/dotfiles
./bootstrap.sh
```

`bootstrap.sh`는 환경 점검(Homebrew, oh-my-zsh, plugin) 후 `install.sh`를 실행합니다.

## 새 맥 / 새 환경 설치

새 맥은 백업 파일(`*.bak.*`)이 없어도 아래 순서로 진행하면 됩니다.

```bash
# 1) 저장소 받기
git clone <your-repo> ~/dotfiles
cd ~/dotfiles

# 2) 링크 설치
./install.sh

# 3) 개인 설정 파일 만들기
cp zsh/.zshrc.local.example ~/.zshrc.local
```

그다음 `~/.zshrc.local`에 개인 경로를 입력하고, 필요한 도구를 설치하세요.
설치 후 새 터미널을 열거나 `source ~/.zshrc`를 실행합니다.

## "처음 1번만 설치"와 "새 맥 / 새 환경 설치" 차이

| 구분 | 처음 1번만 설치 (현재 맥) | 새 맥 / 새 환경 설치 |
|---|---|---|
| 목적 | 기존 환경 점검 + 이관 | 빈 환경에서 처음 구성 |
| 실행 명령 | `./bootstrap.sh` | `./install.sh` |
| 도구 점검 | 포함(Homebrew, oh-my-zsh, plugin) | 별도(사용자가 설치) |
| 백업 파일 필요 | 기존 파일 백업 생성 가능 | 불필요 |
| 추천 상황 | 이미 쓰던 맥에서 dotfiles 첫 적용 | 새 맥, 새 계정, 클린 환경 |

## 1) 새 설정을 추가할 때

공통 설정인지 개인 설정인지 먼저 나눕니다.

- 공통 설정(커밋 대상): `zsh/conf/*.zsh`
- 개인 설정(커밋 금지): `~/.zshrc.local`

```bash
# 수정 후 즉시 반영
source ~/.zshrc

# 문법 확인
zsh -n ~/.zshrc
```

## 2) 새 도구를 붙일 때 (상세 가이드)

아래 순서를 지키면, 다른 PC에서도 안전하게 동작합니다.

1. 설치 확인

```bash
command -v <tool-name>
```

2. 로딩 위치 선택
- 쉘 초기화/도구 초기화: `zsh/conf/toolchains.zsh`
- 단순 alias: `zsh/conf/aliases.zsh`
- PATH 관련: `zsh/conf/path.zsh`

3. 조건부 로딩 작성 (필수)
- 도구가 설치되지 않은 PC에서도 에러가 나지 않아야 합니다.

좋은 예:

```zsh
if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"
fi

if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi
```

나쁜 예:

```zsh
# 설치 안 된 환경에서 즉시 에러 발생 가능
# eval "$(fzf --zsh)"
# eval "$(direnv hook zsh)"
```

4. 검증

```bash
source ~/.zshrc
command -v fzf direnv
```

## 3) 잘되지 않는 경우

```bash
# 1) 문법 확인
zsh -n ~/.zshrc

# 2) 즉시 로드 에러 확인
source ~/.zshrc

# 3) 링크 확인
ls -l ~/.zshrc ~/.p10k.zsh ~/.zprofile
```

## 현재 맥에서 원래 설정으로 되돌리기

백업 파일이 있는 현재 맥에서만 사용하세요.
백업 파일이 없으면 이 절차를 사용하지 말고, `새 맥 / 새 환경 설치` 절차를 따르세요.

```bash
# 0) 백업 파일 확인
ls ~/.zshrc.bak.*
ls ~/.p10k.zsh.bak.*
ls ~/.zprofile.bak.*

# 아래 <latest-backup>는 위에서 확인한 최신 파일명으로 직접 입력

# 1) ~/.zshrc 원복
rm -f ~/.zshrc
cp ~/.zshrc.bak.<latest-backup> ~/.zshrc

# 2) ~/.p10k.zsh 원복
rm -f ~/.p10k.zsh
cp ~/.p10k.zsh.bak.<latest-backup> ~/.p10k.zsh

# 3) ~/.zprofile 원복
rm -f ~/.zprofile
cp ~/.zprofile.bak.<latest-backup> ~/.zprofile
```

## 4) 이후 절차 (동기화)

```bash
cd ~/dotfiles
git add .
git commit -m "chore: update zsh config"
git push
```

다른 PC에서는:

```bash
cd ~/dotfiles
git pull
./install.sh
```

## 파일 형식 안내 (간단)

| 형식 | 예시 | 용도 |
|---|---|---|
| Shell Script (`.sh`) | `install.sh`, `bootstrap.sh` | 자동 설치/점검 실행 |
| Zsh 설정 (`.zsh`, `.zshrc`, `.zprofile`) | `zsh/conf/*.zsh`, `zsh/.zshrc` | 쉘 동작/도구 초기화 |
| Markdown (`.md`) | `README.md`, `RELEASE_TEMPLATE.md` | 사용 가이드/문서화 |
| Ignore (`.gitignore`) | `.gitignore` | 로컬 파일 커밋 제외 |

## 주요 파일 설명 (표)

| 파일 | 형식 | 역할 | 수정 위치 | 커밋 |
|---|---|---|---|---|
| `zsh/.zshrc` | Zsh 설정 | 로딩 진입점(얇은 파일) | 공통 | 예 |
| `zsh/conf/core.zsh` | Zsh 설정 | 캐시/테마 기본 설정 | 공통 | 예 |
| `zsh/conf/plugins.zsh` | Zsh 설정 | oh-my-zsh + plugin 로딩 | 공통 | 예 |
| `zsh/conf/aliases.zsh` | Zsh 설정 | alias 모음 | 공통 | 예 |
| `zsh/conf/path.zsh` | Zsh 설정 | PATH 정책 | 공통 | 예 |
| `zsh/conf/toolchains.zsh` | Zsh 설정 | nvm/rbenv/sdkman/zoxide | 공통 | 예 |
| `zsh/.zprofile` | Zsh 설정 | 로그인 셸 경로 설정 | 공통 | 예 |
| `zsh/.p10k.zsh` | Zsh 설정 | 프롬프트 스타일 | 공통 | 예 |
| `zsh/.zshrc.local.example` | Zsh 설정 예시 | 개인 설정 샘플 | 공통(예시) | 예 |
| `~/.zshrc.local` | Zsh 설정 | 개인 경로/비밀값 | 개인 | 아니오 |
| `install.sh` | Shell Script | 백업 + 심볼릭 링크 설치 | 공통 | 예 |
| `bootstrap.sh` | Shell Script | 환경 점검 후 설치 실행 | 공통 | 예 |
| `.gitignore` | Ignore | 로컬 파일 커밋 방지 | 공통 | 예 |
| `README.md` | Markdown | 운영 가이드 | 공통 | 예 |
