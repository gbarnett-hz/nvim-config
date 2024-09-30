return {
	--"github/copilot.vim"
	{
		"zbirenbaum/copilot.lua",
		-- https://github.com/zbirenbaum/copilot-cmp, recommnended there for the following opts
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
		}
	},
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
		depends = { "hrsh7th/nvim-cmp", "zbirenbaum/copilot.lua" },
	}
}
