{ pkgs, lib, config, ... }:

with lib;
with builtins;

let
  cfg = config.vim.editor.surround;
  content = ''
    require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
    })
  '';
  luaFile = pkgs.writeText "surround.lua" content;
in
{
  options.vim.editor.surround = {
    enable = mkEnableOption "Enable surround";
  };

  config = mkIf cfg.enable {
    vim.luaFiles = [ luaFile ];
    vim.plugins = with pkgs.vimPlugins; [
      nvim-surround
    ];
  };
}


