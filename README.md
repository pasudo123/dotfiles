# dotfiles

이 저장소는 터미널 설정을 안전하게 옮기기 위한 집입니다.
지금 잘 되는 설정을 백업하고, 새 PC에서도 거의 똑같이 쓰게 해줍니다.
첫 이관에서는 **이전 동작을 최대한 유지하기 위해 파일만 분리했고, 기능은 바꾸지 않는 것**을 원칙으로 했습니다.

## 0) 처음 1번만 설치

```bash
cd ~/dotfiles
./bootstrap.sh
```

새 터미널을 열면 적용됩니다.

## 새 맥 / 새 환경 설치

새 맥에서는 백업 파일(`*.bak.*`)이 없어도 아래 순서로 설치하면 됩니다.

```bash
# 1) 저장소 받기
git clone <your-repo> ~/dotfiles
cd ~/dotfiles

# 2) dotfiles 링크 설치
./install.sh

# 3) 개인 설정 파일 만들기
cp zsh/.zshrc.local.example ~/.zshrc.local
```

그다음 `~/.zshrc.local`에 내 PC 전용 경로를 넣고, 필요한 도구(oh-my-zsh, powerlevel10k, plugin)를 설치하세요.
설치 후 새 터미널을 열거나 `source ~/.zshrc`를 실행하면 됩니다.

## 1) 새 설정을 추가할 때

공통 설정인지, 내 PC 전용 설정인지 먼저 고릅니다.

- 공통 설정: `zsh/conf/*.zsh` 파일에 추가 (git 커밋 대상)
- 내 PC 전용: `~/.zshrc.local`에 추가 (git 커밋 금지)

순서:

```bash
# 1) 파일 수정
# 2) 바로 반영
source ~/.zshrc

# 3) 문제 없는지 확인
zsh -n ~/.zshrc
```

공통 설정만 커밋하세요.

## 2) 새 도구를 붙일 때

규칙은 간단합니다: 설치 확인 -> 조건부 로딩 -> 동작 확인

```bash
# 예시: 도구 설치 확인
command -v <tool-name>
```

- 도구 초기화 코드는 `zsh/conf/toolchains.zsh`에 추가
- 반드시 `if command -v <tool-name> ...` 형태로 감쌉니다
- 설치 안 된 PC에서도 에러가 나지 않아야 합니다

예시:

```zsh
if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"
fi
```

## 3) 잘되지 않는 경우

아래 3가지만 순서대로 확인하면 대부분 해결됩니다.

```bash
# 1) 문법 에러 확인
zsh -n ~/.zshrc

# 2) 실제 로드하면서 에러 보기
source ~/.zshrc

# 3) 링크 확인
ls -l ~/.zshrc ~/.p10k.zsh ~/.zprofile
```

## 현재 맥에서 원래 설정으로 되돌리기

백업 파일이 있는 현재 맥에서만 아래 절차를 사용하세요.
백업 파일이 없으면 이 절차를 사용하지 말고, 새 맥 설치 절차를 따르세요.

```bash
# 0) 먼저 백업 파일이 있는지 확인
ls ~/.zshrc.bak.*
ls ~/.p10k.zsh.bak.*
ls ~/.zprofile.bak.*

# 아래 <latest-backup>는 위 ls 결과에서 가장 최신 파일명으로 직접 바꿔서 사용

# 1) ~/.zshrc 원복 (백업 파일이 있을 때만 실행)
rm -f ~/.zshrc
cp ~/.zshrc.bak.<latest-backup> ~/.zshrc

# 2) ~/.p10k.zsh 원복 (백업 파일이 있을 때만 실행)
rm -f ~/.p10k.zsh
cp ~/.p10k.zsh.bak.<latest-backup> ~/.p10k.zsh

# 3) ~/.zprofile 원복 (백업 파일이 있을 때만 실행)
rm -f ~/.zprofile
cp ~/.zprofile.bak.<latest-backup> ~/.zprofile
```

## 4) 이후 절차들
새 맥/새 환경에 옮길 때는 위의 `새 맥 / 새 환경 설치` 섹션을 따르세요.

### 설정을 바꾼 뒤 동기화

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

## 파일 설명

- `zsh/.zshrc`: 시작 파일(얇게 유지)
- `zsh/conf/core.zsh`: 캐시/테마 기본 설정
- `zsh/conf/plugins.zsh`: oh-my-zsh + plugins
- `zsh/conf/aliases.zsh`: alias
- `zsh/conf/path.zsh`: PATH 정책
- `zsh/conf/toolchains.zsh`: nvm/rbenv/sdkman/zoxide
- `zsh/.zprofile`: 로그인 셸 PATH
- `zsh/.p10k.zsh`: 프롬프트 스타일
- `zsh/.zshrc.local.example`: 개인 설정 예시
- `install.sh`: 안전 백업 + 링크 생성
- `bootstrap.sh`: 신규 PC 점검 + 설치
