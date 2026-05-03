{
  pkgs,
  inputs,
  ...
}:

{
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.plasma-login-manager.enable = true;
    xserver.enable = true;
  };
  environment.systemPackages = with pkgs; [
    inputs.kwin-effects-glass.packages.${pkgs.stdenv.hostPlatform.system}.default
    papirus-icon-theme
  ];
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      font-awesome
      source-han-sans
      source-han-serif
    ];
    fontconfig.defaultFonts = {
      serif = [
        "Noto Serif"
        "Source Han Serif"
      ];
      sansSerif = [
        "Noto Sans"
        "Source Han Sans"
      ];
    };
  };
}
