{ pkgs, lib, config, ... }:

with lib;
with builtins;

let
  cfg = config.vim.lsp.ruby;
  content = ''
    local nvim_lsp = require("lspconfig")
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    nvim_lsp.solargraph.setup({
      capabilities = capabilities,

      });
  '';
  luaFile = pkgs.writeText "ruby_lsp.lua" content;
in
{
  options.vim.lsp.ruby = {
    enable = mkEnableOption "Enable Ruby LSP Server";
  };

  config = mkIf cfg.enable {
    vim.luaFiles = [ luaFile ];
    vim.plugins = with pkgs.vimPlugins; [ nvim-lspconfig ];
    vim.runtimeDeps = with pkgs; [ 
    rubyPackages_3_2.rubocop
    rubyPackages_3_2.solargraph
    ];
  };
}

