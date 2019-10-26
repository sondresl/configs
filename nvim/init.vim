" Sondre Lunde
" .vimrc

" Rather than a leader bind, bind directly to space.
" This also allows other keys (like BS and CR) to be used
" in the same fashion without confusing the idea of a specific leader key.
"""" BIND LEADER
let mapleader = " "                     " Leader key for various keybinds
" Bind it before all plugin related leader binds.

" ===============
" === PLUGINS ===
" ===============

" Automatically install Plug if not installed.
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.nvim/plugged')
    Plug 'vim-scripts/paredit.vim'
    Plug 'elmcast/elm-vim'
    Plug 'takac/vim-hardtime'
    Plug 'davidhalter/jedi-vim'
    Plug 'kien/rainbow_parentheses.vim'
    Plug 'tpope/vim-commentary'                 " Comment properly
    Plug 'jpalardy/vim-slime'                   " Send code to REPL.
    Plug 'w0rp/ale'                             " Syntax checking
    Plug 'itchyny/lightline.vim'                " Modeline
    Plug 'honza/vim-snippets'                   " Snippets library
    Plug 'gruvbox-community/gruvbox'            " Theme
    Plug '/usr/local/opt/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
    Plug 'sheerun/vim-polyglot'
    Plug 'SirVer/ultisnips'
    " Plug 'lervag/vimtex'
    Plug 'wellle/targets.vim'
    Plug 'rust-lang/rust.vim'
    if has('nvim')
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    else
        Plug 'Shougo/deoplete.nvim'
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hug-neovim-rpc'
    endif
    Plug 'deoplete-plugins/deoplete-jedi'
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }
call plug#end()

" ==============
" === COLORS ===
" ==============

" ==== LIGHTLINE ====
let g:lightline = { 'colorscheme': 'one',
                  \ 'active': {
                  \   'left': [ [ 'mode', 'paste' ],
                  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
                  \ },
                  \ }

" ==== Language Server ====
let g:LanguageClient_autoStart = 1
let g:LanguageClient_loadSettings = 1
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rls'],
    \ }

" ==== Paredit ====
let g:paredit_leader = '<CR>'
let g:paredit_smartjump = 1
let g:paredit_electric_return = 0

" ==== Polyglot
let g:polyglot_disabled = ['elm']

" ==== ALE ====
let g:ale_enabled = 1
let g:ale_sign_column_always = 0
let g:ale_c_clang_options = "-std=c99 -Wall -Wpedantic -Wextra -fsanitize=address"

" only lint on save --> Taken from https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.vim
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_virtualtext_cursor = 1

" Ale for Rust
let g:ale_rust_rls_config = {
	\ 'rust': {
		\ 'all_targets': 1,
		\ 'build_on_save': 1,
		\ 'clippy_preference': 'on'
	\ }
	\ }
let g:ale_rust_rls_toolchain = ''
let g:ale_linters = {'rust': ['rls']}

let g:rustfmt_command = "rustfmt +nightly"
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0

" ==== Deoplete ====
let g:deoplete#enable_at_startup = 1
" call deoplete#custom#option('sources', {
" \ '_': ['ale', 'foobar'],
" \})
"


" ==== Markdown-preview
nmap <Space>tt <Plug>MarkdownPreviewToggle
nmap <Space>ts <Plug>MarkdownPreview

" ==== Slime ====
if exists('$TMUX')
    let g:slime_target = "tmux"
    let g:slime_paste_file = "$HOME/.slime_paste"
    let g:slime_default_config = {"socket_name": split($TMUX, ",")[0], "target_pane": ":.1"}
    let g:slime_python_ipython = 1
end

autocmd FileType scheme nnoremap <c-c><c-d> :SlimeSend1 (load "<c-r>%")<CR>
autocmd FileType clojure nnoremap <c-c><c-d> :SlimeSend1 (load-file "<c-r>%")<CR>
autocmd FileType haskell nnoremap <c-c><c-d> :SlimeSend1 runhaskell <c-r>%<CR>

" ==== ULTISNIPS ====
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" ==== JEDI-VIM ====
let g:jedi#goto_command = ""
let g:jedi#goto_assignments_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = ""
let g:jedi#usages_command = ""
let g:jedi#completions_command = ""
let g:jedi#rename_command = ""

" ==== Hardtime ====
let g:hardtime_default_on = 0

" =================
" === LANGAUGES ===
" =================

" ==== PYTHON ====
let g:jedi#completions_enabled = 0

" ==== TEX ====
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=0
let g:tex_conceal='abdmg'

" ==== MAKEFILE ====
autocmd FileType make setlocal noexpandtab

" ==== Rainbow Parens
au VimEnter *.scm,*.clj RainbowParenthesesToggle
au Syntax *.scm,*.clj RainbowParenthesesLoadRound
au Syntax *.scm,*.clj RainbowParenthesesLoadSquare
au Syntax *.scm,*.clj RainbowParenthesesLoadBraces

" ================
" === SETTINGS ===
" ================

filetype plugin indent on
syntax on
set encoding=utf-8
set path=.,**                            " Make certain commands look for all files in all subfolders
set autoread
set hidden
set showcmd
set noshowmode                          " Don't show mode in command line (its on the lightline!)
set nohlsearch                          " Don't highlight searchee
set incsearch                           " Search incrementally, don't wait for <CR>
if has('nvim')
    set inccommand=nosplit
end
set scrolloff=2                         " Always have 2 lines above/below cursor
set shortmess+=I                        " Remove startup message
set shortmess+=c
set omnifunc=syntaxcomplete#Complete
set dict+=~/.config/nvim/dicts/ordliste_aspell.txt
set complete+=k

" Wildmenu - Start writing a command and get options to <TAB> through.
set wildmenu                            " Tab completion when multiple options available
set wildignore+=*.class,*.aux           " Ignore *.class files in the wildmenu

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
set undodir=~/.config/nvim/.vimdid
set undofile

let &runtimepath.=',~/.vim/bundle/neoterm'

" Diff
" set diffopt=vertical,filler,context:3,indent-heuristic,algorithm:patience,internal

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

" Map ctrl-s to enter command mode.
map <C-s> :

map <silent> <space>c :!ctags -R .<CR>
map <space>s :source ~/.config/nvim/init.vim<CR>
map <space>e :vs $MYVIMRC<CR>
map <space>w :write<CR>
map <space>q :q<CR>
map <space><space> :e#<CR>
nnoremap <space>o :ALEToggle<CR>

" === FZF ===
map <space>b :Buffers<CR>
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> - :Files <C-r>=expand("%:h")<CR>/<CR>
map <space>r :Rg<CR>
nnoremap <space>h :Helptags<CR>

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" === F Keys ===
nnoremap <F12> :silent! !clang-format -i -style='WebKit' %<CR>

" F-buttons (Fairly rare and specific uses)
autocmd FileType python map <F9> :w<CR>:!python %<CR>
autocmd FileType python map <silent> <F10> :!python % > out<CR><CR>
autocmd FileType c map <silent> <F9> :!make; ./out<CR>
autocmd FileType c map <silent> <F10> :!make; ./out > clang_output<CR><CR>
autocmd FileType tex map <silent> <space>y :!pdflatex %<CR>

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

set nottimeout
