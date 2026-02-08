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

# Aliases
# Shared aliases are handled via env.nu generation for performance
source ~/.cache/nushell/aliases.nu

# Load starship prompt
use ~/.cache/starship/init.nu
