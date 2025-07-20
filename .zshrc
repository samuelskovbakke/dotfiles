# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="intheloop"

plugins=(
    git
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
    tmux
    you-should-use
    command-not-found
)

#ZSH_TMUX_AUTOSTART=true

source $ZSH/oh-my-zsh.sh


# Check archlinux plugin commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/archlinux

# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
#pokemon-colorscripts --no-title -s -r

# fastfetch. Will be disabled if above colorscript was chosen to install
fastfetch #-c $HOME/.config/fastfetch/config-compact.jsonc

# Set-up icons for files/folders in terminal
alias ls='eza -a --icons'
alias ll='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'

alias reload-zsh="source ~/.zshrc"
alias edit-zsh="nvim ~/.zshrc"



# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Make ctrl+arrow to jump words work
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word


source ~/.my-aliases.zsh

source /usr/share/doc/pkgfile/command-not-found.zsh

eval $(thefuck --alias)
eval $(thefuck --alias fk)
