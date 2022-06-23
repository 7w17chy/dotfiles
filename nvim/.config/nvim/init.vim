call plug#begin()
" Editing enhancements
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
" required for table formatting
Plug 'godlygeek/tabular'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" note taking/markdown editing
Plug 'preservim/vim-markdown'

" GUI enhancements
Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'

" Programming languages
Plug 'rust-lang/rust.vim'
Plug 'udalov/kotlin-vim'
Plug 'Tetralux/odin.vim'

" Motion enhancements
Plug 'justinmk/vim-sneak'

" File system niceties
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()

"
" - https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
"

" vim-markdown: disable folding
let g:vim_markdown_folding_disabled = 1

" relative line numbers, with the current line number being the effective one
set relativenumber
set number

" TODO: add `if filetype == clojure/lisp`
let g:AutoPairs={'(':')', '[':']', '{':'}', '"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''", '<':'>',}

" use one of the base16 themes
colorscheme base16-atelier-dune

" set the gui font (neovide)
set guifont=Noto\ Sans\ Mono:h7

" Lightline (stolen from:
" https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.vim)
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileencoding', 'filetype' ] ],
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename'
      \ },
      \ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" fzf preview window position
let g:fzf_layout = { 'down': '~20%' }

" Use wide tabs
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" higlight yanked text, but exclude visual selections 
" (credit: https://jdhao.github.io/2020/05/22/highlight_yank_region_nvim/#google_vignette)
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=false}
augroup END

" teach rooter which files/dirs mark a project root dir
let g:rooter_patterns = ['.git', 'README.*', 'Makefile', '*.sln', 'build/env.sh']
" stop echoing root dir
let g:rooter_silent_chdir = 1

" leader mappings
let mapleader = "\<Space>"
nnoremap <Leader>o :Files<CR>
nnoremap <Leader>b :Buffers<CR>

" copy and paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

"############################ coc.nvim settings #############################
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
"############################################################################
