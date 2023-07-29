{ pkgs, ... }:

{
  neovimBuilder = import ./neovimBuilder.nix {
    inherit pkgs;
  };
}
