# dotfiles에서 관리하는 zsh 진입점 파일입니다.
# 이 파일은 얇게 유지하고 실제 설정은 zsh/conf에서 불러옵니다.

_DOTFILES_ZSH_FILE="${${(%):-%N}:A}"
DOTFILES_ZSH_DIR="${DOTFILES_ZSH_DIR:-${_DOTFILES_ZSH_FILE:h}}"
unset _DOTFILES_ZSH_FILE

for file in \
  "$DOTFILES_ZSH_DIR/conf/core.zsh" \
  "$DOTFILES_ZSH_DIR/conf/plugins.zsh" \
  "$HOME/.zshrc.local" \
  "$DOTFILES_ZSH_DIR/conf/aliases.zsh" \
  "$DOTFILES_ZSH_DIR/conf/path.zsh" \
  "$DOTFILES_ZSH_DIR/conf/toolchains.zsh"
do
  [[ -f "$file" ]] && source "$file"
done
