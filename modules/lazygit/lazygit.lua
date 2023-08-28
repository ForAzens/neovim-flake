local opt = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>:LazyGit<CR>", opt)
