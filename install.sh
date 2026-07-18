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
  fzf yazi zoxide eza bat btop git-delta lazygit

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
backup_then_copy "$REPO_DIR/delta/catppuccin.gitconfig" "$CONFIG_DIR/delta/catppuccin.gitconfig"
backup_then_copy "$REPO_DIR/lazygit/config.yml" \
  "$HOME/Library/Application Support/lazygit/config.yml"

# Pretty git diffs via delta. Only touches diff-related settings — never your
# name/email — and skips entirely if you already use delta.
if ! git config --global core.pager 2>/dev/null | grep -q delta; then
  say "Setting delta as git's diff pager…"
  git config --global core.pager delta
  git config --global interactive.diffFilter "delta --color-only"
  git config --global include.path "~/.config/delta/catppuccin.gitconfig"
  git config --global delta.features catppuccin-mocha
  git config --global delta.side-by-side true
  git config --global delta.line-numbers true
  git config --global delta.navigate true
  git config --global merge.conflictstyle zdiff3
fi

SOURCE_LINE='source "$HOME/.config/terminal-setup.zsh"'
if ! grep -qF "$SOURCE_LINE" "$HOME/.zshrc" 2>/dev/null; then
  say "Adding source line to ~/.zshrc…"
  printf '\n# mac-terminal-setup\n%s\n' "$SOURCE_LINE" >> "$HOME/.zshrc"
fi

say "Done! Open WezTerm (Cmd+Space → WezTerm) and type: shrc"
