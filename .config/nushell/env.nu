# Nushell Environment Config

# Homebrew
const BREW_LOCATIONS = ["/opt/homebrew" "/usr/local" "/home/linuxbrew/.linuxbrew"]
let brew_prefix = ($BREW_LOCATIONS | where {|p| $p | path join "bin" "brew" | path exists} | first)
$env.HOMEBREW_PREFIX = $brew_prefix
$env.HOMEBREW_CELLAR = ($brew_prefix | path join "Cellar")
$env.HOMEBREW_REPOSITORY = $brew_prefix

# PATH
$env.PATH = ($env.PATH | split row (char esep) | prepend [
    ($brew_prefix | path join "bin")
    ($brew_prefix | path join "sbin")
    $'($env.HOME)/.local/bin'
])

# Generate zoxide init
mkdir ~/.cache/zoxide
zoxide init nushell | save -f ~/.cache/zoxide/init.nu

# Generate starship init
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

# Generate mise init
mkdir ~/.cache/mise
mise activate nu | save -f ~/.cache/mise/init.nu

# direnv 
mkdir ~/.cache/direnv
let direnv_path = ([ $env.HOMEBREW_PREFIX "bin" "direnv" ] | path join)
"
export-env {
    \$env.config = (\$env.config | upsert hooks.env_change.PWD (\$env.config.hooks?.env_change?.PWD? | default [] | append [{
        code: {|before, after| 
            ^" + $direnv_path + " export json | from json | default {} | load-env
        }
    }]))
}
" | save -f ~/.cache/direnv/init.nu

