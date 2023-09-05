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

  pluginsRC = builtins.concatStringsSep "\n" (builtins.map (file: "luafile ${file}") (vim.coreLuaFiles ++ vim.luaFiles));

  runtime' = lib.lists.unique vim.runtimeDeps;

  myNeovimUnwrapped = pkgs.wrapNeovim pkgs.neovim {
    configure = {
      customRC = ''
      ${pluginsRC}
      '';
      packages.all.start = lib.lists.unique vim.plugins;
    };
  };


in
pkgs.writeShellApplication {
  name = "nvim";
  runtimeInputs = [ pkgs.nodejs_18 ] ++ runtime';
  text = ''
    ${myNeovimUnwrapped}/bin/nvim "$@"
  '';
}
