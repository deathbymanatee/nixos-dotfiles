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
    ./fastfetch
    ./dev-tools
    ./steam
    ./discord
    ./kwm # DOESN'T WORK DON'T USE THIS
    ./sway
  ];
}
