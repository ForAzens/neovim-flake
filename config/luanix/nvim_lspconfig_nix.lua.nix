# vim: ft=lua
{pkgs}:

''
local nvim_lsp = require("lspconfig")
nvim_lsp.nil_ls.setup({
  cmd = { "${pkgs.nil}/bin/nil" },
  });

''

