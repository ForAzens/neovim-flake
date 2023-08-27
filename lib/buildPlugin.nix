{ pkgs, plugins, inputs, lib ? pkgs.lib, ... }:

final: prev:

with lib;
with builtins;

let
  inherit (prev.vimUtils) buildVimPluginFrom2Nix;

  buildPlug = name:
    buildVimPluginFrom2Nix {
      name = name;
      src = builtins.getAttr name inputs;
    };
in
{
  vimPlugins =
    let
      xs = listToAttrs (map (n: nameValuePair n (buildPlug n)) plugins);
    in
    prev.vimPlugins // xs;

}
