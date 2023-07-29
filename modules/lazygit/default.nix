{ pkgs, lib, config, ... }:

with lib;
with builtins;

let
  cfg = config.vim.lazygit;
  content = readFile ./lazygit.lua;
  luaFile = pkgs.writeText "lazygit.lua" content;
in
{
  options.vim.lazygit = {
    enable = mkEnableOption "Enable LazyGit";
  };

  config = mkIf cfg.enable {
    vim.luaFiles = [ luaFile ];
    vim.plugins = with pkgs.vimPlugins; [ lazygit-nvim ];
    vim.runtimeDeps = with pkgs; [ lazygit ];
  };
}
