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

# Shared Aliases
mkdir ~/.cache/nushell
let alias_file = "/Users/christopherlewerenz/dotfiles/.aliases"
if ($alias_file | path exists) {
    let content = (open $alias_file | lines | str trim)
    let filtered = ($content | where ($it | is-not-empty) | where (not ($it | str starts-with "#")))
    let aliased = ($filtered | each { |line|
        let parts = ($line | split row "=")
        let key = ($parts | get 0 | str trim)
        let val = ($parts | slice 1.. | str join "=" | str trim)
        $"alias ($key) = ($val)"
    })
    $aliased | str join (char nl) | save -f ~/.cache/nushell/aliases.nu
}
