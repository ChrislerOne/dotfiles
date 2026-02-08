# Nushell Environment Config

# Homebrew
$env.HOMEBREW_PREFIX = '/opt/homebrew'
$env.HOMEBREW_CELLAR = '/opt/homebrew/Cellar'
$env.HOMEBREW_REPOSITORY = '/opt/homebrew'

# PATH
$env.PATH = ($env.PATH | split row (char esep) | prepend [
    '/opt/homebrew/bin'
    '/opt/homebrew/sbin'
    $'($env.HOME)/.local/bin'
])

# Generate zoxide init
mkdir ~/.cache/zoxide
zoxide init nushell | save -f ~/.cache/zoxide/init.nu

# Generate starship init
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

# direnv 
mkdir ~/.cache/direnv
direnv hook zsh | save -f ~/.cache/direnv/init.nu
