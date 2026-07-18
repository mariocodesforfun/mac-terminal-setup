# mac-terminal-setup 🍚

A fancy, glassy macOS terminal in one command: **WezTerm** (Catppuccin Mocha, blur, VS Code-style keybindings) + **Starship** powerline prompt + a stack of quality-of-life tools.

## What you get

| Piece | What it does |
|---|---|
| [WezTerm](https://wezterm.org) | GPU terminal — glassy blur, Catppuccin theme, native macOS title bar, VS Code text-editing shortcuts |
| [Starship](https://starship.rs) | Powerline prompt: Apple logo, directory, git branch/status, language versions, command duration |
| [fastfetch](https://github.com/fastfetch-cli/fastfetch) | Apple-logo system splash on every new tab (adapts to window width) |
| [yazi](https://github.com/sxyazi/yazi) | File manager with previews — type `y`, browse, quit into that folder |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | `z desktop` jumps to `~/Desktop` from anywhere |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy `Ctrl+R` history search, `Ctrl+T` file finder |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Ghost-text command suggestions — accept with `→` |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | Commands turn green (valid) / red (typo) as you type |
| [eza](https://github.com/eza-community/eza) | `ls`/`ll`/`lt` with icons, git status, tree view |
| [bat](https://github.com/sharkdp/bat) | `cat` with syntax highlighting |
| [btop](https://github.com/aristocratos/btop) | Beautiful system monitor, Catppuccin-themed |

## Install

```sh
git clone https://github.com/mariocodesforfun/mac-terminal-setup.git
cd mac-terminal-setup
./install.sh
```

Requires [Homebrew](https://brew.sh). Existing configs are backed up (`*.bak-<timestamp>`) before being replaced, and the script is safe to re-run.

Then open **WezTerm** and type:

```
shrc
```

That prints the built-in cheat sheet — every keyboard shortcut (splitting panes, switching tabs/windows, text editing) plus the tool commands above. It's how you teach yourself the setup.

## Highlights

- `Cmd + \` split pane right, `Cmd + Shift + \` split down, `Opt + Cmd + arrows` to move between panes
- `Opt/Cmd + arrows & backspace` behave exactly like the VS Code terminal
- `Cmd + K` clears, `Cmd + F` searches scrollback
- `y` → browse files with previews, `q` → your shell is now in that folder
- `z <fragment>` → teleport to any directory you've visited before

## Uninstall

Delete the `# mac-terminal-setup` block from `~/.zshrc`, restore any `*.bak-*` files you want back, and `brew uninstall` whatever you don't keep.
