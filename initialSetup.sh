# Downlaod "Hack" nerd font https://github.com/ryanoasis/nerd-fonts, Install font on Host and set the font for the terminal.
# For Debian WSL window, (Right click top bar, properties, Font)

# Install Curl
sudo apt install curl -y 

# Install Neo vim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage 
chmod u+x nvim.appimage 
sudo mv nvim.appimage /usr/bin/nvim 

# Fuse does not come pre installed on all distributions
sudo apt install fuse -y 

# Prereq
sudo apt install build-essential -y 
sudo apt install python3 -y 
sudo apt-get install python3-pip -y 
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash 
nvm install --lts 
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y 

# LazyVim
git clone https://github.com/LazyVim/starter ~/.config/nvim 
rm -rf ~/.config/nvim/.git 

# Personal dotfiles 