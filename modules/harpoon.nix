{ pkgs, lib, config, ... }:

with lib;
with builtins;

let
  cfg = config.vim.ui.harpoon;
  content = ''
    vim.keymap.set("n", "<C-e>", 
      function()
          require("harpoon.ui").toggle_quick_menu()
      end, { desc = "Harpoon menu" })
    vim.keymap.set("n", "<leader>a", 
      function()
          require("harpoon.mark").add_file()
      end, { desc = "Harpoon menu" })
    vim.keymap.set("n", "<leader>h", 
      function()
          require("harpoon.ui").nav_file(1)
      end, { desc = "Go to file 1" })
    vim.keymap.set("n", "<leader>j", 
      function()
          require("harpoon.ui").nav_file(2)
      end, { desc = "Go to file 2" })
    vim.keymap.set("n", "<leader>k", 
      function()
          require("harpoon.ui").nav_file(3)
      end, { desc = "Go to file 3" })
    vim.keymap.set("n", "<leader>l", 
      function()
          require("harpoon.ui").nav_file(4)
      end, { desc = "Go to file 4" })
  '';
  luaFile = pkgs.writeText "harpoon.lua" content;
in
{
  options.vim.ui.harpoon = {
    enable = mkEnableOption "Enable Harpoon";
  };

  config = mkIf cfg.enable {
    vim.luaFiles = [ luaFile ];
    vim.plugins = with pkgs.vimPlugins; [
      harpoon
      plenary-nvim
    ];
  };
}
