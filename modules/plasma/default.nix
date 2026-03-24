{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.plasma;

in
{
  options.modules.plasma = {
    enable = mkEnableOption "plasma";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      kdePackages.wayland
      kdePackages.plasma-nm
      wl-clipboard
      wayland-utils
    ];
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.sddm.enable = true;
      displayManager.sddm.wayland.enable = true;
    };
  };
}
