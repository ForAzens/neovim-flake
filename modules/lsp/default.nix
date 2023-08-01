{ config, lib, pkgs, ... }:

{
  imports = [
    ./nix
      ./null_ls.nix
    ./lsp_keymap.nix
  ];
}
