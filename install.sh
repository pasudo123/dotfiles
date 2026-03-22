#!/usr/bin/env zsh
set -euo pipefail

# 이 스크립트는 dotfiles 설치의 단일 진입점입니다.
# 1) 환경 점검(경고)
# 2) 기존 파일 백업
# 3) 심볼릭 링크 설치
# 4) 선택적 Brewfile 설치
# 5) 문법 검증

SCRIPT_DIR="${0:A:h}"
DOTFILES_DIR="${DOTFILES_DIR:-$SCRIPT_DIR}"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
WITH_BREW=0

# 터미널에서만 색상 사용
if [[ -t 1 ]]; then
  C_RESET=$'\033[0m'
  C_RED=$'\033[31m'
  C_YELLOW=$'\033[33m'
  C_GREEN=$'\033[32m'
else
  C_RESET=''
  C_RED=''
  C_YELLOW=''
  C_GREEN=''
fi

info() {
  echo "[INFO] $1"
}

warn() {
  echo "${C_YELLOW}[WARN] $1${C_RESET}"
}

ok() {
  echo "${C_GREEN}[OK] $1${C_RESET}"
}

error() {
  echo "${C_RED}[ERROR] $1${C_RESET}"
}

usage() {
  cat <<'USAGE'
사용법:
  ./install.sh [--with-brew] [--help]

옵션:
  --with-brew  Brewfile에 정의된 CLI/앱을 설치합니다.
  --help       도움말을 출력합니다.
USAGE
}

backup_if_needed() {
  local target="$1"
  if [[ -e "$target" && ! -L "$target" ]]; then
    local backup="${target}.bak.${TIMESTAMP}"
    mv "$target" "$backup"
    info "Backed up $target -> $backup"
  fi
}

link_file() {
  local src="$1"
  local dst="$2"
  backup_if_needed "$dst"
  ln -sfn "$src" "$dst"
  info "Linked $dst -> $src"
}

install_brew_bundle() {
  local brewfile="$DOTFILES_DIR/Brewfile"

  if [[ "$WITH_BREW" -ne 1 ]]; then
    info "Brewfile 설치는 생략했습니다. 필요하면 ./install.sh --with-brew 를 실행하세요."
    return
  fi

  if ! command -v brew >/dev/null 2>&1; then
    warn "Homebrew가 없어 Brewfile 설치를 건너뜁니다."
    warn "Homebrew 설치: https://brew.sh"
    return
  fi

  if [[ ! -f "$brewfile" ]]; then
    warn "Brewfile이 없어 Brewfile 설치를 건너뜁니다: $brewfile"
    return
  fi

  info "Brewfile 설치를 시작합니다."
  brew bundle --file "$brewfile"
  ok "Brewfile 설치가 완료되었습니다."
}

check_environment() {
  info "Environment checks"

  if ! command -v brew >/dev/null 2>&1; then
    warn "Homebrew not found. Install from https://brew.sh"
  else
    ok "Homebrew detected"
  fi

  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    warn "oh-my-zsh not found at $HOME/.oh-my-zsh"
    warn 'Install with: sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
    return
  fi

  ok "oh-my-zsh detected"

  local theme_dir="$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
  if [[ ! -d "$theme_dir" ]]; then
    warn "powerlevel10k theme missing"
    warn "Install with: git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \"$theme_dir\""
  else
    ok "powerlevel10k detected"
  fi

  local autosuggest_dir="$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
  if [[ ! -d "$autosuggest_dir" ]]; then
    warn "zsh-autosuggestions plugin missing"
    warn "Install with: git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \"$autosuggest_dir\""
  else
    ok "zsh-autosuggestions detected"
  fi

  local syntax_highlight_dir="$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
  if [[ ! -d "$syntax_highlight_dir" ]]; then
    warn "zsh-syntax-highlighting plugin missing"
    warn "Install with: git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git \"$syntax_highlight_dir\""
  else
    ok "zsh-syntax-highlighting detected"
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --with-brew)
      WITH_BREW=1
      shift
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      error "알 수 없는 옵션입니다: $1"
      usage
      exit 1
      ;;
  esac
done

if [[ ! -d "$DOTFILES_DIR/zsh" ]]; then
  error "Cannot find $DOTFILES_DIR/zsh"
  error "Set DOTFILES_DIR if your repo is elsewhere."
  exit 1
fi

check_environment

echo ""
info "Linking dotfiles"
link_file "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
link_file "$DOTFILES_DIR/zsh/.zprofile" "$HOME/.zprofile"

if [[ ! -f "$HOME/.zshrc.local" ]]; then
  cp "$DOTFILES_DIR/zsh/.zshrc.local.example" "$HOME/.zshrc.local"
  info "Created $HOME/.zshrc.local from example"
fi

echo ""
install_brew_bundle

echo ""
info "Validation"
if zsh -n "$DOTFILES_DIR/zsh/.zshrc"; then
  ok "zsh syntax check passed"
else
  error "zsh syntax check failed"
  error "Check zsh/.zshrc and zsh/conf/*.zsh in dotfiles"
  exit 1
fi

echo ""
ok "Done. Open a new terminal or run: source ~/.zshrc"
