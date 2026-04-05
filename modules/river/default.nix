{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.river;

in
{
  options.modules.river = {
    enable = mkEnableOption "river";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      river
    ];
  };
}
