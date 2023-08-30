{ pkgs, ... }:


let
  content = ''
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)

		local local_map = function(mode, lhs, rhs, opts)
      local shared_opts = { buffer = ev.buf }
			vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", shared_opts, opts or {}))
		end

		local_map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
		local_map("n", "<leader>cl", "<cmd>LspInfo<cr>", { desc = "LspInfo" })
		local_map("n", "gd", function()
			require("telescope.builtin").lsp_definitions({ reuse_win = true })
		end, { desc = "Goto Definition" })
		local_map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
		local_map("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
		local_map("n", "gI", function()
			require("telescope.builtin").lsp_implementations({ reuse_win = true })
		end, { desc = "Goto Implementation" })
		local_map("n", "gy", function()
			require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
		end, { desc = "Goto T[y]pe Definition" })
		local_map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
		local_map("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })
		local_map("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
		local_map("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format Document" })
		local_map("v", "<leader>cf", vim.lsp.buf.format, { desc = "Format Range" })
		local_map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
		local_map("v", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
		local_map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
	end,
})
  '';
  luaFile = pkgs.writeText "lsp_keymap.lua" content;
in
{
  config = {
    vim.luaFiles = [ luaFile ];
  };
}
