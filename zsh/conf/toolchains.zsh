# rbenv 초기화
if command -v rbenv >/dev/null 2>&1; then
  eval "$(rbenv init - zsh)"
fi

# nvm 초기화
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
if command -v nvm >/dev/null 2>&1; then
  nvm use --silent default >/dev/null 2>&1
fi

# SDKMAN 초기화
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# zoxide 초기화
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# fzf 검색 기본값을 fd로 설정
if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# fzf 셸 통합 로드 (키 바인딩/완성)
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

# direnv 훅 로드
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# iTerm2 integration은 파일 끝부분에서 로드합니다.
[[ -e "$HOME/.iterm2_shell_integration.zsh" ]] && source "$HOME/.iterm2_shell_integration.zsh"
