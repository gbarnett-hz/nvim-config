-- this is the first file loaded BEFORE lazy.nvim
-- categories:
--   wo is window scoped options
--   bo is buffer scoped options
--   o is general scope options

vim.g.mapleader = ";"
vim.g.maplocalleader = "\\"
vim.bo.ts = 2
vim.bo.sw = 2
vim.bo.et = true
vim.bo.syntax = "true"
vim.bo.ai = true
vim.bo.cindent = true
vim.wo.number = true
vim.o.hidden = true
vim.o.termguicolors = true
vim.o.background = "dark"
vim.o.cursorline = true
--set directory^=$HOME/swap
--highlight clear CursorLine
--highlight clear SignColumn " make the gutter same colour as lines
--set colorcolumn=100
