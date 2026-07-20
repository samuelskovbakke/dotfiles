# General stuff
alias q='exit'
alias c='clear'
alias cat='bat'
alias ls="eza --color=always --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias la="eza --long --all --color=always --git --icons=always --no-time --no-user"
alias l="eza --long --color=always --git --no-filesize --icons=always --no-time --no-user"
alias more='most'
alias pac='sudo pacman --noconfirm'
alias yay='yay --noconfirm'
alias give-me-upgrade='sudo pacman --noconfirm -Syyuu && yay'
alias grep='rg'
alias ff='fastfetch'
alias gg='lazygit'

# Nix
abbr -a nrs 'nh switch --impure && nh switch --impure'
abbr -a nixupg 'nix flake update --flake ~/nix-config && nh switch --impure && nh switch --impure'
abbr -a nixdelgens 'nh clean all'

# Directory shortcuts
abbr -a md 'mkdir -p'
abbr -a rd 'rmdir'

# Directory history viewer
function d
    if set -q argv[1]
        dirh
    else
        dirh | head -n 10
    end
end
