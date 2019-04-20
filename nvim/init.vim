" Sondte Lunde
" .vimrc

"""" BIND LEADER
let mapleader = " "                     " Leader key for various keybinds
" Bind it before all plugin related leader binds.

" ===============
" === PLUGINS ===
" ===============

" Automatically install Plug if not installed.
if empty(glob('~/.nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.nvim/plugged')
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif
    " Plug 'takac/vim-hardtime'
    Plug 'davidhalter/jedi-vim'
    Plug 'ervandew/supertab'
    Plug 'zchee/deoplete-jedi'
    Plug 'mhinz/vim-grepper'
    Plug 'tpope/vim-commentary'                 " Comment properly
    Plug 'jpalardy/vim-slime'                   " Send code to REPL.
    Plug 'w0rp/ale'                             " Syntax checking
    Plug 'scrooloose/nerdtree'                  " Tree-view file finding
    Plug 'itchyny/lightline.vim'                " Modeline
    Plug 'ElmCast/elm-vim'                      " Support for Elm
    Plug 'SirVer/ultisnips'                     " Snippets
    Plug 'honza/vim-snippets'                   " Snippets library
    Plug 'dkasak/gruvbox'                       " Theme
    Plug '/usr/local/opt/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'udalov/kotlin-vim'
    Plug 'sheerun/vim-polyglot'
    Plug 'vim-syntastic/syntastic'
    Plug 'vim-latex/vim-latex'
call plug#end()

" ==============
" === COLORS ===
" ==============

" ==== LIGHTLINE ====
let g:lightline = { 'colorscheme': 'one',
                  \ 'active': {
                  \   'left': [ [ 'paste' ],
                  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
                  \ },
                  \ }

" ==== NERDTREE ====
let NERDTreeIgnore = ['__pycache__', '\.pyc$','\.o$', '\.so$', '\.a$', '\.swp', '*\.swp', '\.swo', '\.swn', '\.swh', '\.swm', '\.swl', '\.swk', '\.sw*$', '[a-zA-Z]*egg[a-zA-Z]*', '.DS_Store', '.class']
let NERDTreeShowHidden=1
let g:NERDTreeWinPos="left"
let g:NERDTreeDirArrows=0
map <C-t> :NERDTreeToggle<CR>

" ==== ALE ====
let g:ale_enabled = 0
let g:ale_sign_column_always = 0
nnoremap <leader>o :ALEToggle<CR>
let g:ale_c_clang_options = "-std=c99 -Wall -Wpedantic -Wextra -fsanitize=address"

" ==== Slime ====
if exists('$TMUX')
    let g:slime_target = "tmux"
    let g:slime_paste_file = "$HOME/.slime_paste"
    let g:slime_default_config = {"socket_name": split($TMUX, ",")[0], "target_pane": ":.1"}
    let g:slime_python_ipython = 1
end

" ==== ULTISNIPS ====
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" ==== Deoplete ====
let g:deoplete#enable_at_startup = 1

" ==== Supertab ====
let g:SuperTabClosePreviewOnPopupClose = 1

" ==== JEDI-VIM ====
let g:jedi#goto_command = ""
let g:jedi#goto_assignments_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = ""
let g:jedi#usages_command = ""
let g:jedi#completions_command = ""
let g:jedi#rename_command = ""

" =================
" === LANGAUGES ===
" =================

" ==== JAVA ====
" autocmd FileType java setlocal omnifunc=javacomplete#Complete

" ==== PYTHON ====
let g:jedi#completions_enabled = 0

" ==== TEX ====
let g:tex_flavor='latex'

" ==== MAKEFILE ====
autocmd FileType make setlocal noexpandtab

" ================
" === SETTINGS ===
" ================

filetype plugin indent on
syntax enable
set encoding=utf-8
set path+=**                            " Make certain commands look for all files in all subfolders
set hidden
set showcmd
set noshowmode                          " Don't show mode in command line (its on the lightline!)
set nohlsearch                          " Don't highlight searches
set incsearch                           " Search incrementally, don't wait for <CR>
if has('nvim')
    set inccommand=nosplit
end
set scrolloff=2                         " Always have 4 lines above/below cursor
set shortmess+=I                        " Remove startup message
set omnifunc=syntaxcomplete#Complete
" set guicursor=                          " Disables guicursor    

" Wildmenu - Start writing a command and get options to <TAB> through.
set wildmenu                            " Tab completion when multiple options available
set wildignore+=*.class                 " Ignore *.class files in the wildmenu

" Editor options
set nonumber norelativenumber
set cursorline                        " Soft highlight the line where the cursor is.
set colorcolumn=0                       " Place a column at the 80th char line.
set ignorecase                          " If search in lowercase, find any case matching
set smartcase                           " If searching for capital letters, find only capital letters
set autoindent
set backspace=indent,eol,start          " Make backspace work like you expect
set nostartofline
set noerrorbells
set t_vb=
set mouse=a                             " Enable mouse
set cmdheight=1
set binary                              " Dont add newlines at the end of files.
set noswapfile                          " Keep vim from creating automatic backup files.
set showmatch                           " Show matching brackets.
set clipboard=unnamed                   " Use default OS clipboard by default.
set laststatus=2

" Indent and tabs options
set tabstop=4
set shiftwidth=4
set shiftround                          " Indents are rounded to nearest shiftwidth
set softtabstop=4
set expandtab
set smarttab

" Make splits appear on the right / below
set splitright
set splitbelow

" Permanent undo
set undodir=~/.vimdid
set undofile

" === COLORSCHEME ===
let base16colorspace=256
colorscheme gruvbox
let g:gruvbox_italics=1                         " Make sure terminal supports italics.
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='hard'
set background=dark                             " Dark background as default
hi Normal ctermbg=none
" Terminal colors: 1b1c1c

" ==================
" === Autogroups ===
" ==================
augroup configgroup
    autocmd!
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    autocmd BufEnter *.pl setlocal filetype=prolog
    autocmd BufEnter *.mini setlocal filetype=clojure
augroup END


" =================
" === KEY BINDS ===
" =================

" Leader key / Search
map <silent> <leader>c :!ctags -R .<CR>
map <leader>s :source ~/.config/nvim/init.vim<CR>
map <leader>e :vs $MYVIMRC<CR>
map gj :join<CR>
map <leader>w :write<CR>
map <space><space> :e#<CR>
noremap <silent> <leader><cr> :noh<cr>
nnoremap <F12> :silent! !clang-format -i -style='WebKit' %<CR>

" ==== FZF ====
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

map <leader>b :Buffers<CR>
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> - :Files <C-r>=expand("%:h")<CR>/<CR>
map <leader>r :Rg<CR>
map <leader>t yiw:Tags "<CR><CR>
map <leader>y yiw:Rg "<CR>


" F-buttons (Fairly rare and specific uses)
autocmd FileType python map <F9> :w<CR>:!python %<CR>
autocmd FileType python map <silent> <F10> :!python % > out<CR><CR>
autocmd FileType c map <silent> <F9> :!make; ./out<CR>
autocmd FileType c map <silent> <F10> :!make; ./out > clang_output<CR><CR>

" Make Y function like D and C.
nnoremap Y y$

" Split movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

noremap H     ^
noremap L     $

" Jump to tag under cursor
nnoremap å <C-]>zt
" Jump back down the tag stack
nnoremap æ :po<CR>zt

" Leave insert mode in built-in Terminal emulator
tnoremap <Esc> <C-\><C-n>

" Certain commands that needs to be set at the end.
set nottimeout
