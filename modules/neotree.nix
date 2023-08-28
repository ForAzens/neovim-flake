{ pkgs, lib, config, ... }:

with lib;
with builtins;

let
  cfg = config.vim.ui.filetree;
  content = ''
    require("neo-tree").setup({
      close_if_last_window = true,
      enable_git_status = true,
      enable_diagnostics = true,
      window = {
        width = 35
      },
      filesystem = {
        follow_current_file = {
          enabled = true, 
          leave_dirs_open = false,
        },
        use_libuv_file_watcher = true,
      },
      

    })
    
    vim.keymap.set("n", "<leader>e", 
      function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
      end, { desc = "Toggle filetree" })
  '';
  luaFile = pkgs.writeText "neotree.lua" content;
in
{
  options.vim.ui.filetree = {
    enable = mkEnableOption "Enable file tree (Using neo-tree)";
  };

  config = mkIf cfg.enable {
    vim.luaFiles = [ luaFile ];
    vim.plugins = with pkgs.vimPlugins; [ 
    nvim-neo-tree
    plenary-nvim
    nvim-web-devicons
    nvim-nui
    ];
  };
}

