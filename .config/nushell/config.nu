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

# Aliases
alias cat = bat
alias k = kubectl

# Load zoxide (before aliases that use z)
source ~/.cache/zoxide/init.nu

alias cd = z
alias j = z

# Load starship prompt
use ~/.cache/starship/init.nu
