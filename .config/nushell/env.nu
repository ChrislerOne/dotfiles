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
let direnv_path = ([ $env.HOMEBREW_PREFIX "bin" "direnv" ] | path join)
"
export-env {
    \$env.config = (\$env.config | upsert hooks.env_change.PWD (\$env.config.hooks?.env_change?.PWD? | default [] | append [{
        code: {|before, after| 
            " + $direnv_path + " export json | from json | default {} | load-env
        }
    }]))
}
" | save -f ~/.cache/direnv/init.nu
