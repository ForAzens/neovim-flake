{ pkgs, lib, config, ... }:

with lib;
with builtins;

let
  cfg = config.vim.lsp;
  content = ''
    local null_ls = require("null-ls")

    null_ls.setup({
        sources = {
          ${writeIf cfg.nix.enable "null_ls.builtins.formatting.nixpkgs_fmt,"}
          ${writeIf cfg.ecmascript.enable ''
            null_ls.builtins.code_actions.eslint_d,
            null_ls.builtins.diagnostics.eslint_d,
            null_ls.builtins.formatting.eslint_d,
            null_ls.builtins.formatting.prettier,
          ''}
        },
    })
  '';
  luaFile = pkgs.writeText "null_ls.lua" content;
in
{
  options.vim.lsp.null_ls = {
    enable = mkEnableOption "Enable null_ls formatting";
  };

  config = mkIf cfg.null_ls.enable {
    vim.luaFiles = [ luaFile ];
    vim.plugins = with pkgs.vimPlugins; [ null_ls ];
  };
}
