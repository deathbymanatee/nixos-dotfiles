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
  # services.displayManager.lemurs.enable = true;
  # services.displayManager.sessionPackages = [ kwm ];
  services.seatd.enable = true;
  environment.systemPackages = with pkgs; [
    kwm
    river
  ];
}
