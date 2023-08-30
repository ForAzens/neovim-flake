{ pkgs, lib, config, ... }:

with lib;
with builtins;

let
  cfg = config.vim.editor.illuminate;
  content = ''
    require("illuminate").configure({
        delay = 200,
        large_file_cutoff = 2000,
        large_file_overrides = {
          providers = { "lsp" },
        }})
  '';
  luaFile = pkgs.writeText "vim-illuminate.lua" content;
in
{
  options.vim.editor.illuminate = {
    enable = mkEnableOption "Enable vim-illuminate";
  };

  config = mkIf cfg.enable {
    vim.luaFiles = [ luaFile ];
    vim.plugins = with pkgs.vimPlugins; [
      vim-illuminate
    ];
  };
}
