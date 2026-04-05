{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.dev-tools;

in
{
  options.modules.dev-tools = {
    enable = mkEnableOption "dev-tools";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      rustup
      bruno
      tmux
      ncdu
    ];
  };
}
