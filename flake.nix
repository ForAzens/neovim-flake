{
  description = "DC Neovim Flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    neovim = {
      url = "github:neovim/neovim/release-0.9";
      inputs.nixpkgs.follows = "nixpkgs";

    };
  };
  outputs = { self, nixpkgs, neovim }: {
    packages.x86_64-linux.default = neovim.packages.x86_64-linux.neovim;
    apps.x86_64-linux.default = {
      type = "app";
      program = "${neovim.packages.x86_64-linux.neovim}/bin/nvim";
    };
  };
}
