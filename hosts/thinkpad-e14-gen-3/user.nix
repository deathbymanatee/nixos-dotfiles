{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
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
      "seat"
      "input"
    ];
  };

  time.timeZone = "America/Chicago";

  programs.ssh.startAgent = true;

  # add external libraries for nix-ld ; not needed for nvim config
  programs.nix-ld.libraries = [
    (pkgs.runCommand "steamrun-lib" { } "mkdir $out; ln -s ${pkgs.steam-run.fhsenv}/usr/lib64 $out/lib")
  ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

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
        packages.enable = true;
        fastfetch.enable = true;
      };
    };
  };
}
