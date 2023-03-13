set nocompatible

" Turn on syntax highlighting.
syntax on
" Disable the default Vim startup message.
set shortmess+=I
" Show line numbers.
set number
set relativenumber

set laststatus=2 
set backspace=indent,eol,start
set hidden
set ignorecase
set smartcase
set incsearch

" Use space as leader key; recommended config for easymotion.
nnoremap <SPACE> <Nop>
let mapleader=" "

" CtrlP plugin settings.
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

" Indent handling based on file type.
filetype plugin indent on " enable file type detection
set autoindent

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell.
set noerrorbells visualbell t_vb=

" Enable mouse support.
set mouse+=a

" No arrow key movement in normal mode.
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>

