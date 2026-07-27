if status is-interactive
    set -U fish_greeting ""
    fetch

    set -g fish_key_bindings fish_vi_key_bindings

    # Source aliases
    source ~/.config/fish/functions/my-aliases.fish

    # pay-respects (if it supports fish)
    pay-respects fish | source
end

zoxide init fish | source
alias cd='z'
