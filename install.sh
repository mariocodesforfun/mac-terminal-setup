#!/usr/bin/env bash
# mac-terminal-setup installer — safe to re-run any time.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
STAMP="$(date +%Y%m%d-%H%M%S)"

say()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33mwarning:\033[0m %s\n' "$*"; }

[[ "$(uname)" == "Darwin" ]] || { echo "This setup is macOS-only."; exit 1; }

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required. Install it first:"
  echo '  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
  echo "then re-run ./install.sh"
  exit 1
fi

say "Installing packages (existing ones are skipped)…"
[[ -d /Applications/WezTerm.app ]] || brew install --cask wezterm
brew install starship fastfetch zsh-autosuggestions zsh-syntax-highlighting \
  fzf yazi zoxide eza bat btop

backup_then_copy() {
  local src="$1" dest="$2"
  if [[ -e "$dest" && ! -L "$dest" ]]; then
    warn "backing up existing $(basename "$dest") to $dest.bak-$STAMP"
    mv "$dest" "$dest.bak-$STAMP"
  fi
  mkdir -p "$(dirname "$dest")"
  cp "$src" "$dest"
}

say "Copying configs…"
backup_then_copy "$REPO_DIR/wezterm/wezterm.lua"    "$HOME/.wezterm.lua"
backup_then_copy "$REPO_DIR/starship/starship.toml" "$CONFIG_DIR/starship.toml"
backup_then_copy "$REPO_DIR/btop/btop.conf"         "$CONFIG_DIR/btop/btop.conf"
backup_then_copy "$REPO_DIR/btop/themes/catppuccin_mocha.theme" \
  "$CONFIG_DIR/btop/themes/catppuccin_mocha.theme"
backup_then_copy "$REPO_DIR/zsh/terminal.zsh"       "$CONFIG_DIR/terminal-setup.zsh"

SOURCE_LINE='source "$HOME/.config/terminal-setup.zsh"'
if ! grep -qF "$SOURCE_LINE" "$HOME/.zshrc" 2>/dev/null; then
  say "Adding source line to ~/.zshrc…"
  printf '\n# mac-terminal-setup\n%s\n' "$SOURCE_LINE" >> "$HOME/.zshrc"
fi

say "Done! Open WezTerm (Cmd+Space → WezTerm) and type: shrc"
