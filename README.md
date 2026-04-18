# NixOS Dotfiles

deathbymanatee's nixos dotfiles

## Requirements

1. Internet connection (duh)
2. NixOS installed and working with a user account set up
3. hardware-configuration.nix created 
4. SSH key enabled and set up (contributors only)

## Structure

See [tree.md](./tree.md) for the current overall file structure.

## Installation 

1. `git clone --recurse-submodules git@github.com:deathbymanatee/nixos-dotfiles.git ~/.config/nixos/`
2. CD into .config/nixos 
3. make new host directory in `hosts/`
4. copy your `hardware-configuration.nix` from `/etc/nixos/` into your new host folder
5. create a `user.nix` file inside of your new host folder and include configuration options you want - users, modules, environment packages, home-manager modules, etc.
    - copy previous configurations if you need a starting place
6. add an entry to the nixosConfigurations attribute set in `flake.nix` matching the network hostname you configured in `user.nix`. here, you need to add the following to the modules attribute: 
    - `home-manager.nixosModules.home-manager`
    - `./modules/system/configuration.nix`
    - `./hosts/<your-hostname>/user.nix`
7. once you configure to your liking, run `sudo nixos-build switch --flake .#your-hostname` for a first time installation

## Post-install

I opted to abstain configuring individual programs using Nix and home-manager, as it created a read-only filesystem nightmare for someone who's configurations are (mostly) always being updated. I also didn't feel like doing a full rebuild or home-switch when experimenting with one or two changes at a time. I instead chose to use mkOutOfStoreSymlink and used relative paths to the various modules' config directories which seems to be working much better for my use case.

## Module setup

Certain modules require a `core.nix` component for configuring system services. You will need to include them inside the `imports` list in your `user.nix` configuration file.

### Plasma 

To enable plasma and my plasma config, you will need to import `./modules/plasma/core.nix` into your `./hosts/hostname/user.nix` file to enable the necessary system level services. 

### Sway

Import `modules/sway/core.nix` into your top level import statement in `user.nix`. Then, enable the sway home module. 

In order for backlight controls, storage volume mounting, audio control, and the like to work, your user must be a member of the following groups: 

1. `input`
2. `seat`
3. `audio`
4. `video`
5. `power`
6. `storage`

## Writing home-level modules

1. `cd` into `./modules/`
2. Create a directory for your module: `mkdir modulename`
3. Create a `default.nix` file: `touch default.nix`
4. Copy the `template.nix` contents, paste it into `default.nix`, and replace instances of `PROGRAM` with your module's name
5. Add your `home.OPTION` configuration options inside of the `mkIf` block
6. Include your module in the `modules/default.nix` `imports` list
7. Enable your module inside of your `user.nix` file home configuration block
