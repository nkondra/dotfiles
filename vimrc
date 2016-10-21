" ===========================================================
"                   Vim Plugins Vim-Plug
"  Run: PlugInstall or PlugUpdate to get or update plugins
" ===========================================================
call plug#begin()
  Plug 'vim-ruby/vim-ruby'
  Plug 'thoughtbot/vim-rspec'
  Plug 'tomtom/tcomment_vim'
"  Plug 'tpope/vim-rbenv'
"  Plug 'tpope/vim-bundler'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
"  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-markdown', {'for': 'md'}
  Plug 'pangloss/vim-javascript'
  Plug 'tpope/vim-liquid', {'for': 'liquid'}
"  Plug 'ctrlpvim/ctrlp.vim'
"  Plug 'tacahiroy/ctrlp-funky'
  Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
  Plug 'junegunn/fzf.vim'
  Plug 'mileszs/ack.vim'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-indent'
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
  Plug 'Valloric/MatchTagAlways'
  Plug 'SirVer/ultisnips'
  Plug 'Raimondi/delimitMate'
"  Plug 'zenbro/mirror.vim'
  Plug 'cakebaker/scss-syntax.vim', {'for': ['scss','sass']}
  Plug 'hail2u/vim-css3-syntax', {'for': ['css','scss','sass']}
  Plug 'othree/html5.vim', {'for': ['html','erb']}
  Plug 'honza/vim-snippets'
  Plug 'mattn/emmet-vim'
  Plug 'nathanaelkane/vim-indent-guides'

  Plug 'scrooloose/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'Xuyuanp/nerdtree-git-plugin'

" Colorscheme Sections of the site
  Plug 'nanotech/jellybeans.vim'
  Plug 'vim-scripts/Gummybears'
  Plug 'morhetz/gruvbox'
  Plug 'marciomazza/vim-brogrammer-theme'
  Plug 'chriskempson/vim-tomorrow-theme'
  Plug 'scwood/vim-hybrid'
  Plug 'rakr/vim-one'
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'altercation/vim-colors-solarized'
call plug#end()

" Enable Vim's built in matching plugin
runtime macros/matchit.vim

" Color scheme specifics configurations
set background=dark
let g:gruvbox_italic = 1
let g:one_allow_italics = 1
let g:jellybeans_use_term_italics = 1
let g:gummybears_use_term_italics = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='papercolor'

colorscheme gummybears


" ===========================================================
"                     Standard Settings
" ===========================================================
"
" Reset the leader to spacebar
let mapleader = "\<Space>"

set nocompatible                     " be iMproved, required
syntax on                            " Enable syntax highlighting
filetype on                          " Enable filetype detection
filetype indent on                   " Enable filetype-specific indenting
filetype plugin on                   " Enable filetype-specific plugins

