{ pkgs, lib, config, ... }:

with lib;
with builtins;

let
  cfg = config.vim.telescope;
  content = readFile ./telescope.lua;
  luaFile = pkgs.writeText "telescope.lua" content;
in
{
  options.vim.telescope = {
    enable = mkEnableOption "Enable telescope";
  };

  config = mkIf cfg.enable {
    vim.luaFiles = [ luaFile ];
    vim.plugins = with pkgs.vimPlugins; [ telescope-nvim ];
  };
}
