" ===========================================================
"                   Vim Plugins Vim-Plug
"  Run: PlugInstall or PlugUpdate to get or update plugins
" ===========================================================
call plug#begin()
"  Plug 'tpope/vim-sensible'
  Plug 'vim-ruby/vim-ruby'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-rbenv'
  Plug 'tpope/vim-bundler'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-unimpaired'
  Plug 'thoughtbot/vim-rspec'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'kana/vim-textobj-user'
  Plug 'nelstrom/vim-textobj-rubyblock'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'christoomey/vim-tmux-runner'
  Plug 'airblade/vim-gitgutter'
  Plug 'rstacruz/vim-closer'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'scrooloose/syntastic'
  Plug 'ervandew/supertab'
  Plug 'Valloric/YouCompleteMe'
  Plug 'SirVer/ultisnips'
  " Plug 'honza/vim-snippets'
" Colorscheme Sections of the site
  " Plug 'nanotech/jellybeans.vim'
  Plug 'morhetz/gruvbox'
call plug#end()

" Enable Vim's built in matching plugin
runtime macros/matchit.vim

" Color scheme specifics configurations
let g:gruvbox_italic=1
set background=dark
colorscheme gruvbox
let g:airline_powerline_fonts = 1

" Reset the leader to comma
let mapleader = ","

set nocompatible      	" be iMproved, required
syntax on               " Enable syntax highlighting
filetype on             " Enable filetype detection
filetype indent on      " Enable filetype-specific indenting
filetype plugin on      " Enable filetype-specific plugins

" ===========================================================
"                     Standard Settings
" ===========================================================
" set number                         " Show lines numbers
set relativenumber                   " Show relative line numbers
set smartindent                      " Indent stuff
set autoindent                       " Indent stuff
set linespace=3                      " Prefer a slightly higher line height
set backspace=indent,eol,start       " Allow backspacing over everything in insert mode
set history=500                      " Keep 500 lines of command line history
set ruler                            " Show the cursor position all the time
set showcmd                          " Display incomplete commands
set hlsearch                         " Highlight searching
set incsearch                        " Incremental searching
set ignorecase                       " Case insensitive search
set smartcase                        " Case insensitive search
set backupdir=~/.vim/backup          " Backup files stored seperate folder
set tabstop=2                        " Softtabs with 2 spaces
set shiftwidth=2                     " Softtabs with 2 space
set shiftround
set expandtab                        " Expand tabs to spaces
set nojoinspaces                     " Use one space, not two, after punctuation.
set splitright                       " Open new split panes to right and bottom
set t_ZH=[3m                       " Reset italics encoding characters
set t_ZR=[23m                      " Reset italics encoding characters

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" ==========================================================
"                   Configuration stuff
" ==========================================================
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Syntastic recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Configurations for tmux navigator github.com/christoomey/vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1

" For Airline to display status properly
set laststatus=2

" Custom runner for rspec to hook into dispatcher
let g:rspec_command = "Dispatch rspec {spec}"

" Fakes out Gnome-Terminal to allow keybindings alt/meta to pass through
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

set timeout ttimeoutlen=50

" ==========================================================
"                       Ruby stuff
" ==========================================================

augroup myfiletypes
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml setlocal ai sw=2 sts=2 et
  autocmd FileType ruby,eruby,yaml setlocal path+=lib
  autocmd FileType ruby,eruby,yaml setlocal colorcolumn=80

  " Make ?s part of words
  autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?

augroup END

" ==========================================================
"                  Generic Leader Maps
" ==========================================================
" Edit another file in the same directory as the current file
map <Leader>e :e <C-R>=escape(expand("%:p:h"),' ') . '/'<CR>
map <Leader>s :split <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <Leader>v :vnew <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <Leader><Space> o<esc>

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" ==========================================================
"                   Normal Mode Maps
" ==========================================================
nmap j gj
nmap k gk

" Line Bubbling
nmap <A-k> [e
nmap <A-j> ]e

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-a> :TmuxNavigatePrevious<cr>

"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" ==========================================================
"                   Insert Mode Maps
" ==========================================================
" imap <c-space> <c-x><c-o>       "Omnifunc map to better charaters


" ==========================================================
"                   Visual Mode Maps
" ==========================================================
" Line Bubbling
vmap <A-k> [egv
vmap <A-j> ]egv

" Reset the bg color to terminal for transparency
highlight Normal ctermbg=none
