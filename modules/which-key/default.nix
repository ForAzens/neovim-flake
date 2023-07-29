{ pkgs, lib, config, ... }:

with lib;
with builtins;

let
  cfg = config.vim.which-key;
  content = ''
    local wk = require("which-key")

    local mappings = {
      mode = { "n", "v" },
      ["g"] = { name = "+goto" },
      ["gz"] = { name = "+surround" },
      ["]"] = { name = "+next" },
      ["["] = { name = "+prev" },
      ["<leader><tab>"] = { name = "+tabs" },
      ["<leader>b"] = { name = "+buffer" },
      ["<leader>c"] = { name = "+code" },
      ["<leader>f"] = { name = "+file/find" },
      ["<leader>g"] = { name = "+git" },
      ["<leader>gh"] = { name = "+hunks" },
      ["<leader>q"] = { name = "+quit/session" },
      ["<leader>s"] = { name = "+search" },
      ["<leader>u"] = { name = "+ui" },
      ["<leader>w"] = { name = "+windows" },
      ["<leader>x"] = { name = "+diagnostics/quickfix" },
    }

    wk.setup({})
    wk.register(mappings)
  '';
  luaFile = pkgs.writeText "which-key.lua" content;
in
{
  options.vim.which-key = {
    enable = mkEnableOption "Enable which-key";
  };

  config = mkIf cfg.enable {
    vim.luaFiles = [ luaFile ];
    vim.plugins = with pkgs.vimPlugins; [ which-key-nvim ];
  };
}

