{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/plasma/core.nix
    ../../modules/audio/core.nix
    ../../modules/virtualization/core.nix
    ../../modules/flatpak/core.nix
    ../../modules/steam/core.nix
  ];

  networking.hostName = "home-desktop";

  users.users.ryan = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "libvirtd"
    ];
  };

  hardware.bluetooth.enable = true;

  time.timeZone = "America/Chicago";

  programs.ssh.startAgent = true;
  programs.xwayland.enable = true;
  programs.gpu-screen-recorder.enable = true;

  # add external libraries for nix-ld ; not needed for nvim config
  programs.nix-ld.libraries = [
    (pkgs.runCommand "steamrun-lib" { } "mkdir $out; ln -s ${pkgs.steam-run.fhsenv}/usr/lib64 $out/lib")
  ];

  environment.systemPackages = with pkgs; [
    # amd specific resource btop which is why it's here and not in system/configuration.nix module
    btop-rocm
    gpu-screen-recorder-gtk
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
        plasma.enable = true;
        foot.enable = true;
        steam.enable = true;
      };
    };
  };
}
