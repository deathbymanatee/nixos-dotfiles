{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.game-dev;

in
{
  options.modules.game-dev = {
    enable = mkEnableOption "game-dev";
  };
  config = mkIf cfg.enable {
    # game-dev packages
    home.packages = with pkgs; [
      # game-dev
      godot
      blender
      gimp
    ];
  };
}
