# installs dependencies needed for bare neovim configuration
{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.modules.nvim;
in
{
  options.modules.nvim = {
    enable = mkEnableOption "nvim";
  };
  config = mkIf cfg.enable {
    home.activation.copyConfig = mkAfter ''
      if [! -d "${config.home.homeDirectory}/.config/nvim" ]; then
        cp -r "${nvimConfigPath}" ${config.home.homeDirectory}/.config/nvim

        chown -R $USER ${config.home.homedirectory}/.config/nvim
        chmod -R u+rw ${config.home.homeDirectory}/.config/nvim
      fi
    '';
    home.packages = with pkgs; [
      luajit
      ripgrep
      clang
    ];
  };
}
