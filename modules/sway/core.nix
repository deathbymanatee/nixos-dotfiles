{
  pkgs,
  inputs,
  ...
}:

{
  services.displayManager.lemurs.enable = true;
  environment.systemPackages = with pkgs; [
    sway
  ];
}
