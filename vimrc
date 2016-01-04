"===========================================================
"                   Vim Configuration
"===========================================================

" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
  execute '!mkdir -p ~/.vim/autoload'
  execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

"===========================================================
"                  Vim Plugins Vim-Plug
" Run: PlugInstall or PlugUpdate to get or update plugins
"===========================================================
call plug#begin()
  Plug 'tpope/vim-sensible'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-bundler'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'vim-ruby/vim-ruby'
  Plug 'ctrlpvim/ctrlp.vim'
call plug#end()


"Reset the leader to comma
let mapleader = "," 

set nocompatible	" be iMproved, required
filetype off      	" Required
syntax on		" Enable syntax highlighting

"===========================================================
"                    Standard Settings
"===========================================================
set number 			"Show lines numbers
"set relativenumber		"Show relative line numbers
set smartindent			"Indent stuff
set autoindent			"Indent stuff
set linespace=3			"Prefer a slightly higher line height
set backspace=indent,eol,start 	"Allow backspacing over everything in insert mode
set history=500			"Keep 500 lines of command line history
set ruler			"Show the cursor position all the time
set showcmd			"Display incomplete commands
set hlsearch			"Highlight searching
set ignorecase			"Case insensitive search
set smartcase			"Case insensitive search
set foldenable			"Enable code folding

" ==========================================================
"                       Ruby stuff
" ==========================================================

augroup myfiletypes
  " autocmd!			"Clear old autocmds in group
  
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml setlocal ai sw=2 sts=2 et
  autocmd FileType ruby,eruby,yaml setlocal path+=lib
  autocmd FileType ruby,eruby,yaml setlocal colorcolumn=80
  
  " Make ?s part of words
  autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?

augroup END


" ==========================================================
"                      Leader maps
" ==========================================================




