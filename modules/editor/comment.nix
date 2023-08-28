{ pkgs, lib, config, ... }:

with lib;
with builtins;

let
  cfg = config.vim.editor.comment;
  content = ''
    require('mini.comment').setup({
      options = {
        custom_commentstring = function() 
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      }
    })
  '';
  luaFile = pkgs.writeText "comment.lua" content;
in
{
  options.vim.editor.comment = {
    enable = mkEnableOption "Enable mini.comment";
  };

  config = mkIf cfg.enable {
    vim.luaFiles = [ luaFile ];
    vim.plugins = with pkgs.vimPlugins; [
      mini-comment
      nvim-ts-context-commentstring
    ];
  };
}
