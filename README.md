# dotfiles

My configuration files for zsh, nushell, nvim, and starship.

## Quickstart

```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles

# Install stow if needed
brew install stow

# Create symlinks
cd ~/dotfiles
stow .

# Install VS Code extensions
cat ~/.config/vscode/extensions.txt | xargs -L 1 code --install-extension
```

## Dependencies

- [starship](https://starship.rs) - prompt
- [zoxide](https://github.com/ajeetdsouza/zoxide) - smart cd
- [eza](https://github.com/eza-community/eza) - better ls
- [bat](https://github.com/sharkdp/bat) - better cat
- [fzf](https://github.com/junegunn/fzf) - fuzzy finder
