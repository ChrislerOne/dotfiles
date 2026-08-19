# dotfiles

My configuration files for zsh, nushell, nvim, tmux, starship, and more.
The shell configs detect Homebrew on macOS and Linux; `install.sh` is macOS only.

## What's included

- **aerospace** — tiling window manager
- **borders** — window border highlights
- **ghostty** — terminal emulator
- **git** — global gitignore
- **k9s** — Kubernetes TUI
- **lazygit** — git TUI
- **mise** — pinned language runtimes (`mise.toml`)
- **nvim** — LazyVim-based Neovim config
- **nushell** — modern shell
- **starship** — cross-shell prompt
- **tmux** — terminal multiplexer (with TPM)
- **zed** — editor
- **zsh** — shell config with aliases and plugins

## Applications

Installed as casks by `brew bundle`. The ones marked † do nothing until opened
once manually, to grant their macOS permissions — `install.sh` offers to do this
at the end.

- **1password** — password manager
- **aerospace** † — i3-like tiling window manager
- **alfred** † — application launcher
- **alt-tab** — Windows-like alt-tab
- **docker-desktop** — build and run containers
- **font-jetbrains-mono** — terminal font
- **ghostty** — GPU-accelerated terminal emulator
- **linearmouse** † — pointer behaviour
- **shottr** — screenshot measurement and annotation
- **thaw** † — menu bar manager
- **visual-studio-code** — editor

## Quickstart

On a machine with nothing but `curl` and `bash`:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ChrislerOne/dotfiles/main/install.sh)"
```

`install.sh` aborts immediately if you don't have sudo, then, idempotently:

1. Installs the Xcode Command Line Tools, which provide `git`
2. Clones this repo to `~/dotfiles`, or fast-forwards it if already there
3. Installs Homebrew
4. Trusts the taps the `Brewfile` declares — Homebrew refuses to load formulae
   from untrusted third-party taps, so `brew bundle` fails without this
5. Runs `brew bundle` to install everything in the `Brewfile`
6. Deletes any `.DS_Store` files that would conflict with stow
7. Runs `stow --restow` to symlink the configs into `$HOME`
8. Installs the tmux plugins via TPM
9. Applies the macOS tweaks below
10. Offers to open the apps that need a first manual launch

Every step is guarded, so re-running is safe and converges: already-trusted taps
report `Already trusted`, `--restow` clears links for files that left the repo,
and the `defaults write` calls just rewrite the same values.

Set `DOTFILES_DIR` to check out somewhere other than `~/dotfiles`. Running
`./install.sh` from inside an existing clone uses that clone rather than making
a second one. Piping into `bash` works too — prompts are read from `/dev/tty`.

### Manual equivalent

```bash
cd ~/dotfiles
brew bundle
find ~/dotfiles -name .DS_Store -delete
stow .

# tmux plugins: press prefix + I inside tmux, or run
"$(brew --prefix)/opt/tpm/share/tpm/bin/install_plugins"
```

## macOS tweaks

Applied by `install.sh`:

```bash
defaults write com.apple.dock autohide -bool true            # hide the Dock
defaults write com.apple.dock autohide-delay -float 0        # no delay before it slides in
defaults write com.apple.dock autohide-time-modifier -int 0  # no slide animation
defaults write com.apple.dock tilesize -int 45               # icon size
defaults write com.apple.dock show-recents -bool false       # no recent apps section
defaults write com.apple.dock launchanim -bool false         # no bouncing launch animation
defaults write com.apple.dock mineffect -string suck         # minimise effect
killall Dock
```

## Dependencies

All declared in the `Brewfile`. The notable ones:

- [starship](https://starship.rs) - prompt
- [zoxide](https://github.com/ajeetdsouza/zoxide) - smart cd
- [eza](https://github.com/eza-community/eza) - better ls
- [bat](https://github.com/sharkdp/bat) - better cat
- [fzf](https://github.com/junegunn/fzf) - fuzzy finder
- [tmux](https://github.com/tmux/tmux) - terminal multiplexer
- [tpm](https://github.com/tmux-plugins/tpm) - tmux plugin manager
- [rustup](https://rustup.rs) - Rust toolchain; `.zshrc` and nushell add `~/.cargo/bin` to PATH when it is present
- [borders](https://github.com/FelixKratz/JankyBorders) - window border highlights (started via `brew services` by Aerospace)
