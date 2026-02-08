# Nushell Config

$env.config = {
    show_banner: false

    history: {
        max_size: 100_000
        sync_on_enter: true
        file_format: "sqlite"
    }

    completions: {
        case_sensitive: false
        quick: true
        partial: true
        algorithm: "fuzzy"
    }

    cursor_shape: {
        emacs: line
        vi_insert: line
        vi_normal: block
    }

    edit_mode: emacs
    highlight_resolved_externals: true

    color_config: {
        shape_external: red
        shape_external_resolved: green
    }
}

# Load zoxide (before aliases that use z)
source ~/.cache/zoxide/init.nu

# Load direnv
source ~/.cache/direnv/init.nu

# Load mise
source ~/.cache/mise/init.nu

# Aliases
alias k = kubectl
alias gst = git status
alias gl = git pull
alias gp = git push

# Load starship prompt
use ~/.cache/starship/init.nu
