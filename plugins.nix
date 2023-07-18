{ pkgs }:
with pkgs.vimPlugins; [
  telescope-nvim
  nvim-lspconfig
  which-key-nvim
  (nvim-treesitter.withPlugins
    (p: [ p.lua p.tsx p.sql p.nix p.css p.html p.yaml ]))
  lazygit-nvim

  # theme
  tokyonight-nvim
]
