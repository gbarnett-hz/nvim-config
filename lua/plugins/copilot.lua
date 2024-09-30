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
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			debug = true, -- Enable debugging
			-- See Configuration section for rest
			window = {
				layout = 'float',
				width = 0.9, -- fractional width of parent, or absolute width in columns when > 1
				height = 0.9
			}
		},
		-- See Commands section for default commands if you want to lazy load on them
	}
}
