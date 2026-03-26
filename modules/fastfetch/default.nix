{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.fastfetch;

in
{
  options.modules.fastfetch = {
    enable = mkEnableOption "fastfetch";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      fastfetch
    ];
  };
}
