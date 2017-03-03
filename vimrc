" ===========================================================
"           Vim8 Configuration Nathan Kondra
" ===========================================================

" Generic Config Settings {{{

" Reset the leader to spacebar
let mapleader = "\<Space>"

set nocompatible                     " be iMproved, required
filetype on                          " Enable filetype detection
filetype indent on                   " Enable filetype-specific indenting
filetype plugin on                   " Enable filetype-specific plugins
syntax on                            " Enable syntax highlighting

set relativenumber                   " Show relative line numbers
set number                           " Show lines numbers
set list                             " Highlight white space
set linespace=3                      " Prefer a slightly higher line height
set showmatch                        " automatically highlight matching braces/brackets/etc.
set matchtime=2                      " tens of a second to show matching parenthesesi
set splitright                       " Open new split panes to right
set splitbelow                       " Open new split panes to bottom
set showcmd                          " Display incomplete commands
set noshowmode                       " Let airline show my mode
set ruler                            " Show the cursor position all the time
set cursorline                       " Highlight the line the cursor is on

" Default Tab and indenting rules
set shiftround                       " round indenting to increments of shiftwidth
set expandtab                        " Expand tabs to spaces
set shiftwidth=2                     " Softtabs with 2 space
set softtabstop=2                    " Softtabs with 2 spaces
set smarttab                         " Use shiftwidth to enter tabs
set smartindent                      " Indent stuff
set autoindent                       " Indent stuff

" Vim backup default
set history=500                      " Keep 500 lines of command line history
set backupdir=~/.vim/backup//        " Backup files stored seperate folder
set directory=~/.vim/swap//          " Backup files stored seperate folder

