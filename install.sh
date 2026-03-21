#!/usr/bin/env zsh
set -euo pipefail

SCRIPT_DIR="${0:A:h}"
DOTFILES_DIR="${DOTFILES_DIR:-$SCRIPT_DIR}"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

backup_if_needed() {
  local target="$1"
  if [[ -e "$target" && ! -L "$target" ]]; then
    local backup="${target}.bak.${TIMESTAMP}"
    mv "$target" "$backup"
    echo "Backed up $target -> $backup"
  fi
}

link_file() {
  local src="$1"
  local dst="$2"
  backup_if_needed "$dst"
  ln -sfn "$src" "$dst"
  echo "Linked $dst -> $src"
}

if [[ ! -d "$DOTFILES_DIR/zsh" ]]; then
  echo "Cannot find $DOTFILES_DIR/zsh"
  echo "Set DOTFILES_DIR if your repo is elsewhere."
  exit 1
fi

link_file "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
link_file "$DOTFILES_DIR/zsh/.zprofile" "$HOME/.zprofile"

if [[ ! -f "$HOME/.zshrc.local" ]]; then
  cp "$DOTFILES_DIR/zsh/.zshrc.local.example" "$HOME/.zshrc.local"
  echo "Created $HOME/.zshrc.local from example"
fi

echo ""
echo "Validation"
if zsh -n "$DOTFILES_DIR/zsh/.zshrc"; then
  echo "- zsh syntax check passed"
else
  echo "- zsh syntax check failed"
  exit 1
fi

echo "Done. Open a new terminal or run: source ~/.zshrc"
