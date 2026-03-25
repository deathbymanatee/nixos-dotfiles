{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/plasma/core.nix
  ];

  networking.hostName = "virt-manager";

  users.users.ryan = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.ryan = {
      imports = [../../modules/default.nix];
      config.modules = {
        nvim.enable = true;
        librewolf.enable = true;
        plasma.enable = true;
        packages.enable = true;
      };
    };
  };
}