" Extra encoding defaults
set t_ZH=[3m                       " Reset italics encoding characters
set t_ZR=[23m                      " Reset italics encoding characters
set encoding=utf-8                   " The encoding displayed.

" Default search settings
set hlsearch                         " highlight searches
set incsearch                        " incremental searching
set ignorecase                       " ignore case for searching
set smartcase                        " do case-sensitive if there's a capital letter
set wrapscan                         " searches wrap to start of document

" Display extra whitespace
set backspace=indent,eol,start       " Allow backspacing over everything in insert mode
set listchars=tab:-▸,trail:•,extends:❯,precedes:❮
set linebreak
let &showbreak='↪ '

"Wildmenu defaults
set browsedir=buffer                 " browse files in same dir as open file
set wildmenu                         " Enhanced command line completion.
set wildmode=list:longest,full       " Complete files using a menu AND list
set wildignorecase

" wildignore prevents things from showing up in cmd completion
" -- Binary --
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.o,*.obj,*.exe,*.dll,*.jar,*.pyc,*.rbc,*.class
set wildignore+=*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
set wildignore+=*.avi,*.m4a,*.mp3,*.oga,*.ogg,*.wav,*.webm
set wildignore+=*.eot,*.otf,*.ttf,*.woff
set wildignore+=*.doc,*.pdf
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
" -- Cache --
set wildignore+=.sass-cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*.gem
" -- Compiled --
set wildignore+=*.marko.js
set wildignore+=*.min.*
" -- Temp/System --
set wildignore+=*.*~,*~
set wildignore+=*.swp,.lock,.DS_Store,._*,tags.lock

" Formatting options
set formatoptions=
set formatoptions+=c                  " Auto-wrap comments using textwidth
set formatoptions+=r                  " Continue comments by default
set formatoptions-=o                  " do not continue comment using o or O
set formatoptions+=q                  " continue comments with gq
set formatoptions-=a                  " auto-gq on type in comments?
set formatoptions+=n                  " Recognize numbered lists
set formatoptions+=2                  " Use indent from 2nd line of a paragraph
set formatoptions-=l                  " break lines that are already long?
set formatoptions+=1                  " Break before 1-letter words
set formatoptions+=j                  " no // comment when joining commented lines

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
  silent call system('mkdir -p $HOME/.vim/undo')
  set undofile                " Save undo's after file closes
  set undodir=~/.vim/undo//   " where to save undo histories
  set undolevels=1000         " How many undos
  set undoreload=10000        " number of lines to save for undo
endif

" }}}

call plug#begin()
" System Specific
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-unimpaired'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-indent'
  Plug 'Valloric/MatchTagAlways'
  Plug 'terryma/vim-expand-region'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'christoomey/vim-tmux-runner'
  Plug 'scrooloose/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'Xuyuanp/nerdtree-git-plugin'

" Command Specific
  Plug 'tpope/vim-surround'
  Plug 'tomtom/tcomment_vim'
  Plug 'mileszs/ack.vim'
  Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
  Plug 'junegunn/fzf.vim'
  Plug 'w0rp/ale'
"  Plug 'SirVer/ultisnips'
  Plug 'Raimondi/delimitMate'
  Plug 'mattn/emmet-vim'
"  Plug 'Shougo/neocomplete'
"  Plug 'Shougo/neosnippet'
"  Plug 'Shougo/neosnippet-snippets'

" Interface Specific
  Plug 'airblade/vim-gitgutter'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
"  Plug 'Valloric/YouCompleteMe', {'dir': '~/.vim/plugged/YouCompleteMe', 'do': './install --tern-completer --clang-completer'}
"  Plug 'nathanaelkane/vim-indent-guides'
"  Plug 'majutsushi/tagbar'
  Plug 'ap/vim-css-color'

" Language Specific
"  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'
  Plug 'stanangeloff/php.vim', {'for': 'php'}
  Plug 'tpope/vim-liquid', {'for': 'liquid'}
" Ruby
  Plug 'nelstrom/vim-textobj-rubyblock'
  Plug 'vim-ruby/vim-ruby'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-bundler'
  Plug 'thoughtbot/vim-rspec'

" Javascript
  Plug 'pangloss/vim-javascript'
  Plug 'othree/javascript-libraries-syntax.vim'
  Plug 'mxw/vim-jsx'
  Plug 'moll/vim-node'
  Plug 'othree/jspc.vim'
" HTML / CSS
  Plug 'cakebaker/scss-syntax.vim', {'for': ['scss','sass']}
  Plug 'hail2u/vim-css3-syntax', {'for': ['css','scss','sass']}
  Plug 'othree/html5.vim', {'for': ['html','erb']}
  Plug 'othree/html5-syntax.vim', {'for': ['html','erb']}

" Colorscheme Sections of the site
  Plug 'nanotech/jellybeans.vim'
  Plug 'vim-scripts/Gummybears'
  Plug 'morhetz/gruvbox'
  Plug 'marciomazza/vim-brogrammer-theme'
  Plug 'chriskempson/vim-tomorrow-theme'
  Plug 'scwood/vim-hybrid'
  Plug 'rakr/vim-one'
  Plug 'joshdick/onedark.vim'
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'davb5/wombat256dave'
call plug#end()

" Enable Vim's built in matching plugin
runtime macros/matchit.vim

" Color scheme specifics configurations
set background=dark
let g:gruvbox_italic = 1
let g:one_allow_italics = 1
let g:jellybeans_use_term_italics = 1
let g:gummybears_use_term_italics = 1
let g:onedark_terminal_italics = 1
let g:airline_theme='powerlineish'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

colorscheme wombat256dave


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

" Setting custom tag match highlighting
let g:mta_filetypes = {
  \ 'html' : 1,
  \ 'xhtml' : 1,
  \ 'xml' : 1,
  \ 'erb' : 1
  \}


let g:jsx_ext_required = 0
let g:used_javascript_libs = 'underscore,jquery,react'

" neocomplete {{{

  " let g:neocomplete#data_directory = '~/.vim/neocomplete'
  " let g:neocomplete#enable_at_startup = 1
  " let g:neocomplete#enable_auto_select = 1
  " let g:neocomplete#enable_smart_case = 1
  " let g:neocomplete#auto_completion_start_length = 2
  "
  " " increase limit for tag cache files
  " let g:neocomplete#sources#tags#cache_limit_size = 33554432 " 32MB
  "
  " " always use completions from all buffers
  " if !exists('g:neocomplete#same_filetypes')
  "   let g:neocomplete#same_filetypes = {}
  " endif
  " let g:neocomplete#same_filetypes._ = '_'
  "
  " " enable omni-completion for Ruby and PHP
  " call neocomplete#util#set_default_dictionary(
  "   \'g:neocomplete#sources#omni#input_patterns', 'ruby',
  "   \'[^. *\t]\.\h\w*\|\h\w*::\w*')
  " call neocomplete#util#set_default_dictionary(
  "   \'g:neocomplete#sources#omni#input_patterns', 'php',
  "   \'[^. \t]->\h\w*\|\h\w*::\w*')
  "
  "
  " " Plugin key-mappings.
  " inoremap <expr> <C-g> neocomplete#undo_completion()
  " inoremap <expr> <C-l> neocomplete#complete_common_string()
  "
  " " Recommended key-mappings.
  " " <CR>: cancel popup and insert newline.
  " inoremap <silent> <CR> <C-r>=neocomplete#smart_close_popup()<CR><CR>
  " " <TAB>: completion.
  " inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"
  " " <C-h>, <BS>: close popup and delete backword char.
  " inoremap <expr> <C-h> neocomplete#smart_close_popup()."\<C-h>"
  " inoremap <expr> <BS>  neocomplete#smart_close_popup()."\<C-h>"
  " inoremap <expr> <C-y> neocomplete#close_popup()
  " inoremap <expr> <C-e> neocomplete#cancel_popup()
  "
" }}}

" ALE Linter {{{

  let g:ale_sign_error = '✗'
  let g:ale_sign_warning = '⚠'

  let g:ale_statusline_format = ['✗ %d', '⚠ %d', '⬥ ok']

  let g:ale_echo_msg_error_str = 'Error'
  let g:ale_echo_msg_warning_str = 'Warn'
  let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

  set statusline+=%#warningmsg#
  set statusline+=%{ALEGetStatusLine()}
  set statusline+=%*

  let g:ale_javascript_jshint_executable = 'jshint esversion:6'

" }}}

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

" Set spell checking on certain files types
autocmd FileType gitcommit,markdown setlocal spell

" Fix the color syncing in vim8
autocmd BufEnter * :syntax sync fromstart

" Launch current file with web browser
function StartFirefox()
  silent execute "!firefox % 2>&1 &"
  redraw!
endfunction
function StartChrome()
  silent execute "!chrome-browser % 2>&1 &"
  redraw!
endfunction
function StartVivaldi()
  silent execute "!vivaldi % 2>&1 &"
  redraw!
endfunction
nnoremap <F12>f :execute ':call StartFirefox()' <CR>
nnoremap <F12>c :execute ':call StartChrome()' <CR>
nnoremap <F12>v :execute ':call StartFirefox()' <CR>

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

nmap <C-p> :Files<Cr>
nmap <a-p> :Ack!<Space>

" Search and replace under the cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

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

" Tagbar Configuration
nmap <F8> :TagbarToggle<CR>

" NERDTree {{{

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
"                   Visual Mode Maps
" ==========================================================
" Line Bubbling
vnoremap <A-k> [egv
vnoremap <A-j> ]egv

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Reset the bg color to terminal for transparency
set t_Co=256
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight Comment cterm=italic gui=italic
syntax sync fromstart                " Ensure source highlighting is correct

