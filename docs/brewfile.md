# Brewfile 가이드

이 저장소는 Brewfile을 **하나만** 사용합니다.
- 파일: `Brewfile`
- 목적: 새 맥에서 CLI 도구를 한 번에 복원
- 실행: `./install.sh --with-brew`

## 현재 포함 도구
`git`, `gh`, `jq`, `bat`, `fzf`, `zoxide`, `fd`, `direnv`, `nvm`, `openjdk`, `grpcurl`, `httpie`, `watch`, `telnet`, `tmux`, `ripgrep`, `gemini-cli`

| 도구 | 용도 | 공식 링크 |
|---|---|---|
| `git` | 버전 관리 | https://git-scm.com/ |
| `gh` | GitHub CLI | https://cli.github.com/ |
| `jq` | JSON 파싱/필터링 | https://jqlang.org/ |
| `bat` | 구문 강조를 지원하는 파일 출력 | https://github.com/sharkdp/bat |
| `fzf` | 퍼지 검색 | https://github.com/junegunn/fzf |
| `zoxide` | 디렉토리 이동 보조 | https://github.com/ajeetdsouza/zoxide |
| `fd` | 빠른 파일 검색 | https://github.com/sharkdp/fd |
| `direnv` | 디렉토리별 환경변수 관리 | https://direnv.net/ |
| `nvm` | Node.js 버전 관리 | https://github.com/nvm-sh/nvm |
| `openjdk` | Java 런타임/개발 | https://openjdk.org/ |
| `grpcurl` | gRPC API 테스트 | https://github.com/fullstorydev/grpcurl |
| `httpie` | HTTP API 테스트 | https://httpie.io/ |
| `watch` | 명령 반복 실행 | https://formulae.brew.sh/formula/watch |
| `telnet` | 포트/네트워크 점검 | https://formulae.brew.sh/formula/telnet |
| `tmux` | 터미널 멀티플렉서 | https://github.com/tmux/tmux/wiki |
| `ripgrep` | 빠른 텍스트 검색 | https://github.com/BurntSushi/ripgrep |
| `gemini-cli` | 터미널 기반 Gemini 에이전트 | https://github.com/google-gemini/gemini-cli |

## 새 도구 추가 방법
1. 설치: `brew install <tool>`
2. 반영: `Brewfile`에 `brew "<tool>"` 추가
3. 검증: `brew bundle check --file Brewfile --no-upgrade`

## 참고
- `sdkman`은 현재 Homebrew가 아닌 직접 설치 방식으로 사용합니다.
- zsh 초기화는 `zsh/conf/toolchains.zsh`에서 관리합니다.
- 실제 사용 예시는 `docs/cli-cheatsheet.md`를 참고합니다.

## 공식 문서
- Homebrew Brew Bundle: https://docs.brew.sh/Brew-Bundle-and-Brewfile
- brew bundle 명령: `brew bundle --help`
