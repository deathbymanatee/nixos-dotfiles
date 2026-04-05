{
  pkgs,
  inputs,
  ...
}:

{
  services = {
    displayManager.lemurs.enable = true;
  };
}
