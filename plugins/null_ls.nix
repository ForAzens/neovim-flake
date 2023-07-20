{ pkgs, src }:

pkgs.vimUtils.buildVimPlugin {
  name = "null_ls";
  inherit src;
  dontBuild = true;
}

