{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.audio-prod;

in
{
  options.modules.audio-prod = {
    enable = mkEnableOption "audio-prod";
  };
  config = mkIf cfg.enable {
    # audio-prod packages
    home.packages = with pkgs; [
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
