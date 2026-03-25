{
  inputs,
  pkgs,
  config,
  ...
}:

{
  home.stateVersion = "25.11";
  imports = [
    ./nvim
    ./plasma
    ./librewolf
    ./libreoffice
    ./packages
    ./foot
  ];
}
