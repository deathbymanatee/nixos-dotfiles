{ inputs, pkgs, config, home-manager, ... }:

{
  home.stateVersion = "25.11";
  imports = [
    ./nvim
  ];
}
