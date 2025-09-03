#!/bin/bash

##########################################################################################
## Setup for all programs needed for my development environment and remote connection.  ##
## EndevourOS with i3 is used as base, but should mostly work with any Arch based dist. ##
##########################################################################################
sudo pacman -Syu --noconfirm

##
## NVIM and dependencies
##
# Install curl
sudo pacman -S curl --noconfirm

# Install FUSE (required for AppImages)
sudo pacman -S fuse2 --noconfirm
sudo pacman -S xclip --noconfirm


# Download and install Neovim AppImage
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/bin/nvim

# Install development tools and utilities
sudo pacman -S base-devel python python-pip ripgrep --noconfirm

# Install NVM (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

# Load NVM into the current shell session
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"

# Install latest LTS version of Node.js
nvm install --lts

# Install Neovim node bindings
npm install -g neovim

# Install Rust using rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y


##
## Remoting tools
##
sudo pacman -S --noconfirm mosh
sudo firewall-cmd --permanent --add-port=60000-61000/udp

yay -S --noconfirm xorgxrdp
yay -S --noconfirm xrdp
sudo firewall-cmd --permanent --add-port=3389/tcp

sudo firewall-cmd --reload

# Enable and start sshd
sudo systemctl enable sshd
sudo systemctl start sshd

# Enable and start xrdp
sudo systemctl enable xrdp
sudo systemctl start xrdp

# Enable and start xrdp-sesman
sudo systemctl enable xrdp-sesman
sudo systemctl start xrdp-sesman

# Set i3 as DE for xrdp
echo "exec i3" > ~/.xinitrc

##
## Desktop environment
##
sudo pacman -S --noconfirm gsimplecal
sudo pacman -S --noconfirm i3lock
sudo pacman -S --noconfirm picom
sudo pacman -S --noconfirm polybar
sudo pacman -S --noconfirm autotiling
sudo pacman -S redshift

##
## Tools
##
sudo pacman -S --noconfirm tmux
sudo pacman -S --noconfirm stow
# Stow command, run once in each config that should be linked. For example run from ~/repos/dotfiles/nvim
# stow -t ~/.config .config/
sudo pacman -S --noconfirm ghostty


# From AUR, not in official repository
yay -S --noconfirm docker-desktop

##
## BTRFS snapshots and restoring
##
sudo pacman -S --noconfirm timeshift
sudo pacman -S --noconfirm grub-btrfs
yay -S --noconfirm timeshift-autosnap
sudo pacman -S --noconfirm cronie 
sudo pacman -S --noconfirm inotify-tools
sudo systemctl enable --now cronie