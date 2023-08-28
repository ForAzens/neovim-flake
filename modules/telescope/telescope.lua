local opt = { noremap = true, silent = true }
local telescope = require("telescope")

telescope.setup({})
vim.keymap.set("n", "<leader><leader>", ":lua require('telescope.builtin').find_files()<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>/", ":lua require('telescope.builtin').live_grep()<CR>", { desc = "Grep (root dir)" })
vim.keymap.set("n", "<leader>:", ":Telescope command_history<CR>", { desc = "Command history"} )
vim.keymap.set("n", "<leader>,", ":Telescope buffers show_all_buffers=true<CR>", { desc = "Switch Buffer" })

vim.keymap.set("n", "<leader>gc", ":lua require('telescope.builtin').git_commits()<CR>", { desc = "commits" })
vim.keymap.set("n", "<leader>gs", ":lua require('telescope.builtin').git_status()<CR>", { desc = "status" })
vim.keymap.set("n", "<leader>gb", ":lua require('telescope.builtin').git_branches()<CR>", {desc = "branches" })

vim.keymap.set("n", "<leader>fr", ":Telescope oldfiles<CR>", {desc = "Recent"})
vim.keymap.set("n", "<leader>ff", ":lua require('telescope.builtin').find_files()<CR>", { desc = "Find files" })
