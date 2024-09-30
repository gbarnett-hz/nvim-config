return {
	"nvim-telescope/telescope.nvim",
	tag = '0.1.8',
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		defaults = {
			path_display = { "truncate" },
		},
		pickers = {
			find_files = {
				theme = "ivy",
				previewer = false,
			},
			file_browser = {
				theme = "ivy",
			},
			live_grep = {
				theme = "ivy",
			},
			buffers = {
				theme = "ivy",
				previewer = false,
			},
			lsp_document_symbols = {
				theme = "ivy",
			},
			lsp_references = {
				theme = "ivy",
			},
			lsp_dynamic_workspace_symbols = {
				theme = "ivy",
			},
			lsp_definitions = {
				theme = "ivy",
			},
			lsp_implementations = {
				theme = "ivy",
			},
			lsp_incoming_calls = {
				theme = "ivy",
			},
			lsp_outgoing_calls = {
				theme = "ivy",
			},
			git_branch = {
				theme = "ivy",
			},
			git_status = {
				theme = "ivy",
			},
			git_commits = {
				theme = "ivy",
			},
		}
	}
}
