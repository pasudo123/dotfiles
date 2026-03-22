# 과거 맥북 세팅 문서 참고 정리

원문:
- https://github.com/pasudo123/software-zero-to-all/blob/main/dummy/macbook_setting.md

## 왜 별도 보관했는가
- 원문은 맥 전체 환경(폰트, 핫코너, GUI 앱, IDE 세팅)까지 포함한 종합 체크리스트입니다.
- 현재 `dotfiles` 저장소의 목적은 `zsh + CLI 이식` 중심이라, 메인 README에 합치면 다시 복잡해집니다.
- 따라서 이 문서는 **참고 보관용**으로만 유지합니다.

## dotfiles에 이미 반영된 항목
| 항목 | 현재 반영 위치 |
|---|---|
| powerlevel10k/oh-my-zsh/plugin 안내 | `install.sh` 환경 점검 |
| alias (`gitlog`, `k`) | `zsh/conf/aliases.zsh` |
| CLI 도구 복원 | `Brewfile`, `docs/brewfile.md` |
| sdkman 초기화 | `zsh/conf/toolchains.zsh` |

## dotfiles 범위 밖이라 유지하지 않은 항목
| 항목 | 이유 |
|---|---|
| 핫코너/시간 표시/배터리/백틱 설정 | macOS GUI 개인 설정 |
| 폰트(Cascadia Code) | 개인 취향 설정 |
| GUI 앱 목록(Notion, Sourcetree, Charles 등) | dotfiles 핵심 범위 밖 |
| IDE 내부 설정(IntelliJ/DataGrip 템플릿 등) | 툴별 계정/개인 설정 |

## 사용 방법
- 새 맥 이관 시 기본은 `README.md`와 `docs/brewfile.md`를 먼저 따릅니다.
- 필요한 경우에만 이 문서를 열어, 과거 맥 개인 취향 설정을 추가로 적용합니다.
