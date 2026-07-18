# mac-terminal-setup — sourced from ~/.zshrc
# WezTerm + Starship + friends. Type `shrc` for the shortcut cheat sheet.

BREW_PREFIX="$(brew --prefix 2>/dev/null || echo /opt/homebrew)"

# eza: prettier ls
alias ls='eza --icons'
alias ll='eza -la --icons --git'
alias lt='eza --tree --level=2 --icons'

# bat: syntax-highlighted cat, themed to match the terminal
export BAT_THEME="Catppuccin Mocha"

# zoxide: 'z <fragment>' jumps to frequently used directories
eval "$(zoxide init zsh)"

# fzf: fuzzy Ctrl+R history search, Ctrl+T file finder
source <(fzf --zsh)

# yazi: 'y' opens the file manager and cds to wherever you navigated
y() {
  local tmp cwd
  tmp="$(mktemp -t yazi-cwd.XXXXXX)"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# ghost-text suggestions from history (accept with →)
source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# starship prompt
eval "$(starship init zsh)"

# print wezterm shortcut cheat sheet
shrc() {
  local H=$'\e[1;34m' K=$'\e[1;33m' D=$'\e[0;37m' R=$'\e[0m'
  printf '\n%sWezTerm Shortcuts%s\n\n' "$H" "$R"
  printf '%s  Panes%s\n' "$H" "$R"
  printf "  ${K}%-22s${D}%s${R}\n" \
    'Cmd + \'            'split pane right' \
    'Cmd + Shift + \'    'split pane down' \
    'Opt + Cmd + arrows' 'move between panes' \
    'Cmd + W'            'close pane (then tab)' \
    'Ctrl + Shift + Z'   'zoom/unzoom current pane'
  printf '\n%s  Tabs%s\n' "$H" "$R"
  printf "  ${K}%-22s${D}%s${R}\n" \
    'Cmd + T'            'new tab' \
    'Cmd + 1..9'         'jump to tab' \
    'Cmd + Shift + ] ['  'next / previous tab'
  printf '\n%s  Windows%s\n' "$H" "$R"
  printf "  ${K}%-22s${D}%s${R}\n" \
    'Cmd + N'            'new window' \
    'Cmd + `'            'swap between windows' \
    'Cmd + M'            'minimize window'
  printf '\n%s  Editing & misc%s\n' "$H" "$R"
  printf "  ${K}%-22s${D}%s${R}\n" \
    'Opt + Left/Right'   'jump by word' \
    'Cmd + Left/Right'   'start / end of line' \
    'Opt + Backspace'    'delete previous word' \
    'Cmd + Backspace'    'delete to start of line' \
    'Cmd + K'            'clear terminal' \
    'Cmd + F'            'search scrollback' \
    'Cmd + +/-/0'        'font size bigger / smaller / reset'
  printf '\n%s  Tools%s\n' "$H" "$R"
  printf "  ${K}%-22s${D}%s${R}\n" \
    'y'                  'file manager (yazi) — q quits into that folder' \
    'z <fragment>'       'jump to a frequent directory' \
    'Ctrl + R'           'fuzzy search command history' \
    'll / lt'            'detailed list / tree view' \
    'bat <file>'         'pretty file viewer' \
    'btop'               'system monitor' \
    'shrc'               'this cheat sheet'
  printf '\n'
}

# command syntax highlighting (must be sourced last)
source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
