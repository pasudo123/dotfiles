# dotfiles

이 저장소는 zsh·cmux·Ghostty 환경과 CLI 도구를 새 맥으로 이식하기 위한 설정 모음입니다.

## 목차
- [설치 가이드](#설치-가이드)
- [설정 확장 가이드](#설정-확장-가이드)
- [동기화 가이드 (예시)](#동기화-가이드-예시)
- [주요 파일 설명](#주요-파일-설명)

## 설치 가이드

### 1) 기본 설치 (셸/터미널 설정 링크)
```bash
cd ~/dotfiles
./install.sh
```

### 2) CLI 도구까지 함께 설치
```bash
cd ~/dotfiles
./install.sh --with-brew
```

Brewfile 운영 방법은 별도 문서에서 확인하세요.
- [Brewfile 가이드](docs/brewfile.md)
- [CLI 치트시트](docs/cli-cheatsheet.md)
- [과거 맥북 세팅 참고](docs/reference/macbook-setting-legacy.md)
- Homebrew 공식 문서: https://docs.brew.sh/Brew-Bundle-and-Brewfile

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
| 1 | 설치 (`brew install <tool>`) |
| 2 | `Brewfile` 반영 (`brew "<tool>"`) |
| 3 | zsh 초기화 코드 추가 (`zsh/conf/toolchains.zsh` 등) |
| 4 | 적용/검증 (`source ~/.zshrc`, `command -v <tool>`) |
| 5 | 커밋/푸시 |

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
      <td rowspan="3">터미널</td>
      <td>cmux</td>
      <td><code>cmux/cmux.json</code></td>
      <td>JSONC</td>
      <td>작업 공간 및 사이드바 동작</td>
    </tr>
    <tr>
      <td>cmux 터미널 UI</td>
      <td><code>cmux/config.ghostty</code></td>
      <td>Ghostty 설정</td>
      <td>cmux 사이드바·surface tab 글자 크기</td>
    </tr>
    <tr>
      <td>Ghostty</td>
      <td><code>ghostty/config</code></td>
      <td>Ghostty 설정</td>
      <td>cmux 터미널의 글꼴·테마·기본 작업 경로</td>
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
      <td>CLI 선언 목록 (단일)</td>
    </tr>
  </tbody>
</table>
