{ pkgs, lib, config, ... }:

with lib;
with builtins;

let
  cfg = config.vim.lsp.elixir;
  content = ''
    local nvim_lsp = require("lspconfig")
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    nvim_lsp.elixirls.setup({
      cmd = { "${pkgs.elixir-ls}/bin/elixir-ls" },
      capabilities = capabilities
    });
  '';
  luaFile = pkgs.writeText "elixir.lua" content;
in
{
  options.vim.lsp.elixir = {
    enable = mkEnableOption "Enable Elixir Lsp Server";
  };

  config = mkIf cfg.enable {
    vim.luaFiles = [ luaFile ];
    vim.plugins = with pkgs.vimPlugins; [ nvim-lspconfig ];
    vim.runtimeDeps = with pkgs; [ elixir-ls ];
  };
}

