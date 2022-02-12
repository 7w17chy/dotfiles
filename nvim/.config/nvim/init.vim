call plug#begin()
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'chriskempson/base16-vim'
call plug#end()

" relative line numbers, with the current line number being the effective one
set relativenumber
set number

" TODO: add `if filetype == clojure/lisp`
let g:AutoPairs={'(':')', '[':']', '{':'}', '"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}

" use one of the base16 themes
colorscheme base16-atelier-dune

" set the gui font (neovide)
set guifont=Noto\ Sans\ Mono:h9

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
