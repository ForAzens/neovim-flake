{
  description = "DC Neovim Flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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

    prettierd = {
      url = "github:fsouza/prettierd";
      flake = false;
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
    which-key = {
      url = "github:folke/which-key.nvim";
      flake = false;
    };

    nvim-cmp = {
      url = "github:hrsh7th/nvim-cmp";
      flake = false;
    };
    cmp-nvim-lsp = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };
    cmp-buffer = {
      url = "github:hrsh7th/cmp-buffer";
      flake = false;
    };
    cmp-path = {
      url = "github:hrsh7th/cmp-path";
      flake = false;
    };
    cmp-cmdline = {
      url = "github:hrsh7th/cmp-cmdline";
      flake = false;
    };
    luasnip = {
      url = "github:L3MON4D3/LuaSnip";
      flake = false;
    };
    cmp-luasnip = {
      url = "github:saadparwaiz1/cmp_luasnip";
      flake = false;
    };
    fidget-nvim = {
      url = "github:j-hui/fidget.nvim/legacy";
      flake = false;
    };
    lspkind = {
      url = "github:onsails/lspkind.nvim";
      flake = false;
    };


    nvim-neo-tree = {
      url = "github:nvim-neo-tree/neo-tree.nvim/v3.x";
      flake = false;
    };
    plenary-nvim = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };
    nvim-web-devicons = {
      url = "github:nvim-tree/nvim-web-devicons";
      flake = false;
    };
    nvim-nui = {
      url = "github:MunifTanjim/nui.nvim";
      flake = false;
    };

    lualine-nvim = {
      url = "github:nvim-lualine/lualine.nvim";
      flake = false;
    };

    mini-pairs = {
      url = "github:echasnovski/mini.pairs/stable";
      flake = false;
    };
    mini-indentscope = {
      url = "github:echasnovski/mini.indentscope/stable";
      flake = false;
    };
    indent-blankline = {
      url = "github:lukas-reineke/indent-blankline.nvim";
      flake = false;
    };

    mini-comment = {
      url = "github:echasnovski/mini.comment/stable";
      flake = false;
    };
    nvim-ts-context-commentstring = {
      url = "github:JoosepAlviste/nvim-ts-context-commentstring";
      flake = false;
    };

    smart-splits = {
      url = "github:mrjones2014/smart-splits.nvim";
      flake = false;
    };

    copilot-lua = {
      url = "github:zbirenbaum/copilot.lua";
      flake = false;
    };
    copilot-cmp = {
      url = "github:zbirenbaum/copilot-cmp";
      flake = false;
    };

    vim-illuminate = {
      url = "github:RRethy/vim-illuminate";
      flake = false;
    };

    nvim-ufo = {
      url = "github:kevinhwang91/nvim-ufo";
      flake = false;
    };

    promise-async = {
      url = "github:kevinhwang91/promise-async";
      flake = false;
    };

    nvim-surround = {
      url = "github:kylechui/nvim-surround";
      flake = false;
    };

  };
  outputs = inputs@{ self, nixpkgs, flake-utils, neovim, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          plugins = [
            "harpoon"
            "null_ls"
            "which-key"
            "nvim-cmp"
            "cmp-nvim-lsp"
            "cmp-buffer"
            "cmp-path"
            "cmp-cmdline"
            "luasnip"
            "cmp-luasnip"
            "fidget-nvim"
            "lspkind"

            "nvim-neo-tree"
            "plenary-nvim"
            "nvim-web-devicons"
            "nvim-nui"

            "lualine-nvim"
            "mini-pairs"
            "mini-indentscope"
            "indent-blankline"
            "mini-comment"
            "nvim-ts-context-commentstring"

            "smart-splits"

            "copilot-lua"
            "copilot-cmp"

            "vim-illuminate"
            "nvim-ufo"
            "promise-async"
            "nvim-surround"
          ];

          lib = import ./lib { inherit pkgs inputs plugins; };

          libOverlay = f: p: {
            lib = p.lib.extend
              (_: _: {
                inherit (lib) writeIf;
              });
          };

          pluginOverlay = lib.buildPluginOverlay;

          neovimOverlay = final: prev: {
            neovim = neovim.packages.${ system}.neovim;
          };

          overlayNilLsp = final: prev: {
            nil_ls = inputs.nil_ls.packages.${system}.nil;
            nixpkgs-fmt = inputs.nixpkgs-fmt.defaultPackage.${system};
          };

          overlayPrettierd = lib.buildPrettierd;

          pkgs = import nixpkgs {
            inherit system;
            overlays = [ libOverlay overlayPrettierd neovimOverlay overlayNilLsp pluginOverlay ];
          };

          inherit (lib) neovimBuilder;

          default-ide = pkgs.callPackage ./lib/ide.nix { inherit pkgs neovimBuilder; };
        in
        rec
        {
          packages = {
            default = default-ide.full;
            pkgs = pkgs;
          };
          apps.default = {
            type = "app";
            program = "${packages.default}/bin/nvim";
          };
        });
}
