{
  description = "DC Neovim Flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    neovim = {
      url = "github:neovim/neovim/stable?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    # LSP Servers
    nil_ls = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    nixpkgs-fmt = {
      url = "github:nix-community/nixpkgs-fmt";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nvim Plugin
    harpoon = {
      url = "github:ThePrimeagen/harpoon";
      flake = false;
    };
    null_ls = {
      url = "github:jose-elias-alvarez/null-ls.nvim";
      flake = false;
    };
    which-key = {
      url = "github:folke/which-key.nvim";
      flake = false;
    };
  };
  outputs = inputs@{ self, nixpkgs, flake-utils, neovim, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          lib = import ./lib { inherit pkgs; };

          libOverlay = f: p: {
            lib = p.lib.extend
              (_: _: {
                inherit (lib) writeIf;
              });
          };


          overlayFlakeInputs = final: prev: {
            neovim = neovim.packages.${ system}.neovim;

            vimPlugins = prev.vimPlugins // {
              nvim-harpoon = import ./plugins/harpoon.nix {
                src = inputs.harpoon;
                pkgs = prev;
              };
              null_ls = import ./plugins/null_ls.nix {
                src = inputs.null_ls;
                pkgs = prev;
              };
                which-key = import ./plugins/which-key.nix {
                src = inputs.which-key;
                pkgs = prev;
              };
            };
          };

          overlayNilLsp = final: prev: {
            nil_ls = inputs.nil_ls.packages.${system}.nil;
            nixpkgs-fmt = inputs.nixpkgs-fmt.defaultPackage.${system};
          };

          pkgs = import nixpkgs {
            inherit system;
            overlays = [ libOverlay overlayNilLsp overlayFlakeInputs ];
          };

          inherit (lib) neovimBuilder;

          default-ide = pkgs.callPackage ./lib/ide.nix { inherit pkgs neovimBuilder; };
        in
        rec
        {
          packages = {
            default = default-ide.full;
          };
          apps.default = {
            type = "app";
            program = "${packages.default}/bin/nvim";
          };
        });
}
