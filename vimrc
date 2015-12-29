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
call plug#end()


"Reset the leader to comma
let mapleader = "," 

set nocompatible  " be iMproved, required
filetype off      " required

