{ pkgs, lib, config, ... }:

with lib;
with builtins;

let
  cfg = config.vim.ui.lualine;
  content = ''
  require("lualine").setup()
  '';
  luaFile = pkgs.writeText "lualine.lua" content;
in
{
  options.vim.ui.lualine = {
    enable = mkEnableOption "Enable lualine";
  };

  config = mkIf cfg.enable {
    vim.luaFiles = [ luaFile ];
    vim.plugins = with pkgs.vimPlugins; [
      lualine-nvim
      nvim-web-devicons
    ];
  };
}
