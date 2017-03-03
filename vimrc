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
"set cursorline                       " Highlight the line the cursor is on

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

" Load up all of our plugins
if filereadable(expand("~/.vim.plug"))
  source ~/.vim.plug
endif

" Enable Vim's built in matching plugin
" runtime macros/matchit.vim

"HTML Editing
set matchpairs+=<:>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" For Airline to display status properly
set laststatus=2

" Setting custom tag match highlighting
let g:mta_filetypes = {
  \ 'html' : 1,
  \ 'xhtml' : 1,
  \ 'xml' : 1,
  \ 'erb' : 1
  \}

let g:jsx_ext_required = 0
let g:used_javascript_libs = 'underscore,jquery,react'

" Fakes out Gnome-Terminal to allow keybindings alt/meta to pass through
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

set timeout ttimeoutlen=50

" }}}

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

"Map Ctrl + S to save in any mode
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" Quickly close windows
nnoremap <leader>x :x<cr>
nnoremap <leader>X :q!<cr>

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
nnoremap <F12>v :execute ':call StartFirefox()' <CR>


" ==========================================================
"                  Generic Leader Maps
" ==========================================================

" Edit another file in the same directory as the current file
map <Leader>e :e <C-R>=escape(expand("%:p:h"),' ') . '/'<CR>
map <Leader>s :split <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <Leader>v :vnew <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <Leader><Space> o<esc>

" RSpec.vim mappings
" map <Leader>t :call RunCurrentSpecFile()<CR>
" map <Leader>s :call RunNearestSpec()<CR>
" map <Leader>l :call RunLastSpec()<CR>
" map <Leader>a :call RunAllSpecs()<CR>

map <Leader>y "+y
map <Leader>p "+p

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


" ==========================================================
"                 AUTOCOMMANDS - Do stuff
" ==========================================================

" Fix the color syncing in vim8
autocmd BufEnter * :syntax sync fromstart

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
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

" tern
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  let g:tern_map_keys = 1

  autocmd FileType javascript setlocal omnifunc=tern#Complete
endif

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

  " autocmd BufRead *.jsx set ft=jsx.html
  " autocmd BufNewFile *.jsx set ft=jsx.html

  " Automatically wrap at 100 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=100

  " Automatically wrap at 100 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=100
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass,less setlocal iskeyword+=-
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


