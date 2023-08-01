{ pkgs, src }:

pkgs.vimUtils.buildVimPlugin {
  name = "which-key";
  inherit src;
  dontBuild = true;
}
