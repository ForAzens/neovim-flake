{ pkgs, lib, neovimBuilder, ... }:

let
  deepMerge = lib.attrsets.recursiveUpdate;

  cfg = {
    vim = {
      core.enable = true;
      which-key.enable = true;
      telescope.enable = true;
      lazygit.enable = true;
      lsp.null_ls.enable = true;
      lsp.nix.enable = true;
    };
  };
in
{
  full = neovimBuilder {
    config = cfg;
  };
}
