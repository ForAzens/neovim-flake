{ pkgs, lib, config, ... }:

with lib;
with builtins;

let
  cfg = config.vim.core;
  content = readFile ./core.lua;
  luaFile = pkgs.writeText "core.lua" content;
in
{
  options.vim.core = {
    enable = mkEnableOption "Enable core";
  };

  config = mkIf cfg.enable {
    vim.luaFiles = [ luaFile ];
    vim.plugins = with pkgs.vimPlugins; [ tokyonight-nvim ];
  };
}
