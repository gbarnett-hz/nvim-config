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
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'mileszs/ack.vim'
Plug 'kshenoy/vim-signature' " nice management of marks
Plug 'inside/vim-search-pulse'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'josa42/vim-lightline-coc'
Plug 'uarun/vim-protobuf'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'cespare/vim-toml'
Plug 'Yggdroot/indentLine'
Plug 'vim-test/vim-test'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()


" =============================================================================
" Key Mappings
" =============================================================================
let mapleader = ";"
nnoremap <Leader>f :FZF<CR>
nnoremap <Leader>e :e 
nnoremap <Leader>d :bd<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>o :only<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>a :Ack<Space>-w<Space><cword><CR>
nnoremap <Leader>m :make<CR>
nnoremap <Leader>t :TestFile<CR>
nnoremap <C-j> :wincmd j<CR> 
nnoremap <C-k> :wincmd k<CR> 

nmap <silent> gs :Git<CR>
nmap <silent> gl :Glog<CR>

nmap <silent> = :cnext<CR>
nmap <silent> - :cprevious<CR>

" coc
nmap rn <Plug>(coc-rename)
"nmap <silent>rn <Plug>(coc-rename)
nmap <silent> so :CocList outline<CR>
nmap <silent> sl :Vista!!<CR>
nmap <silent> ga :CocAction<CR>
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gh :CocFix<CR>
nnoremap <silent> H :call <SID>show_documentation()<CR>

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Completion 
highlight Pmenu ctermfg=15 ctermbg=0 guifg=#000000 guibg=#efefef
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt=noinsert,menuone,noselect

" Ag
if executable('ag')
  " w = match whole words
  let g:ackprg = "ag -w --ignore='target*' --ignore='project*' --ignore='*Test*.java' --ignore='*.sql' --ignore='*.htm*' --ignore='*.xml' --vimgrep"
endif

" Pandoc
let g:pandoc#modules#disabled = ["folding"]

function! LightlineFilename()
  return expand('%')
endfunction

let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename'
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileencoding' ],
      \              [ 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_status' ] ]
      \ }
      \ }
call lightline#coc#register()


let g:fzf_preview_window = ''

let g:coc_filetype_map = {'pandoc': 'markdown'}

au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}

" for scrolling the documentation pop-up
" https://github.com/neoclide/coc.nvim/issues/609#issuecomment-715461414
nnoremap <nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
nnoremap <nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

let g:indentLine_setConceal=0

lua << EOF
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
EOF

autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

colorscheme gruvbox
