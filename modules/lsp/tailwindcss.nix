{ pkgs, lib, config, ... }:

with lib;
with builtins;

let
  cfg = config.vim.lsp.tailwindcss;
  content = ''
    local nvim_lsp = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.documentFormattingProvider = false

    nvim_lsp.tailwindcss.setup({
      capabilities = capabilities,
      init_options = {
        userLanguages = {
             elixir = "phoenix-heex",
             heex = "phoenix-heex",
         },
        tailwindcss = {
          path = "${pkgs.nodePackages."@tailwindcss/language-server"}/bin/tailwindcss-language-server"
        },
      },
      settings = {
        includeLanguages = {
             ["html-eex"] = "html",
             ["phoenix-heex"] = "html",
             eelixir = "html",
             heex = "html",
         },
        tailwindCSS = {
          experimental = {
            classRegex = {
              { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
              { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
              [[class= "([^"]*)]],
              [[class: "([^"]*)]],
              '~H""".*class="([^"]*)".*"""',
            },
          },
          validate = true
        },
      },
    })
  '';
  luaFile = pkgs.writeText "tailwindcss.lua" content;
in
{
  options.vim.lsp.tailwindcss = {
    enable = mkEnableOption "Enable TailwindCSS LSP";
  };

  config = mkIf cfg.enable {
    vim.luaFiles = [ luaFile ];
    vim.plugins = with pkgs.vimPlugins; [ nvim-lspconfig ];
    vim.runtimeDeps = with pkgs; [
      nodePackages."@tailwindcss/language-server"
    ];
  };
}
