{
  pkgs,
  inputs,
  ...
}:

{
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.plasma-login-manager.enable = true;
  };
  environment.systemPackages = with pkgs; [
    inputs.kwin-effects-glass.packages.${pkgs.stdenv.hostPlatform.system}.default
    papirus-icon-theme
  ];
}