set noshowmode                       " Let airline show my mode
set wildmenu                         " Display options for auto complete
set relativenumber                   " Show relative line numbers
set number                           " Show lines numbers
set expandtab                        " Expand tabs to spaces
set shiftwidth=2                     " Softtabs with 2 space
set softtabstop=2                    " Softtabs with 2 spaces
set smarttab                         " Use shiftwidth to enter tabs
set smartindent                      " Indent stuff
set autoindent                       " Indent stuff
set list                             " Highlight white space
set linespace=3                      " Prefer a slightly higher line height
set backspace=indent,eol,start       " Allow backspacing over everything in insert mode
set history=500                      " Keep 500 lines of command line history
set ruler                            " Show the cursor position all the time
set showcmd                          " Display incomplete commands
set backupdir=~/.vim/backup//        " Backup files stored seperate folder
set directory=~/.vim/swap//          " Backup files stored seperate folder
set shiftround
" set nojoinspaces                     " Use one space, not two, after punctuation.
set splitright                       " Open new split panes to right and bottom
set t_ZH=[3m                       " Reset italics encoding characters
set t_ZR=[23m                      " Reset italics encoding characters
set encoding=utf-8                   " The encoding displayed.

set showmatch                        "automatically highlight matching braces/brackets/etc.
set matchtime=2                      "tens of a second to show matching parenthesesi

set hlsearch                         "highlight searches
set incsearch                        "incremental searching
set ignorecase                       "ignore case for searching
set smartcase                        "do case-sensitive if there's a capital letter

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p\|img'

" Display extra whitespace
set listchars=tab:▸-,trail:•,extends:❯,precedes:❮
set linebreak
let &showbreak='↪ '

" ==========================================================
"                   Configuration stuff
" ==========================================================

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --column\ --smart-case\ --follow
  set grepformat=%f:%l:%c:%m
  let g:ackprg = 'ag --vimgrep'

endif

" let g:ctrlp_clear_cache_on_exit=1
" let g:ctrlp_max_height=40
" let g:ctrlp_show_hidden=0
" let g:ctrlp_follow_symlinks=1
" let g:ctrlp_max_files=20000
" let g:ctrlp_extensions=['funky']
" let g:ctrlp_custom_ignore = {
"   \ 'dir': '\v[\/]\.(git|hg|svn|idea)$',
"   \ 'file': '\v\.DS_Store$'
"   \ }
"
" let g:ctrlp_funky_syntax_highlight = 1

" Setting custom tag match highlighting
let g:mta_filetypes = {
  \ 'html' : 1,
  \ 'xhtml' : 1,
  \ 'xml' : 1,
  \ 'erb' : 1,
  \}

" Syntastic recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✠'
let g:syntastic_warning_symbol = '∆'
let g:syntastic_style_warning_symbol = '≈'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_server_python_interpreter = '/usr/bin/python'
let g:ycm_complete_in_comments_and_strings=1
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsSnippetsDir='~/.vim/snippets'

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

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
  silent call system('mkdir -p $HOME/.vim/undo')
  set undofile                " Save undo's after file closes
  set undodir=~/.vim/undo//   " where to save undo histories
  set undolevels=1000         " How many undos
  set undoreload=10000        " number of lines to save for undo
endif

" Set spell checking on certain files types
autocmd FileType gitcommit,markdown setlocal spell


" ==========================================================
"                       Ruby stuff
" ==========================================================

augroup myfiletypes
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml setlocal ai sw=2 sts=2 et
  autocmd FileType ruby,eruby,yaml setlocal path+=lib

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

map <Leader>y "+y
map <Leader>p "+p

" ==========================================================
"                   Normal Mode Maps
" ==========================================================
nmap j gj
nmap k gk

" Line Bubbling
nmap <A-k> [e
nmap <A-j> ]e

" nnoremap <A-p> :CtrlPFunky<Cr>
" nnoremap <Leader>p :execute 'CtrlPFunky ' . expand('<cword>')<CR>

nmap <C-p> :Files<Cr>
nmap <a-p> :Ack!<Space>

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-a> :TmuxNavigatePrevious<cr>

"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" TPope/Fugative
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>

" NERDTree ------------------------------------------------------------------{{{

map <C-\> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowHidden=0
let g:NERDTreeWinSize=45
let g:NERDTreeAutoDeleteBuffer=1

function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#141e23')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#141e23')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#141e23')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#141e23')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#141e23')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#141e23')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#141e23')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#141e23')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#141e23')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#141e23')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#141e23')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#141e23')
call NERDTreeHighlightFile('ts', 'Blue', 'none', '#6699cc', '#141e23')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#141e23')
call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', '#141e23')
call NERDTreeHighlightFile('gitconfig', 'Gray', 'none', '#686868', '#141e23')
call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868', '#141e23')
call NERDTreeHighlightFile('bashrc', 'Gray', 'none', '#686868', '#141e23')
call NERDTreeHighlightFile('bashprofile', 'Gray', 'none', '#686868', '#141e23')

"}}}
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

set t_Co=256

" Reset the bg color to terminal for transparency
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight Comment cterm=italic gui=italic

