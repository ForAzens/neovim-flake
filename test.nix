let
  pkgs = import <nixpkgs> { };
  systemModule = { imports = [ ./modules ]; };

  userModule = {
    vim = {
      core.enable = true;
      telescope.enable = true;
    };
  };

in
pkgs.lib.evalModules {
  modules = [ systemModule userModule ];
  specialArgs = { inherit pkgs; };
}
