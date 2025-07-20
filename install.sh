# This script install packages and stores dotfiles on the system (Arch+Hyprland)

sudo pacman -Syyu

sudo pacman -S --needed base-devel

sudo pacman -S stow

stow .

sudo pacman -S zsh ghostty fastfetch git neovim neovide tmux fzf zoxide ripgrep bat thefuck eza zip unzip unrar xarchiver xdg-utils \
celluloid okular fd htop tldr wget lshw thunar thunar-archive-plugin \
cmake gcc rust python python-pip python-neovim jdk-openjdk npm luarocks go php \
font-manager ttf-firacode-nerd ttf-font-awesome noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra wqy-zenhei \
waybar hyprlock swaync pipewire pipewire-pulse swappy grim wl-clipboard slurp wofi network-manager-applet wtype wl-mirror \
firefox openrgb

sudo pacman -R dolphin

# Install yay and AUR packages
git clone https://aur.archlinux.org/yay.git ~
cd ~/yay
makepkg -si
cd ~/.dotfiles
rm -rf ~/yay

yay -S wlogout wttrbar waypipe 

# Get dotfiles in place using Stow
stow .

# Add zsh to valid login shells
command -v zsh | sudo tee -a /etc/shell

# Use zsh as default shell
sudo chsh -s $(which zsh) $USER

# Bundle zsh plugins
#curl -sfL git.io/antibody | sudo sh -s - -b /usr/local/bin
#antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh

# Setup tmux plugin
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

sudo npm install -g tree-sitter-cli neovim

# Install last missing plugin
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use

# Setup JaKooLit Arch-Hyprland
git clone --depth=1 https://github.com/JaKooLit/Arch-Hyprland.git ~/Arch-Hyprland
cd ~/Arch-Hyprland
chmod +x install.sh
./install.sh
