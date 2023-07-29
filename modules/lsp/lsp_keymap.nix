{ pkgs, lib, config, ... }:


let
  content = ''
    vim.keymap.set("n", "<leader>cf", "<cmd>lua print('Hello')<CR>", { desc = "Format current buffer" })
  '';
  luaFile = pkgs.writeText "lsp_keymap.lua" content;
in
{
  config = {
    vim.luaFiles = [ luaFile ];
  };
}
