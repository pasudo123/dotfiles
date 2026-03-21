plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
fi

# 프롬프트 테마 설정
[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"
