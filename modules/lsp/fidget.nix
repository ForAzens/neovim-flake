{ pkgs, lib, config, ... }:

with lib;
with builtins;

let
  cfg = config.vim.lsp.ui;
  content = ''
  require("fidget").setup({})
  '';
  luaFile = pkgs.writeText "fidget.lua" content;
in
{
  options.vim.lsp.ui = {
    enable = mkEnableOption "Enable extended LSP UI";
  };

  config = mkIf cfg.enable {
    vim.luaFiles = [ luaFile ];
    vim.plugins = with pkgs.vimPlugins; [ 
    fidget-nvim
    ];
  };
}
