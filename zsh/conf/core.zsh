# Codex 세션에서만 캐시 경로를 분리합니다. 가능한 한 상단에 둡니다.
if [[ -n "$CODEX_HOME" ]]; then
  export XDG_CACHE_HOME="${XDG_CACHE_HOME:-/tmp/$USER-cache}"
  mkdir -p "$XDG_CACHE_HOME/zsh" "$XDG_CACHE_HOME/oh-my-zsh" 2>/dev/null
  export ZSH_CACHE_DIR="$XDG_CACHE_HOME/oh-my-zsh"
  export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/.zcompdump-${HOST}-${ZSH_VERSION}"
fi

# Powerlevel10k instant prompt는 가능한 한 초기에 로드합니다.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
