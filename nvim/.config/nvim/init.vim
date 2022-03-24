call plug#begin()
" Editing enhancements
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
" required for table formatting
Plug 'godlygeek/tabular'

" note taking/markdown editing
Plug 'preservim/vim-markdown'

" GUI enhancements
Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'

" Programming languages
Plug 'rust-lang/rust.vim'
Plug 'udalov/kotlin-vim'

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
let g:AutoPairs={'(':')', '[':']', '{':'}', '"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}

" use one of the base16 themes
colorscheme base16-atelier-dune

" set the gui font (neovide)
set guifont=Noto\ Sans\ Mono:h9

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
