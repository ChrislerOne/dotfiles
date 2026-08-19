#!/usr/bin/env bash
# Bootstrap a fresh macOS machine. Assumes only curl and bash:
#
#   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ChrislerOne/dotfiles/main/install.sh)"
#
# Safe to re-run. Override the checkout location with DOTFILES_DIR.
set -euo pipefail

REPO_URL="${DOTFILES_REPO_URL:-https://github.com/ChrislerOne/dotfiles.git}"
REPO="${DOTFILES_DIR:-$HOME/dotfiles}"

abort() { printf '\nerror: %s\n' "$*" >&2; exit 1; }
step()  { printf '\n==> %s\n' "$*"; }

# Prompts read from /dev/tty so they still work when piped from curl. The
# subshell probe is deliberate: /dev/tty passes -r even with no controlling
# terminal, and only an actual open reveals that.
have_tty() { ( : >/dev/tty ) 2>/dev/null; }
ask() {
    ANSWER=""
    if ! have_tty; then return 0; fi
    printf '%s' "$1" >/dev/tty
    IFS= read -r ANSWER </dev/tty || ANSWER=""
}

# When run as a file from inside an existing clone, use that clone.
if [ -f "${BASH_SOURCE[0]:-}" ]; then
    HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    if [ -d "$HERE/.git" ]; then REPO="$HERE"; fi
fi

[ "$(uname -s)" = Darwin ] || abort "this script targets macOS"

step "Checking sudo access"
sudo -v || abort "sudo access is required (the Homebrew installer needs it). Get admin rights, then re-run."

step "Installing Command Line Tools (provides git)"
if ! xcode-select -p >/dev/null 2>&1; then
    xcode-select --install || true
    ask "Complete the Command Line Tools installer, then press Enter: "
    xcode-select -p >/dev/null 2>&1 ||
        abort "Command Line Tools are still not installed; install them and re-run"
fi

step "Fetching the dotfiles repo into $REPO"
if [ -d "$REPO/.git" ]; then
    git -C "$REPO" pull --ff-only ||
        printf 'note: could not fast-forward %s, using it as-is\n' "$REPO"
else
    if [ -e "$REPO" ]; then
        abort "$REPO exists but is not a git clone; move it aside and re-run"
    fi
    git clone "$REPO_URL" "$REPO"
fi

step "Installing Homebrew"
command -v brew >/dev/null 2>&1 ||
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
for prefix in /opt/homebrew /usr/local; do
    if [ -x "$prefix/bin/brew" ]; then
        eval "$("$prefix/bin/brew" shellenv)"
        break
    fi
done
command -v brew >/dev/null 2>&1 || abort "Homebrew is not on PATH after installation"

step "Installing Brewfile packages"
brew bundle --file="$REPO/Brewfile"

step "Deleting .DS_Store files that would block stow"
find "$REPO" -name .DS_Store -delete

step "Linking dotfiles into $HOME"
stow --dir="$REPO" --target="$HOME" --ignore='^install\.sh$' .

step "Installing tmux plugins"
"$(brew --prefix)/opt/tpm/share/tpm/bin/install_plugins" ||
    printf 'skipped: launch tmux and press prefix + I instead\n'

step "Applying macOS tweaks"
defaults write com.apple.dock autohide -bool true            # hide the Dock
defaults write com.apple.dock autohide-delay -float 0        # no delay before it slides in
defaults write com.apple.dock autohide-time-modifier -int 0  # no slide animation
defaults write com.apple.dock tilesize -int 45               # icon size
defaults write com.apple.dock show-recents -bool false       # no recent apps section
defaults write com.apple.dock launchanim -bool false         # no bouncing launch animation
defaults write com.apple.dock mineffect -string suck         # minimise effect
killall Dock || true

step "Apps that need a first manual launch"
cat <<'MSG'
These grant their macOS permissions (Accessibility / Input Monitoring) only
after being opened once, so they do nothing until you launch them:

  AeroSpace    tiling window manager
  Thaw         menu bar manager
  Alfred       launcher
  LinearMouse  pointer settings
MSG
ask "Open them now? [y/N] "
case "$ANSWER" in
    [Yy]*)
        for pattern in AeroSpace Thaw 'Alfred*' LinearMouse; do
            for app in /Applications/$pattern.app; do
                if [ -d "$app" ]; then open "$app"; fi
            done
        done
        ;;
esac

printf '\nDone. Start a new shell.\n'
