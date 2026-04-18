{
  pkgs,
  inputs,
  ...
}:

{
  services.displayManager.lemurs = {
    enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      swayfx
      libinput
    ];
    variables = {
      QT_QPA_PLATFORMTHEME = "gtk2";
    };
    extraInit = ''
      export XDG_DATA_DIRS=“$XDG_DATA_DIRS:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}”
    '';
  };

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  programs = {
    sway = {
      enable = true;
      package = pkgs.swayfx;
    };
    thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    xfconf.enable = true;
    dconf.enable = true;
  };

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

  security.pam.services.swaylock = { };

  security.pam.loginLimits = [
    {
      domain = "@users";
      item = "rtprio";
      type = "-";
      value = 1;
    }
  ];

  security.polkit.enable = true;
  security.soteria.enable = true;

  # sudoless power commands
  users.groups.power = { };
  security.polkit.extraConfig = ''
    polkit.addRule(function (action, subject) {
      if (
        subject.isInGroup("power") &&
        [
          "org.freedesktop.login1.reboot",
          "org.freedesktop.login1.reboot-multiple-sessions",
          "org.freedesktop.login1.power-off",
          "org.freedesktop.login1.power-off-multiple-sessions",
        ].indexOf(action.id) !== -1
      ) {
        return polkit.Result.YES;
      }
    });
  '';

  # sudoless brightness controls udev rules
  # THANKS FOR NOTHING NIXOS WIKI, IT DID NOT "JUST WORK"
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="leds", RUN+="${pkgs.coreutils}/bin/chgrp input /sys/class/leds/%k/brightness"
    ACTION=="add", SUBSYSTEM=="leds", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/leds/%k/brightness"
  '';
}
