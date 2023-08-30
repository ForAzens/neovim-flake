{ pkgs, lib, config, ... }:

with lib;
with builtins;

let
  cfg = config.vim.lsp.ecmascript;
  content = ''
    local nvim_lsp = require("lspconfig")
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    capabilities.documentFormattingProvider = false

    nvim_lsp.tsserver.setup({
      capabilities = capabilities,
      init_options = {
        tsserver = {
          path = "${pkgs.nodePackages.typescript}/bin/tsserver"
        }
      }
    });
  '';
  luaFile = pkgs.writeText "ecmascript.lua" content;
in
{
  options.vim.lsp.ecmascript = {
    enable = mkEnableOption "Enable TS Server";
  };

  config = mkIf cfg.enable {
    vim.luaFiles = [ luaFile ];
    vim.plugins = with pkgs.vimPlugins; [ nvim-lspconfig ];
    vim.runtimeDeps = with pkgs; [
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.eslint_d
      nodePackages.prettier_d_slim
    ];
  };
}
