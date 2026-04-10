{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.kwm;
in
{
  options.modules.kwm = {
    enable = mkEnableOption "kwm";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      foot
      wmenu
      wl-clipboard-rs
      way-displays
      swayidle
      waylock
      grim
      slurp
      wf-recorder
      dunst
      swaybg
      keepassxc
      vlc
      kdePackages.ark
      kdePackages.qt6ct
    ];
  };
}
