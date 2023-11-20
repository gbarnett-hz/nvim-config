set tabstop=2
set shiftwidth=2
set expandtab
syntax on
set autoindent
set cindent
let &t_Co=256
set termencoding=utf-8
set encoding=utf-8
set termguicolors
set hidden
set number
set termguicolors
set directory^=$HOME/swap
autocmd FileType make setlocal noexpandtab
filetype plugin indent on
set cursorline
highlight clear CursorLine
set background=dark
highlight clear SignColumn " make the gutter same colour as lines

set colorcolumn=100

" =============================================================================
" Plugins
" =============================================================================
call plug#begin()
Plug 'inside/vim-search-pulse'
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" this is a dep for a lot of lua-based nvim stuff -- it's lib for async
" programming
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'folke/trouble.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'folke/neodev.nvim' " lua api sig help
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'vim-test/vim-test'
Plug 'stevearc/dressing.nvim'
Plug 'tpope/vim-fugitive'
Plug 'mhartington/formatter.nvim'
call plug#end()


" =============================================================================
" Key Mappings
" =============================================================================
let mapleader = ";"
nnoremap <Leader>e :e 
nnoremap <Leader>c :e $HOME/.config/nvim/init.vim<CR>
nnoremap <Leader>d :bd<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>o :only<CR>
nnoremap <Leader>q :q<CR>
nnoremap <C-j> :wincmd j<CR> 
nnoremap <C-k> :wincmd k<CR>
nnoremap <Leader>t :TestFile<CR>

" Completion 
highlight Pmenu ctermfg=15 ctermbg=0 guifg=#000000 guibg=#efefef
highlight MatchParen ctermbg=blue guibg=lightblue

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"set completeopt=noinsert,menuone,noselect
set completeopt=menu,menuone,noselect

" Ag
if executable('ag')
  " w = match whole words
  let g:ackprg = "ag -w --ignore='target*' --ignore='project*' --ignore='*Test*.java' --ignore='*.sql' --ignore='*.htm*' --ignore='*.xml' --vimgrep"
endif

au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}

let g:indentLine_setConceal=0

nnoremap <leader>f <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap ls <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
nnoremap lr <cmd>lua require('telescope.builtin').lsp_references()<cr>

lua << EOF
require("trouble").setup {
  }

require('telescope').setup({
  pickers = {
    find_files = {
      theme = "dropdown",
      previewer = false,
    },
    live_grep = {
      theme = "dropdown",
    },
    buffers = {
      theme = "dropdown",
      previewer = false,
    },
    lsp_document_symbols = {
      theme = "dropdown",
    },
    lsp_references = {
      theme = "dropdown",
    },
    lsp_workspace_symbols = {
      theme = "dropdown",
    }
  }
})


require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "all",

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  ignore_install = { "phpdoc" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    disable = { },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- https://github.com/hrsh7th/nvim-cmp
-- Setup nvim-cmp.
local cmp = require'cmp'
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
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
      end
      }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
    }, {
    { name = 'buffer' },
    })
})

-- mason managed
local language_servers = { "yamlls", "jsonls", "pyright", "terraformls", "zls" }
-- managed by external provider
local externally_managed_language_servers = { } 
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed =  language_servers
})

-- https://github.com/neovim/nvim-lspconfig
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
-- key bindings for using the lsp features
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'H', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>a', vim.lsp.buf.code_action, bufopts)
end


local capabilities = require('cmp_nvim_lsp').default_capabilities()

local my_lsp_setup = function(lsp_svrs)
  for _, lsp_svr in ipairs(lsp_svrs) do
    require('lspconfig')[lsp_svr].setup{
      on_attach = on_attach,
      flags = lsp_flags,
      capabilites = capabilities
    }
  end
end


my_lsp_setup(language_servers)
my_lsp_setup(externally_managed_language_servers)

-- Utilities for creating configurations
local util = require "formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    markdown = {
      function()
        return {
          exe = "prettier",
          args = {
            "--prose-wrap always",
            "--print-width 100",
            util.escape_path(util.get_current_buffer_file_path())
          },
          stdin = true,
        }
      end
    },
    python = {
      require('formatter.filetypes.python').black,
      require('formatter.filetypes.python').isort,
    },
    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}

EOF

augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.md FormatWrite
  autocmd BufWritePost *.py FormatWrite
augroup END

colorscheme gruvbox
