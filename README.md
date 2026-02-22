# dotfiles

My configuration files for zsh, nushell, nvim, tmux, starship, and more.

## What's included

- **aerospace** — tiling window manager
- **borders** — window border highlights
- **ghostty** — terminal emulator
- **git** — global gitignore
- **k9s** — Kubernetes TUI
- **nvim** — LazyVim-based Neovim config
- **nushell** — modern shell
- **starship** — cross-shell prompt
- **tmux** — terminal multiplexer (with TPM)
- **zsh** — shell config with aliases and plugins

## Quickstart

```bash
# Clone the repo
git clone https://github.com/ChrislerOne/dotfiles.git ~/dotfiles

# Install Homebrew dependencies
cd ~/dotfiles
brew bundle

# Remove any .DS_Store files that would conflict with stow
find ~/dotfiles -name .DS_Store -delete

# Create symlinks
stow .

# Install tmux plugins (after first launching tmux)
# Press prefix + I inside tmux, or run:
~/.config/tmux/plugins/tpm/bin/install_plugins
```

## Optional macOS tweaks

```bash
# Hide the Dock (autohide)
defaults write com.apple.dock autohide -bool true; killall Dock

# Remove dock autohide animation
defaults write com.apple.dock autohide-time-modifier -int 0; killall Dock

# Remove dock autohide delay
defaults write com.apple.dock autohide-delay -float 0; killall Dock
```

## Dependencies

- [starship](https://starship.rs) - prompt
- [zoxide](https://github.com/ajeetdsouza/zoxide) - smart cd
- [eza](https://github.com/eza-community/eza) - better ls
- [bat](https://github.com/sharkdp/bat) - better cat
- [fzf](https://github.com/junegunn/fzf) - fuzzy finder
- [tmux](https://github.com/tmux/tmux) - terminal multiplexer
- [tpm](https://github.com/tmux-plugins/tpm) - tmux plugin manager
- [borders](https://github.com/FelixKratz/JankyBorders) - window border highlights (started via `brew services` by Aerospace)
