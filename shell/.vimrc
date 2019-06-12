" Sondre Lunde
" .vimrc
"
source ~/.dotfiles/init.vim

" set nocompatible " Get proper VIM.

" " Some basic changes
" filetype plugin indent on
" syntax enable
" set path+=**                            " Make certain commands look for all files in all subfolders
" set hidden
" " set showcmd
" set noshowmode                          " Don't show mode in command line (its on the lightline!)
" set modeline
" set nohlsearch                          " Don't highlight searches
" set incsearch                           " Search incrementally, don't wait for <CR>
" set scrolloff=4                         " Always have 4 lines above/below cursor
" set shortmess+=I

" " Wildmenu - Start writing a command and get options to <TAB> through.

" set wildmenu                            " Tab completion when multiple options available
" set wildignore+=*.class                 " Ignore *.class files in the wildmenu
" if exists("g:ctrl_user_command")
"     unlet g:ctrlp_user_command
" endif

" " Usability options
" set nocursorline                        " Soft highlight the line where the cursor is.
" set colorcolumn=0                      " Place a column at the 80th char line.
" set ignorecase                          " If search in lowercase, find any case matching
" set smartcase                           " If searching for capital letters, find only capital letters
" set autoindent
" set backspace=indent,eol,start          " Make backspace work like you expect
" set nostartofline
" set laststatus=2
" set noerrorbells
" set t_vb=
" set ttymouse=xterm2                     " Allow mouse to work in tmux
" set mouse=a                             " Enable mouse
" set cmdheight=1
" set nonumber norelativenumber             " Line numbers, but no relative
" set notimeout ttimeout ttimeoutlen=200
" set binary                              " Dont add newlines at the end of files.
" set noswapfile                          " Keep vim from creating automatic backup files.
" set showmatch                           " Show matching brackets.
" set clipboard=unnamed                   " Use default OS clipboard by default.

" " Indent and tabs options
" set tabstop=4
" set shiftwidth=4
" set shiftround                          " Indents are rounded to nearest shiftwidth
" set softtabstop=4
" set expandtab
" set smarttab

" " " Toggle relative numbers based on focus.
" " augroup numbertoggle
" "     autocmd!
" "     autocmd BufEnter,FocusGained * set relativenumber 
" "     autocmd BufLeave,FocusLost   * set norelativenumber 
" " augroup END

" " Make splits appear on the right / below
" set splitright
" set splitbelow

" " Leader key / Search
" let mapleader = ","                     " Leader key for various keybinds
" map <leader>s :source ~/.vimrc<CR>
" map <leader>w :write<CR>

" " Mappings

" " Make Y function like D and C.
" map Y y$

" " Make :Q and :W act as :q and :w
" command W w
" command Q q

" " Split movement                        " Ctrl + hjkl to move in splits.
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

" " Disable highlight when <leader><cr> is pressed
" noremap <silent> <leader><cr> :noh<cr>

" " Tags and jumps - Requires ctags. Call 'ctags -R .' to create tags-file
" " for current folder and subfolders.
" map <silent> <leader>c :!ctags -R .<CR>

" map $ <Nop>
" map ^ <Nop>
" map { <Nop>
" map } <Nop>

" " Leader K to join lines.
" map <leader>j :j<CR>
" map <leader><leader> :

" noremap K     {
" noremap J     }
" noremap H     ^
" noremap L     $

" " nnoremap <Tab>   >>
" " nnoremap <S-Tab> <<
" " vnoremap <Tab>   >><Esc>gv
" " vnoremap <S-Tab> <<<Esc>gv

" " nmap >> <Nop>
" " nmap << <Nop>
" " vmap >> <Nop>
" " vmap << <Nop>


" " Jump to tag under cursor
" nnoremap å <C-]> 
" " Jump back down the tag stack
" nnoremap æ :po<CR>

" " Some useful existing keybinds for jumps
" " <C-O> to jump down the tag stack.
" " <C-I> to jump back up.

" " Automatically install Plug if not installed.
" if empty(glob('~/.vim/autoload/plug.vim'))
"   silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
"     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif

