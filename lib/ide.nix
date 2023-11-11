{ pkgs, lib, neovimBuilder, ... }:

let
  deepMerge = lib.attrsets.recursiveUpdate;

  cfg = {
    vim = {
      ui = {
        filetree.enable = true;
        lualine.enable = true;
        harpoon.enable = true;
      };
      editor = {
        autopairs.enable = true;
        indentscope.enable = true;
        comment.enable = true;
        tmux-integration.enable = true;
        illuminate.enable = true;
        fold.enable = true;
      };
      core.enable = true;
      which-key.enable = true;
      telescope.enable = true;
      lazygit.enable = true;
      treesitter.enable = true;
      lsp = {
        tailwindcss.enable = true;
        copilot.enable = true;
        ui.enable = true;
        autocomplete.enable = true;
        null_ls.enable = true;
        nix.enable = true;
        ecmascript.enable = true;
        ruby.enable = true;
        elixir.enable = true;
      };
    };
  };
in
{
  full = neovimBuilder {
    config = cfg;
  };
}
