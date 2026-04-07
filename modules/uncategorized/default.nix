{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.uncategorized;

in
{
  options.modules.uncategorized = {
    enable = mkEnableOption "uncategorized";
  };
  config = mkIf cfg.enable {
    # uncategorized packages
    home.packages = with pkgs; [
      # gamedev
      godot
      blender

      # photoshop
      gimp

      # audio prod
      winePackages.yabridge
      yabridge
      yabridgectl
      reaper
      reaper-sws-extension
      calf
      easyeffects
      qjackctl
    ];

  };
}
