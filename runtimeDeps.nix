{ pkgs }:
with pkgs; [
  lazygit
  nil
  nixpkgs-fmt
  stylua

  nodePackages.typescript
  nodePackages.typescript-language-server
]
