{ pkgs }:
with pkgs; [
  lazygit

  nodePackages.typescript
  nodePackages.typescript-language-server
]
