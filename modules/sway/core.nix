{
  pkgs,
  inputs,
  ...
}:

{
  services.displayManager.lemurs = {
    enable = true;
    settings = {

    };
  };
  environment.systemPackages = with pkgs; [
    swayfx
  ];
}
