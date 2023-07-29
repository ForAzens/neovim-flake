{ pkgs, lib, neovimBuilder, ... }:

let
  deepMerge = lib.attrsets.recursiveUpdate;

  cfg = {
    vim = {
      core.enable = true;
      telescope.enable = true;
      lazygit.enable = true;
    };
  };
in
{
  full = neovimBuilder {
    config = cfg;
  };
}
