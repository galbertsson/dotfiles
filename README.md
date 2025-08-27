## Dotfiles

All config files are handled with GNU stow. The easiest way to link it is to cd into the folder for the program and run `stow -t ~/.config .config/`.
This will link the config folder in .config with the folder in the repo. 

The `setup.sh` script is setup to work on EndevourOS with i3, so minor modifications are most likely needed for other Arch based distros. Much of the i3 config is based on the one that comes default in a EndevourOS install.

### Post install manual steps
1. Add the following to `.bashrc` to load config files from `.bashrc.d`.
```
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
```

2. Use `Stow` to link dotfiles in repo, run once in each config that should be linked. For example run from `~/repos/dotfiles/nvim`

Because of the structure in this repo the following needs to be run:
`stow -t ~/.config .config`

3. Make sure automatic BTRFS backup is setup. Run the wizard in timeshift

Also setup grub-btrfs.
`systemctl edit --full grub-btrfsd`

And change 
`ExecStart=/usr/bin/grub-btrfsd /.snapshots --syslog`
to
`ExecStart=/usr/bin/grub-btrfsd --syslog --timeshift-auto`