{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/plasma/core.nix
  ];

  networking.hostName = "framework-13";
  virtualisation.docker.enable = true;

  users.users.ryan = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  time.timeZone = "America/Chicago";

  programs.ssh.startAgent = true;

  # add external libraries for nix-ld ; not needed for nvim config
  programs.nix-ld.libraries = with pkgs; [
    (pkgs.runCommand "steamrun-lib" { } "mkdir $out; ln -s ${pkgs.steam-run.fhsenv}/usr/lib64 $out/lib")
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.ryan = {
      imports = [ ../../modules/default.nix ];
      config.modules = {
        nvim.enable = true;
        librewolf.enable = true;
        packages.enable = true;
        fastfetch.enable = true;
        dev-tools.enable = true;
        plasma.enable = true;
      };
    };
  };
}
