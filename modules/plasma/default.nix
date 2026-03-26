{
  pkgs,
  lib,
  config,
  inputs,
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
      kdePackages.flatpak-kcm
      wl-clipboard
      wayland-utils
      keepassxc
      papirus-icon-theme
      python313Packages.kde-material-you-colors
      themechanger
      konsave
    ];
    home.file.".config/konsave" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos/modules/plasma/konsave";
      recursive = true;
    };
    home.file."Pictures/Wallpapers/Forest For The Trees.jpg".source =
      ./wallpapers/Forest_For_The_Trees.jpg;
  };
}
