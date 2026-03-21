export USER_HOME="$HOME"
export PATH="$HOME/.rbenv/shims:/opt/homebrew/opt/mongodb-community@4.2/bin:/opt/homebrew/opt/mysql@8.0/bin:$PATH"
[[ -n "${MVN_PATH:-}" ]] && export PATH="$PATH:$MVN_PATH"
[[ -n "${FLUTTER_PATH:-}" ]] && export PATH="$PATH:$FLUTTER_PATH"
