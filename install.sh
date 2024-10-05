# install nix
curl -L https://nixos.org/nix/install | sh

# source nix
. ~/.nix-profile/etc/profile.d/nix.sh

nix-env -iA \
  nixpkgs.zsh \
  nixpkgs.antibody \
  nixpkgs.git \
  nixpkgs.neovim \
  nixpkgs.tmux \
  nixpkgs.stow \
  nixpkgs.fzf \
  nixpkgs.zoxide \
  nixpkgs.ripgrep \
  nixpkgs.bat \
  nixpkgs.thefuck \
  nixpkgs.eza

# add zsh to valid login shells
command -v zsh | sudo tee -a /etc/shell

# use zsh as default shell
sudo chsh -s $(which zsh) $USER

# bundle zsh plugins
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh

# Get dotfiles in place using Stow
stow nvim
stow zsh
stow wezterm
stow tmux

