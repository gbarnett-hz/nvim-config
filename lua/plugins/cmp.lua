return {
	"hrsh7th/cmp-buffer", -- source
	"hrsh7th/cmp-nvim-lsp", -- source
	{
		"folke/lazydev.nvim", -- this is for lualsp setup
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "onsails/lspkind.nvim", opts = {} },
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
	{
		"hrsh7th/nvim-cmp",
		--depends = { "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp", "onsails/lspkind.nvim" },
		config = function()
			local cmp = require 'cmp'
			local lspkind = require("lspkind")
			cmp.setup({
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol",
						max_width = 50,
						symbol_map = { Copilot = "" }
					})
				},
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					['<Tab>'] = function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end,
					['<C-j>'] = cmp.mapping(function(fallback)
						vim.api.nvim_feedkeys(
							vim.fn['copilot#Accept'](vim.api.nvim_replace_termcodes('<Tab>',
								true,
								true, true)), 'n', true)
					end)
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp", group_index = 2 },
					{ name = "vsnip" }, -- For vsnip users.
					{ name = "buffer" },
					{ name = "copilot",  group_index = 2 },
					{
						name = "lazydev",
						group_index = 0, -- set group index to 0 to skip loading LuaLS completions
					}
				})
			})
		end
	}
}
