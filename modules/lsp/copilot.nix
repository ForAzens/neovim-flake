{ pkgs, lib, config, ... }:

with lib;
with builtins;

let
  cfg = config.vim.lsp.copilot;
  content = ''
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })

    require("copilot_cmp").setup()
  '';
  luaFile = pkgs.writeText "copilot.lua" content;
in
{
  options.vim.lsp.copilot = {
    enable = mkEnableOption "Enable Copilot";
  };

  config = mkIf cfg.enable {
    vim.luaFiles = [ luaFile ];
    vim.plugins = with pkgs.vimPlugins; [
      copilot-lua
      copilot-cmp
    ];
  };
}
