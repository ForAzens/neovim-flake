{ pkgs, lib, config, ... }:


let
  content = ''
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format current buffer" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
  '';
  luaFile = pkgs.writeText "lsp_keymap.lua" content;
in
{
  config = {
    vim.luaFiles = [ luaFile ];
  };
}
