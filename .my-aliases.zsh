# General stuff
alias q='exit'
alias c='clear'
alias cat='bat'
alias ls="eza --color=always --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias la="eza --long --all --color=always --git --icons=always --no-time --no-user"
alias l="eza --long --color=always --git --no-filesize --icons=always --no-time --no-user"
alias more="most"
alias pac="sudo pacman --noconfirm"
alias yay="yay --noconfirm"
alias give-me-upgrade="sudo pacman --noconfirm -Syyuu && yay"
alias grep="rg"
alias ff="fastfetch"

# Changing/making/removing directory
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus


alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -- -='cd -'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias md='mkdir -p'
alias rd=rmdir

function d () {
  if [[ -n $1 ]]; then
    dirs "$@"
  else
    dirs -v | head -n 10
  fi
}
compdef _dirs d

# List directory contents
# alias lsa='ls -lah'
# alias l='ls -lah'
# alias ll='ls -lh'
# alias la='ls -lAh'

alias nrs='sudo nixos-rebuild switch --flake ~/nix-config'
alias nixupg='nix flake update && nix flake update home-manager && sudo nixos-rebuild switch --flake ~/nix-config'
alias nixdelgens='sudo nix-collect-garbage -d'
