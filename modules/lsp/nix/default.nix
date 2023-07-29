{ pkgs, lib, config, ... }:

with lib;
with builtins;

let
  cfg = config.vim.lsp.nix;
  content = ''
    local nvim_lsp = require("lspconfig")
    nvim_lsp.nil_ls.setup({
      cmd = { "${pkgs.nil}/bin/nil" },
      });
  '';
  luaFile = pkgs.writeText "nix.lua" content;
in
{
  options.vim.lsp.nix = {
    enable = mkEnableOption "Enable Nix Lsp Server";
  };

  config = mkIf cfg.enable {
    vim.luaFiles = [ luaFile ];
    vim.plugins = with pkgs.vimPlugins; [ nvim-lspconfig ];
    vim.runtimeDeps = with pkgs; [ nil nixpkgs-fmt ];
  };
}
