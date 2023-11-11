{ pkgs, lib, config, ... }:

with lib;
with builtins;

let
  cfg = config.vim.editor.indentscope;
  content = ''
    require('mini.indentscope').setup() -- Animation
    require('ibl').setup() -- Blank line in all scopes
  '';
  luaFile = pkgs.writeText "indentscope.lua" content;
in
{
  options.vim.editor.indentscope = {
    enable = mkEnableOption "Enable indentscope (mini.indentscope)";
  };

  config = mkIf cfg.enable {
    vim.luaFiles = [ luaFile ];
    vim.plugins = with pkgs.vimPlugins; [
      indent-blankline
      mini-indentscope
    ];
  };
}
