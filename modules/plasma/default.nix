{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.plasma;
  konsave = pkgs.callPackage ./konsave/package.nix { };

in
{
  options.modules.plasma = {
    enable = mkEnableOption "plasma";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      kdePackages.wayland
      kdePackages.plasma-nm
      wl-clipboard
      wayland-utils
      keepassxc
      papirus-icon-theme
      konsave
    ];
    home.file.".config/konsave" = {
      source = config.lib.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos/modules/plasma/konsave";
      recursive = true;
    };
  };
}
