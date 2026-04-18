{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/sway/core.nix
    ../../modules/audio/core.nix
    ../../modules/virtualization/core.nix
  ];

  networking.hostName = "framework-13";

  users.users.ryan = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "libvirtd"
      "input"
      "seat"
      "audio"
      "video"
      "power"
      "storage"
    ];
  };

  hardware.bluetooth.enable = true;

  time.timeZone = "America/Chicago";

  programs.ssh.startAgent = true;

  # add external libraries for nix-ld ; not needed for nvim config
  programs.nix-ld.libraries = [
    (pkgs.runCommand "steamrun-lib" { } "mkdir $out; ln -s ${pkgs.steam-run.fhsenv}/usr/lib64 $out/lib")
  ];

  environment.systemPackages = with pkgs; [
    # amd specific resource btop which is why it's here and not in system/configuration.nix module
    btop-rocm
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
        game-dev.enable = true;
        audio-prod.enable = true;
        sway.enable = true;
      };
    };
  };
}
