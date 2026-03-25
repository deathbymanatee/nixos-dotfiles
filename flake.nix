{
  description = "nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ nixpkgs, home-manager, nix-ld, ... }:
    {
      nixosConfigurations = {
        virt-manager = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            home-manager.nixosModules.home-manager
            nix-ld.nixosModules.nix-ld
            ./modules/system/configuration.nix
            ./hosts/virt-manager/user.nix
          ];
        };
        framework-13 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            home-manager.nixosModules.home-manager
            nix-ld.nixosModules.nix-ld
            ./modules/system/configuration.nix
            ./hosts/framework-13/user.nix
          ];
        };
      };
    };
}
