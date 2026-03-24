{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "framework-13";

  users.users.ryan = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.ryan = {
      imports = [ ../../modules/default.nix ];
      config.modules = {
        nvim.enable = true;
      };
    };
  };
}
