local fmt_tbl = function(extension)
	return {
		pattern = extension,
		group = 'AutoFormatting',
		callback = function()
			vim.lsp.buf.format({})
		end,
	}
end

local register_formatters = function(exts)
	for _, ext in ipairs(exts) do
		vim.api.nvim_create_autocmd('BufWritePre', fmt_tbl(ext))
	end
end

vim.api.nvim_create_augroup('AutoFormatting', {})
local formatting_exts = {
	'*.rs',
	'*.py',
	'*.go',
	--'*.java',
	'*.tf',
	'*.xml',
	'*.tex',
	'*.ts',
	'*.tsx',
	'*.json',
	"*.lua"
}
register_formatters(formatting_exts)
