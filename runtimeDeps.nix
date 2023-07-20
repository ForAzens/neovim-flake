{ pkgs }:
with pkgs; [
  lazygit
  nil
  nixpkgs-fmt

  nodePackages.typescript
  nodePackages.typescript-language-server
]
