{ pkgs, inputs, plugins, ... }:

{
  writeIf = cond: msg: if cond then msg else "";
  neovimBuilder = import ./neovimBuilder.nix {
    inherit pkgs;
  };
  buildPluginOverlay = import ./buildPlugin.nix { inherit pkgs inputs plugins; };
  buildPrettierd = import ./buildPrettierd.nix { inherit pkgs inputs plugins; };
}
