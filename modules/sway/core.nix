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
  services.seatd.enable = true;
  environment.systemPackages = with pkgs; [
    swayfx
  ];

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  programs.xfconf.enable = true;
}
