{pkgs, src}:

pkgs.vimUtils.buildVimPlugin {
  name = "nvim-harpoon";
  inherit src;
  dontBuild = true;
  }

