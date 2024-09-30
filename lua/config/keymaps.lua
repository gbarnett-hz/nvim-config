-- basics
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>o", ":only<CR>")
vim.keymap.set("n", "<leader>d", ":bd<CR>")
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- telescope
vim.keymap.set("n", "<leader>b", function()
	require('telescope.builtin').buffers()
end)

vim.keymap.set("n", "<leader>f", function()
	require('telescope.builtin').find_files()
end)

vim.keymap.set("n", "<leader>fg", function()
	require('telescope.builtin').live_grep()
end)

-- lsp
vim.keymap.set("n", "ls", function()
	require('telescope.builtin').lsp_document_symbols()
end)

vim.keymap.set("n", "lw", function()
	require('telescope.builtin').lsp_dynamic_workspace_symbols()
end)

vim.keymap.set("n", "li", function()
	require('telescope.builtin').lsp_incoming_calls()
end)

vim.keymap.set("n", "lo", function()
	require('telescope.builtin').lsp_outgoing_calls()
end)

vim.keymap.set("n", "lr", function()
	require('telescope.builtin').lsp_references()
end)

vim.keymap.set("n", "gd", function()
	require('telescope.builtin').lsp_definitions()
end)

vim.keymap.set("n", "gi", function()
	require('telescope.builtin').lsp_implementations()
end)

-- a lua version of copilot is used which has nvim cmp integration, see copilot.lua
-- copilot
-- there's some conflict with nvim-cmp, so see cmp.lua for the other part
-- https://github.com/hrsh7th/nvim-cmp/blob/b16e5bcf1d8fd466c289eab2472d064bcd7bab5d/doc/cmp.txt#L830-L852
--vim.g.copilot_no_tab_map = true
--vim.keymap.set(
--	"i",
--	"<Plug>(vimrc:copilot-dummy-map)",
--	'copilot#Accept("")',
--	{ silent = true, expr = true, desc = "Copilot dummy accept" }
--)
