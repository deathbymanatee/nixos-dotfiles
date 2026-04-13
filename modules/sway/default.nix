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
      foot
      wmenu
      wl-clipboard-rs
      way-displays
      wdisplays
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
      kdePackages.qt6ct
      gammastep
    ];
  };
}
