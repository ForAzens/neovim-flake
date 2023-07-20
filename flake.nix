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

    # Nvim Plugin
    harpoon = {
      url = "github:ThePrimeagen/harpoon";
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
          };
      };

      overlayMyNeovim = final: prev: {
        myNeovim = import ./packages/myNeovim.nix { pkgs = prev; };
      };

      pkgs = import nixpkgs {
        inherit system;
        overlays = [ overlayFlakeInputs overlayMyNeovim ];
      };
    in {
      packages.default = pkgs.myNeovim;
      apps.default = {
        type = "app";
        program = "${pkgs.myNeovim}/bin/nvim";
      };
    });
}
