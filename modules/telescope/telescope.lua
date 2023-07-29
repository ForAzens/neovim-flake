local opt = { noremap = true, silent = true }
local telescope = require("telescope")

telescope.setup({})
-- vim.api.nvim_set_keymap("n", "<leader><leader>", ":lua require('telescope.builtin').find_files()<CR>", opt)
vim.keymap.set("n", "<leader><leader>", ":lua require('telescope.builtin').find_files()<CR>", opt)
