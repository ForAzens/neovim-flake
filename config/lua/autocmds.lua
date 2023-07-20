vim.api.nvim_create_augroup("AutoFormattingNix", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.nix",
	group = "AutoFormattingNix",
	callback = function()
		vim.lsp.buf.format()
	end,
})

vim.api.nvim_create_augroup("AutoFormattingLua", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.lua",
	group = "AutoFormattingLua",
	callback = function()
		vim.lsp.buf.format()
	end,
})