" " Plugins
" call plug#begin('~/.vim/plugged')
"     Plug 'christoomey/vim-tmux-navigator'       " Seamless tmux navigation
"     Plug 'wellle/targets.vim'
"     Plug 'tpope/vim-commentary'                 " Comment properly
"     Plug 'tpope/vim-fugitive'                   " Git
"     Plug 'tpope/vim-surround'                   " Easily change around objects
"     Plug 'airblade/vim-gitgutter'
"     Plug 'neovimhaskell/haskell-vim'            " Improved hightlighting for Haskell
"     Plug 'alx741/vim-hindent'                   " Proper indentation on save for Haskell.
"     Plug 'junegunn/rainbow_parentheses.vim'     " Rainbow parentheses
"     Plug 'jpalardy/vim-slime'                   " Send code to REPL.
"     Plug 'w0rp/ale'                             " Syntax checking
"     Plug 'kien/ctrlp.vim'                       " Fuzzy file search
"     Plug 'scrooloose/nerdtree'                  " Tree-view file finding
"     Plug 'itchyny/lightline.vim'                " Modeline
"     Plug 'easymotion/vim-easymotion'            " Movement in buffer
"     Plug 'ElmCast/elm-vim'                      " Support for Elm
"     Plug 'SirVer/ultisnips'                     " Snippets
"     Plug 'honza/vim-snippets'                   " Snippets library
"     Plug 'dkasak/gruvbox'                       " Theme
"     Plug 'rakr/vim-one'                         " Theme
" call plug#end()

" " ==== Theme and colors

" " General
" colorscheme gruvbox
" let g:gruvbox_italics=1                         " Make sure terminal supports italics.
" let g:gruvbox_contrast_dark='hard'
" set background=dark                             " Dark background as default
" " Also adds git-branch to lightline.
" let g:lightline = { 'colorscheme': 'one',
"                   \ 'active': {
"                   \   'left': [ [ 'mode', 'paste' ],
"                   \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
"                   \ },
"                   \ 'component_function': {
"                   \   'gitbranch': 'fugitive#head' }
"                   \ }


" " ==== Easymotion - For seaching
" " f to search for two characters
" " <space> for noral incremental search.
" let g:EasyMotion_do_mapping = 0
" let g:EasyMotion_smartcase = 1
" nmap f <Plug>(easymotion-s2)
" nmap <space> <Plug>(easymotion-sn)


" " ==== NERDTREE - Toggle with CTRL + t
" let NERDTreeIgnore = ['__pycache__', '\.pyc$','\.o$', '\.so$', '\.a$', '\.swp', '*\.swp', '\.swo', '\.swn', '\.swh', '\.swm', '\.swl', '\.swk', '\.sw*$', '[a-zA-Z]*egg[a-zA-Z]*', '.DS_Store', '.class']

" let NERDTreeShowHidden=1
" let g:NERDTreeWinPos="left"
" let g:NERDTreeDirArrows=0
" map <C-t> :NERDTreeToggle<CR>

" " ==== Ale - Toggle off with <leader>o (leader is ',' in my binds)
" let g:ale_enabled = 0
" nnoremap <leader>o :ALEToggle<CR>

" " ==== Slime - To 'send' code to a split in tmux (so requires tmux)

" let g:slime_target = "tmux"
" let g:slime_paste_file = "$HOME/.slime_paste"
" let g:slime_default_config = {"socket_name": split($TMUX, ",")[0], "target_pane": ":.1"}
" let g:slime_python_ipython = 1

" " ==== Haskell.vim
" let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
" let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
" let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
" let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
" let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
" let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
" let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

" " ==== Hindent
" let g:hindent_on_save = 1
" let g:hindent_indent_size = 2
" let g:hindent_line_length = 100

" " ==== Ultisnips

" " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" " This .vimrc does not use YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" " If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" " ==== Git gutter
" let g:gitgutter_enabled = 0
" map <leader>g :GitGutterToggle<CR>

" " ==== THE END
