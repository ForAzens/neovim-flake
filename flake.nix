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
  };
  outputs = inputs@{ self, nixpkgs, flake-utils, neovim, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          overlayFlakeInputs = final: prev: {
            neovim = neovim.packages.${system}.neovim;

            vimPlugins = prev.vimPlugins // {
              nvim-harpoon = import ./plugins/harpoon.nix {
                src = inputs.harpoon;
                pkgs = prev;
              };
              null_ls = import ./plugins/null_ls.nix {
                src = inputs.null_ls;
                pkgs = prev;
              };
            };
          };

          overlayNilLsp = final: prev: {
            nil_ls = inputs.nil_ls.packages.${system}.nil;
            nixpkgs-fmt = inputs.nixpkgs-fmt.defaultPackage.${system};
          };


          overlayMyNeovim = final: prev: {
            myNeovim = import ./packages/myNeovim.nix { pkgs = final; };
          };

          pkgs = import nixpkgs {
            inherit system;
            overlays = [ overlayNilLsp overlayFlakeInputs overlayMyNeovim ];
          };

        in
        {
          packages.default = pkgs.myNeovim;
          apps.default = {
            type = "app";
            program = "${pkgs.myNeovim}/bin/nvim";
          };
        });
}
