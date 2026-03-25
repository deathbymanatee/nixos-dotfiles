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
    home.file.".config/nvim/" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos/modules/nvim/nvim";
      recursive = true;
    };
    home.packages = with pkgs; [
      luajit
      ripgrep
      clang
      nerd-fonts.jetbrains-mono
    ];
  };
}
