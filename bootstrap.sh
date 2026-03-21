#!/usr/bin/env zsh
set -euo pipefail

SCRIPT_DIR="${0:A:h}"
DOTFILES_DIR="${DOTFILES_DIR:-$SCRIPT_DIR}"

if [[ ! -d "$DOTFILES_DIR" ]]; then
  echo "Cannot find $DOTFILES_DIR"
  echo "Clone your dotfiles to $HOME/dotfiles or set DOTFILES_DIR"
  exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is not installed. Install it first from https://brew.sh"
else
  echo "Homebrew detected"
fi

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "oh-my-zsh not found at $HOME/.oh-my-zsh"
  echo 'Install with: sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
else
  echo "oh-my-zsh detected"
fi

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

"$DOTFILES_DIR/install.sh"
