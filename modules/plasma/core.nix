{
  pkgs,
  inputs,
  ...
}:

{
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
  };
  environment.systemPackages = with pkgs; [
    inputs.kwin-effects-glass.packages.${pkgs.system}.default
  ];
}
