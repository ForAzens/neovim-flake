let
  pkgs = import <nixpkgs> { };
  lib = pkgs.lib;
  cfg = {
    vim = {
      core.enable = true;
      which-key.enable = true;
      telescope.enable = true;
      lazygit.enable = true;
      lsp.null_ls.enable = false;
      lsp.nix.enable = true;
    };
  };

  myConfig = lib.evalModules {
    modules = [
      { imports = [ ./modules ]; }
      cfg
    ];
    specialArgs = { inherit pkgs; };
  };
in myConfig
   #builtins.concatStringsSep "\n" (builtins.map (file: "luafile ${file}") myConfig.vim.luaFiles)
