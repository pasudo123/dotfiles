#!/usr/bin/env zsh
set -euo pipefail

# 이 스크립트는 dotfiles 파일을 홈 디렉터리에 심볼릭 링크로 연결합니다.
# 기존 일반 파일이 있으면 바로 덮어쓰지 않고 .bak.<timestamp>로 먼저 백업합니다.
# 목적: AI 도움 없이도 안전하게 설치/재설치를 반복할 수 있게 만들기.

SCRIPT_DIR="${0:A:h}"
DOTFILES_DIR="${DOTFILES_DIR:-$SCRIPT_DIR}"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

# 대상 파일이 "일반 파일"이면 백업합니다.
# 이미 심볼릭 링크라면 백업하지 않고 링크만 갱신합니다.
backup_if_needed() {
  local target="$1"
  if [[ -e "$target" && ! -L "$target" ]]; then
    local backup="${target}.bak.${TIMESTAMP}"
    mv "$target" "$backup"
    echo "Backed up $target -> $backup"
  fi
}

# src를 dst로 심볼릭 링크합니다.
# -s: symbolic, -f: 기존 링크 덮어쓰기, -n: 링크 대상 디렉터리도 안전하게 처리
link_file() {
  local src="$1"
  local dst="$2"
  backup_if_needed "$dst"
  ln -sfn "$src" "$dst"
  echo "Linked $dst -> $src"
}

# dotfiles 구조가 예상과 다르면 중단합니다.
if [[ ! -d "$DOTFILES_DIR/zsh" ]]; then
  echo "Cannot find $DOTFILES_DIR/zsh"
  echo "Set DOTFILES_DIR if your repo is elsewhere."
  exit 1
fi

# 핵심 zsh 파일 3개를 홈 디렉터리와 연결합니다.
link_file "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
link_file "$DOTFILES_DIR/zsh/.zprofile" "$HOME/.zprofile"

# 개인 설정 파일이 없으면 예시 파일을 복사해 시작점을 제공합니다.
if [[ ! -f "$HOME/.zshrc.local" ]]; then
  cp "$DOTFILES_DIR/zsh/.zshrc.local.example" "$HOME/.zshrc.local"
  echo "Created $HOME/.zshrc.local from example"
fi

# 기본 문법 검증: 최소한 zsh 진입 파일 문법이 맞는지 확인합니다.
# 실패하면 새 터미널을 열기 전에 바로 문제를 알 수 있습니다.
echo ""
echo "Validation"
if zsh -n "$DOTFILES_DIR/zsh/.zshrc"; then
  echo "- zsh syntax check passed"
else
  echo "- zsh syntax check failed"
  echo "- Check zsh/.zshrc and zsh/conf/*.zsh in dotfiles"
  exit 1
fi

echo "Done. Open a new terminal or run: source ~/.zshrc"
