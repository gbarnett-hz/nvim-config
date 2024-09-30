local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'H', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<space>a', vim.lsp.buf.code_action, bufopts)
end

local language_servers = {
	"yamlls",
	"jsonls",
	"terraformls",
	"rust_analyzer",
	"dockerls",
	"lua_ls",
	"clangd",
	"jdtls",
	"texlab",
	"pyright",
	"gopls",
	"ruff_lsp",
	"ts_ls",
	"zls"
}
return {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = language_servers,
		}
	},
	{ "williamboman/mason-lspconfig.nvim", opts = {} },
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			for _, lsp_svr in ipairs(language_servers) do
				require("lspconfig")[lsp_svr].setup {
					on_attach = on_attach,
					--flags = lsp_flags,
					capabilites = capabilities
				}
			end
		end
	},
}
