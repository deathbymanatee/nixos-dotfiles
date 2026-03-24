{ pkgs, lib, config, ... }:

with lib; 

let 
  cfg = config.modules.nvim;
  nvimDotFilesPath = builtins.toString ./nvim;
in {
  options.modules.nvim = { enable = mkEnableOption "nvim"; };
  config = mkIf cfg.enable {
    home.activation.copyDotFiles = lib.mkAfter ''
      if [ ! -d "${config.home.homeDirectory}/.config/nvim" ]; then
        cp -r "${nvimDotFilesPath}" ${config.home.homeDirectory}/.config/nvim
      fi

      chown -R $USER ${config.home.homeDirectory}/.config/nvim
      chmod -R u+rw ${config.home.homeDirectory}/.config/nvim
    '';
    home.packages = with pkgs; [
      luajit
      ripgrep
      clang
    ];
  };
}
