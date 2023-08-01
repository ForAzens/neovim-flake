{ pkgs, lib ? pkgs.lib, ... }:

{ config }:

let
  vimOptions = lib.evalModules {
    modules = [
      { imports = [ ../modules ]; }
      config
    ];
    specialArgs = { inherit pkgs; };
  };

  inherit (vimOptions.config) vim;

  customRC = builtins.concatStringsSep "\n" (builtins.map (file: "luafile ${file}") (vim.coreLuaFiles ++ vim.luaFiles));

  neovimRuntimeDependencies = pkgs.symlinkJoin {
    name = "neovimRuntimeDependencies";
    paths = lib.lists.unique vim.runtimeDeps;
    postBuild = ''
      for f in $out/lib/node_modules/.bin/*; do
         path="$(readlink --canonicalize-missing "$f")"
         ln -s "$path" "$out/bin/$(basename $f)"
      done
    '';
  };

  myNeovimUnwrapped = pkgs.wrapNeovim pkgs.neovim {
    configure = {
      inherit customRC;
      packages.all.start = lib.lists.unique vim.plugins;
    };
  };


in
pkgs.writeShellApplication {
  name = "nvim";
  runtimeInputs = [ neovimRuntimeDependencies ];
  text = ''
    ${myNeovimUnwrapped}/bin/nvim "$@"
  '';
}
