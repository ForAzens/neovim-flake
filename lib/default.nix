{ pkgs, ... }:

{
  writeIf = cond: msg: if cond then msg else "";
  neovimBuilder = import ./neovimBuilder.nix {
    inherit pkgs;
  };
}
