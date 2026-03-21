# Brewfile 가이드

이 저장소는 Brewfile을 **하나만** 사용합니다.
- 파일: `Brewfile`
- 목적: 새 맥에서 CLI 도구를 한 번에 복원
- 실행: `./install.sh --with-brew`

## 현재 포함 도구
`git`, `gh`, `jq`, `fzf`, `zoxide`, `fd`, `direnv`, `nvm`, `openjdk`, `grpcurl`, `httpie`, `watch`, `telnet`, `tmux`, `ripgrep`

## 새 도구 추가 방법
1. 설치: `brew install <tool>`
2. 반영: `Brewfile`에 `brew "<tool>"` 추가
3. 검증: `brew bundle check --file Brewfile --no-upgrade`

## 참고
- `sdkman`은 현재 Homebrew가 아닌 직접 설치 방식으로 사용합니다.
- zsh 초기화는 `zsh/conf/toolchains.zsh`에서 관리합니다.

## 공식 문서
- Homebrew Brew Bundle: https://docs.brew.sh/Brew-Bundle-and-Brewfile
- brew bundle 명령: `brew bundle --help`
