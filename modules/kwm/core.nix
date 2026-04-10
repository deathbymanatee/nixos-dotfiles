{
  pkgs,
  lib,
  config,
  ...
}:

let
  kwm = pkgs.callPackage ./kwm.nix { };
in
{
  services.displayManager.lemurs.enable = true;
  services.displayManager.sessionPackages = [ kwm ];
  services.seatd.enable = true;
  environment.systemPackages = with pkgs; [
    kwm
    river
  ];

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  programs.xfconf.enable = true;
}
