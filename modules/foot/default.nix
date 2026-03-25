{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.foot;

in
{
  options.modules.foot = {
    enable = mkEnableOption "foot";
  };
  config = mkIf cfg.enable {
    home.file.".config/foot/foot.ini" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos/modules/foot/foot.ini";
    };
    home.packages = with pkgs; [
      foot
    ];
  };
}
