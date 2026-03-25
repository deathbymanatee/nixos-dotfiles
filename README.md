# NixOS Dotfiles

deathbymanatee's nixos dotfiles

## Requirements

1. Internet connection (duh)
2. NixOS installed and working

## Installation 

1. `git clone --recurse-submodules git@github.com:deathbymanatee/nixos-dotfiles.git ~/.config/nixos/`
2. CD into .config/nixos 
3. sudo nixos-build switch --flake .#your-hostname

## Post-install

I opted to abstain configuring individual programs using Nix and home-manager, as it created a read-only filesystem nightmare for someone who's config is [mostly] always being updated. There are some inline scripts included that copy configuration files into needed directories after checking if said directories exist. This *should* only happen once. If it happens after the fact, make an issue of it.
