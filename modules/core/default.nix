{ pkgs, lib, config, ... }:

with lib;
with builtins;

let
  cfg = config.vim.core;
  content = readFile ./core.lua + "\n" + readFile ./keymaps.lua + "\n" + readFile ./autocmds.lua;
  luaFile = pkgs.writeText "core.lua" content;
in
{
  options.vim.core = {
    enable = mkEnableOption "Enable core";
  };

  config = mkIf cfg.enable {
    vim.coreLuaFiles = [ luaFile ];
    vim.plugins = with pkgs.vimPlugins; [ tokyonight-nvim dracula-nvim ];
  };
}
