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

    menus: [
        {
            name: history_menu
            only_buffer_difference: true
            marker: ""
            type: { layout: list, page_size: 10 }
            style: { text: green, selected_text: green_reverse }
        }
    ]

    keybindings: [
        {
            name: history_prefix_up
            modifier: none
            keycode: up
            mode: [emacs vi_normal vi_insert]
            event: {
                until: [
                    { send: menuup }
                    { send: menu name: history_menu }
                ]
            }
        }
        {
            name: history_prefix_down
            modifier: none
            keycode: down
            mode: [emacs vi_normal vi_insert]
            event: {
                until: [
                    { send: menudown }
                    { send: menu name: history_menu }
                ]
            }
        }
    ]

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
