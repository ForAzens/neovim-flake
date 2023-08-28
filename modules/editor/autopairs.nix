{ pkgs, lib, config, ... }:

with lib;
with builtins;

let
  cfg = config.vim.editor.autopairs;
  content = ''
    require('mini.pairs').setup()
  '';
  luaFile = pkgs.writeText "autopairs.lua" content;
in
{
  options.vim.editor.autopairs = {
    enable = mkEnableOption "Enable autopairs";
  };

  config = mkIf cfg.enable {
    vim.luaFiles = [ luaFile ];
    vim.plugins = with pkgs.vimPlugins; [
      mini-pairs
    ];
  };
}
