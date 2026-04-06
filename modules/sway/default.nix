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
      wl-clipboard-rs
      wmenu
    ];
  };
}
