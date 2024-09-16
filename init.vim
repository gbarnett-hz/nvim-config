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

let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

" =============================================================================
" Plugins
" =============================================================================
call plug#begin()
Plug 'inside/vim-search-pulse'
Plug 'morhetz/gruvbox'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lualine/lualine.nvim'

" this is a dep for a lot of lua-based nvim stuff -- it's lib for async
" programming
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'folke/trouble.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'vim-test/vim-test'
Plug 'stevearc/dressing.nvim'
Plug 'tpope/vim-fugitive'
Plug 'shortcuts/no-neck-pain.nvim', { 'tag': '*' }
Plug 'nvim-tree/nvim-tree.lua'
Plug 'hashivim/vim-terraform'
Plug 'arkav/lualine-lsp-progress'
Plug 'stevearc/overseer.nvim'
Plug 'b0o/SchemaStore.nvim'
Plug 'mfussenegger/nvim-dap'
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
nnoremap <Leader>r :OverseerRun<CR>
nnoremap <Leader>q :OverseerQuickAction<CR>
"nnoremap <Leader>q :q<CR>
nnoremap <C-j> :wincmd j<CR> 
nnoremap <C-k> :wincmd k<CR>
nnoremap <Leader>t :NvimTreeFocus<CR>

" Completion 
highlight Pmenu ctermfg=15 ctermbg=0 guifg=#000000 guibg=#efefef
highlight MatchParen ctermbg=blue guibg=lightblue

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"set completeopt=noinsert,menuone,noselect
set completeopt=menu,menuone,noselect

au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}

let g:indentLine_setConceal=0

nnoremap <leader>f <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb :Telescope file_browser path=%:p:h select_buffer=true<cr>
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap ls <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
nnoremap lw <cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>
nnoremap li <cmd>lua require('telescope.builtin').lsp_incoming_calls()<cr>
nnoremap lo <cmd>lua require('telescope.builtin').lsp_outgoing_calls()<cr>
nnoremap lr <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap gd <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
nnoremap gi <cmd>lua require('telescope.builtin').lsp_implementations()<cr>
nnoremap gs <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap gb <cmd>lua require('telescope.builtin').git_branch()<cr>
nnoremap gc <cmd>lua require('telescope.builtin').git_commits()<cr>

lua << EOF

require('overseer').setup()
require("trouble").setup {
  }

require("nvim-tree").setup()

require('telescope').setup({
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
})

require("no-neck-pain").setup({
 autocmds = {
        enableOnVimEnter = true,
 },
 width = 110,
 fallbackOnBufferDelete = true
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
  --vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'H', vim.lsp.buf.hover, bufopts)
  --vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>a', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- auto formatting with lsps that have formatting
local fmt_tbl = function(extension) 
return {
  pattern = extension,
  group = 'AutoFormatting',
  callback = function()
    vim.lsp.buf.format({ })
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
  '*.json'
}
register_formatters(formatting_exts)
--vim.api.nvim_create_autocmd('BufWritePre', fmt_tbl('*.ml'))
--vim.api.nvim_create_autocmd('BufWritePre', fmt_tbl('*.rs'))


local capabilities = require('cmp_nvim_lsp').default_capabilities()

local my_lsp_setup = function(lsp_svrs)
  for _, lsp_svr in ipairs(lsp_svrs) do
    if lsp_svr == "jsonls"
    then
      require('lspconfig')[lsp_svr].setup{
        on_attach = on_attach,
        flags = lsp_flags,
        capabilites = capabilities,
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        }
      }
    elseif lsp_svr == "yamlls"
    then
      require('lspconfig')[lsp_svr].setup{
        on_attach = on_attach,
        flags = lsp_flags,
        capabilites = capabilities,
        settings = {
          yaml = {
            schemaStore = {
              -- the following are to get SchemaStore working
              -- You must disable built-in schemaStore support if you want to use
              -- this plugin and its advanced options like `ignore`.
              enable = false,
              -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
              url = "",
            },
            schemas = require('schemastore').yaml.schemas(),
          },
        },
      }
    else
      require('lspconfig')[lsp_svr].setup{
        on_attach = on_attach,
        flags = lsp_flags,
        capabilites = capabilities
      }
    end
  end
end

my_lsp_setup(language_servers)
my_lsp_setup(externally_managed_language_servers)

require('lualine').setup {
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'diff', 'diagnostics', 'lsp_progress'},
    lualine_c = {'filename'},
    lualine_x = {'overseer','encoding'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  }
}

EOF


colorscheme gruvbox
