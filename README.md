# NixOS Dotfiles

deathbymanatee's nixos dotfiles

## Requirements

1. Internet connection (duh)
2. NixOS installed and working with a user account set up
3. hardware-configuration.nix created 
4. SSH key enabled and set up

## Installation 

1. `git clone --recurse-submodules git@github.com:deathbymanatee/nixos-dotfiles.git ~/.config/nixos/`
2. CD into .config/nixos 
3. make new 
3. sudo nixos-build switch --flake .#your-hostname

## Post-install

I opted to abstain configuring individual programs using Nix and home-manager, as it created a read-only filesystem nightmare for someone who's configurations are [mostly] always being updated. I instead chose to use mkOutOfStoreSymlink and used relative paths to the various modules' config directories which seems to be working much better for my use case.

## Module setup

### Plasma 

To enable plasma and my plasma config, you will need to import `./modules/plasma/core.nix` into your `./hosts/hostname/user.nix` file to enable the necessary system level services. Then, once you have rebuilt your system, run `konsave -a base` to install the base KDE configuration.

## Writing home-level modules

1. `cd` into `./modules/`
2. Create a directory for your module: `mkdir modulename`
3. Create a `default.nix` file: `touch default.nix`
4. Copy the `template.nix` contents, paste it into `default.nix`, and replace instances of `PROGRAM` with your module's name
5. 
