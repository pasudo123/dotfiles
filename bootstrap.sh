#!/usr/bin/env zsh
set -euo pipefail

# 이 스크립트는 "현재 환경 점검 + install.sh 실행"을 한 번에 처리합니다.
# 새 맥/현재 맥 모두 사용 가능하지만, 특히 첫 이관 시 점검용으로 유용합니다.

SCRIPT_DIR="${0:A:h}"
DOTFILES_DIR="${DOTFILES_DIR:-$SCRIPT_DIR}"

# dotfiles 경로 확인
if [[ ! -d "$DOTFILES_DIR" ]]; then
  echo "Cannot find $DOTFILES_DIR"
  echo "Clone your dotfiles to $HOME/dotfiles or set DOTFILES_DIR"
  exit 1
fi

# Homebrew 존재 여부 점검
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is not installed. Install it first from https://brew.sh"
else
  echo "Homebrew detected"
fi

# oh-my-zsh 설치 여부 점검
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "oh-my-zsh not found at $HOME/.oh-my-zsh"
  echo 'Install with: sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
else
  echo "oh-my-zsh detected"
fi

# oh-my-zsh가 있으면 테마/플러그인도 함께 점검
if [[ -d "$HOME/.oh-my-zsh" ]]; then
  THEME_DIR="$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
  if [[ ! -d "$THEME_DIR" ]]; then
    echo "powerlevel10k theme missing."
    echo "Install with: git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \"$THEME_DIR\""
  else
    echo "powerlevel10k detected"
  fi

  AUTOSUGGEST_DIR="$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
  if [[ ! -d "$AUTOSUGGEST_DIR" ]]; then
    echo "zsh-autosuggestions plugin missing."
    echo "Install with: git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \"$AUTOSUGGEST_DIR\""
  else
    echo "zsh-autosuggestions detected"
  fi

  SYNTAX_HIGHLIGHT_DIR="$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
  if [[ ! -d "$SYNTAX_HIGHLIGHT_DIR" ]]; then
    echo "zsh-syntax-highlighting plugin missing."
    echo "Install with: git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git \"$SYNTAX_HIGHLIGHT_DIR\""
  else
    echo "zsh-syntax-highlighting detected"
  fi
fi

# 실제 링크 설치는 install.sh가 담당
"$DOTFILES_DIR/install.sh"
