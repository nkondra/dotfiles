" ===========================================================
"           Vim8 Configuration Nathan Kondra
" ===========================================================

" Reset the leader to spacebar
let mapleader = "\<Space>"

set nocompatible                     " be iMproved, required
filetype on                          " Enable filetype detection
filetype indent on                   " Enable filetype-specific indenting
filetype plugin on                   " Enable filetype-specific plugins
syntax on                            " Enable syntax highlighting

set relativenumber                   " Show relative line numbers
set number                           " Show lines numbers
set numberwidth=5                    " 
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
set scrolloff=8                      " Show number of lines off end of files

" Default Tab and indenting rules
set expandtab                        " Expand tabs to spaces
set shiftwidth=2                     " Softtabs with 2 space
set softtabstop=2                    " Softtabs with 2 spaces
set smarttab                         " Use shiftwidth to enter tabs
set backspace=indent,eol,start       " Allow backspacing over everything in insert mode


" use multiple of shiftwidth when shifting indent levels.
" this is OFF so block comments don't get fudged when using ">>" and "<<"
set noshiftround

" Refer also to formatoptions+=o (copy comment indent to newline)
set nocopyindent

" Try not to change the indent structure on "<<" and ">>" commands. I.e. keep
" block comments aligned with space if there is a space there.
set nopreserveindent

" Smart detect when in braces and parens. Has annoying side effect that it
" won't indent lines beginning with '#'. Relying on syntax indentexpr instead.
" 'smartindent' in general is a piece of garbage, never turn it on.
set nosmartindent

" Global setting. I don't edit C-style code all the time so don't default to
" C-style indenting.
set nocindent

" Vim backup default
set history=500                      " Keep 500 lines of command line history
set backupdir=~/.vim/backup//        " Backup files stored seperate folder
set directory=~/.vim/swap//          " Backup files stored seperate folder
set backupskip+=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*
set backupskip+=/private/tmp/*"
set backupskip+=~/.secret/*

" Extra encoding defaults
set t_ZH=[3m                       " Reset italics encoding characters
set t_ZR=[23m                      " Reset italics encoding characters
set encoding=utf-8                   " The encoding displayed.

" Default search settings
set hlsearch                         " highlight searches
set incsearch                        " incremental searching
set ignorecase                       " ignore case for searching
set smartcase                        " do case-sensitive i fthere's a capital letter
set wrapscan                         " searches wrap to start of document

" Display extra whitespace
set list
set listchars=
set listchars+=tab:→\ 
set listchars+=trail:•
set listchars+=extends:»              " show cut off when nowrap
set listchars+=precedes:«
set listchars+=nbsp:⣿
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
set wildignore+=npm-debug.log
" -- Compiled --
set wildignore+=*.marko.js
set wildignore+=*.min.*,*-min.*
" -- Temp/System --
set wildignore+=*.*~,*~
set wildignore+=*.swp,.lock,.DS_Store,._*,tags.lock

" Note this is += since fillchars was defined in the window config
set fillchars+=diff:⣿
set diffopt=vertical                  " Use in vertical diff mode
set diffopt+=filler                   " blank lines to keep sides aligned
set diffopt+=iwhite                   " Ignore whitespace changes

" File saving
set fileformats=unix,mac,dos
if !&modifiable
  set fileformat=unix
endif

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

" Fakes out Gnome-Terminal to allow keybindings alt/meta to pass through
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

" ==========================================================
" Plugins Load
" ==========================================================

" Load up all of our plugins
if filereadable(expand("~/.vim.plug"))
  source ~/.vim.plug
endif

" ==========================================================
" Color scheme specifics configurations
" ==========================================================

set background=dark
let g:onedark_terminal_italics = 1
let g:airline_theme='codedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" For Airline to display status properly
set laststatus=2

colorscheme onedark

" Configurations for tmux navigator github.com/christoomey/vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1

" Custom runner for rspec to hook into dispatcher
" let g:rspec_command = "Dispatch bundle exec rspec {spec}"
let g:rspec_command = 'call Send_to_Tmux("rspec -f d {spec}\n")'

" Setting custom tag match highlighting
let g:mta_filetypes = {
  \ 'html' : 1,
  \ 'xhtml' : 1,
  \ 'xml' : 1,
  \ 'eruby' : 1
  \}

" Enable Vim's built in matching plugin
runtime macros/matchit.vim

"HTML Editing
" set matchpairs+=<:>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

let g:jsx_ext_required = 0
let g:used_javascript_libs = 'underscore,jquery,react'

set timeout ttimeoutlen=50

" ==========================================================
" Filetype: python
" ==========================================================

" $VIMRUNTIME/syntax/python.vim
let g:python_highlight_all = 1


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

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Quickly close windows
nnoremap <leader>x :x<cr>

" Loose window list to write
command W w

" resize panes
nnoremap <silent> <Right> :vertical resize +5<cr>
nnoremap <silent> <Left> :vertical resize -5<cr>
nnoremap <silent> <Up> :resize +5<cr>
nnoremap <silent> <Down> :resize -5<cr>

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
nnoremap <F12>v :execute ':call StartVivaldi()' <CR>


" ==========================================================
"                  Generic Leader Maps
" ==========================================================

" Edit another file in the same directory as the current file
map <Leader>e :e <C-R>=escape(expand("%:p:h"),' ') . '/'<CR>
" map <Leader>s :split <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <Leader>v :vnew <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <Leader><Space> o<esc>

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

map <Leader>y "+y
map <Leader>p "+p

let g:vimwiki_list = [{'path': '~/.wiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:instant_markdown_autostart = 0
nmap <leader>w :VimwikiIndex<CR>
nmap <leader>md :InstantMarkdownPreview<CR>


" Provide a more sane way to navigate with standard keys
nmap j gj
nmap k gk

" Line Bubbling
nmap <A-k> [e
nmap <A-j> ]e

" Set Hotkeys for FZF and AG for searching files
nmap <C-p> :Files<Cr>
nmap <a-p> :Ack!<Space>

" Search and replace under the cursor
" nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

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


" ==========================================================
"                 AUTOCOMMANDS - Do stuff
" ==========================================================

" Fix the color syncing in vim8
autocmd BufEnter * :syntax sync fromstart

" Always have rainbow parens on
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Close vim if only NERDTree is open
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

augroup myfiletypes
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml setlocal ai sw=2 sts=2 et
  autocmd FileType ruby,eruby,yaml setlocal path+=lib

  " Make ?s part of words
  autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?

  " Set spell checking on certain files types
  autocmd FileType gitcommit,markdown setlocal spell

augroup END

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTag
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile *.plug set filetype=vim

  autocmd BufRead *.jsx set ft=jsx.html
  autocmd BufNewFile *.jsx set ft=jsx.html

  " Automatically wrap at 100 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=100

  " Automatically wrap at 100 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=100
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass,less setlocal iskeyword+=-
augroup END

function! PhpSyntaxOverride()
  hi! def link phpDocTags  phpDefine
  hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END

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
