{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.sway;

in
{
  options.modules.sway = {
    enable = mkEnableOption "sway";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      wmenu
      wl-clipboard-rs
      swayidle
      swaylock
      grim
      slurp
      wf-recorder
      dunst
      swaybg
      keepassxc
      vlc
      kdePackages.ark
      kdePackages.breeze
      kdePackages.breeze-gtk
      kdePackages.breeze-icons
      gammastep
      pamixer
      geeqie
      brightnessctl
      playerctl
      xsettingsd
      glib
      gsettings-desktop-schemas
      gtk3
      gtk4
      libsForQt5.qtstyleplugins
      nwg-look
      autotiling
      joplin-desktop
      waybar
      networkmanagerapplet
      blueman
      papirus-icon-theme
    ];
    home.file.".config/sway" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos/modules/sway/sway";
      recursive = true;
    };
    home.file.".config/waybar" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos/modules/sway/waybar";
      recursive = true;
    };
    home.file."Pictures/Wallpapers/Forest_For_The_Trees.jpg" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos/modules/sway/wallpapers/Forest_For_The_Trees.jpg";
      recursive = true;
    };
  };
}
