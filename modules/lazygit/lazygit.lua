local opt = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>:LazyGit<CR>", opt)
vim.api.nvim_set_keymap("n", "<leader>gc", ":lua require('telescope.builtin').git_commits()<CR>", opt)
vim.api.nvim_set_keymap("n", "<leader>gs", ":lua require('telescope.builtin').git_status()<CR>", opt)
vim.api.nvim_set_keymap("n", "<leader>gb", ":lua require('telescope.builtin').git_branches()<CR>", opt)
vim.api.nvim_set_keymap("n", "<leader>gb", ":lua require('telescope.builtin').git_branches()<CR>", opt)
