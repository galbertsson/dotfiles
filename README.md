## Dotfiles

All config files are handled with GNU stow. The easiest way to link it is to cd into the folder for the program and run `stow -t ~/.config .config/`.
This will link the config folder in .config with the folder in the repo. 

The `setup.sh` script is setup to work on EndevourOS with i3, so minor modifications are most likely needed for other Arch based distros. Much of the i3 config is based on the one that comes default in a EndevourOS install.
