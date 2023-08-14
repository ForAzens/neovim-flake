{ pkgs, lib, config, ... }:

with lib;
with builtins;

let
  cfg = config.vim.treesitter;
  content = ''
    require'nvim-treesitter.configs'.setup {}
  '';
  luaFile = pkgs.writeText "treesitter.lua" content;

  parsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
    zig
    vim
    tsx
    sql
    nix
    lua
    css
    cpp
    yaml
    toml
    scss
    rust
    ruby
    odin
    json
    html
    bash
  ] ++ cfg.parsers;
in
{
  options.vim.treesitter = {
    enable = mkEnableOption "Enable treesitter";
    parsers = mkOption {
      description = "Parsers to install in treesitter";
      type = with types; listOf package;
      default = [ ];
    };
  };

  config = mkIf cfg.enable {
    vim.luaFiles = [ luaFile ];
    vim.plugins = with pkgs.vimPlugins; [ nvim-treesitter ] ++ parsers;
  };
}

