" Sondre Lunde
" init.vim

" Rather than a leader bind, bind directly to space.
" This also allows other keys (like BS and CR) to be used
" in the same fashion without confusing the idea of a specific leader key.
"""" BIND LEADER
" let mapleader = ","                     " Leader key for various keybinds
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
    " Movement and commands
    Plug 'easymotion/vim-easymotion'
    Plug 'takac/vim-hardtime'
    Plug '/usr/local/opt/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-commentary'                 " Comment properly
    Plug 'jpalardy/vim-slime'                   " Send code to REPL.
    Plug 'wellle/targets.vim'
    Plug 'skywind3000/asyncrun.vim'

    " Look and feel
    Plug 'junegunn/goyo.vim'
    Plug 'vim-scripts/paredit.vim'

    Plug 'sheerun/vim-polyglot'                 " Better language syntax coloring
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Git integration
    Plug 'tpope/vim-fugitive'

    " Linting and autocomplete
    Plug 'w0rp/ale'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'                   " Snippets library
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
    Plug 'rust-lang/rust.vim'
    Plug '~/.config/setcolor'
call plug#end()


" === GOYO ===
let g:goyo_width = 120
let g:goyo_heigth = 100

" " Make <tab> do everything
" inoremap <silent><expr> <TAB>
"      \ pumvisible() ? coc#_select_confirm() :
"      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" let g:LanguageClient_settingsPath = '~/.config/nvim/'

" ==== Language Server ====
" let g:LanguageClient_autoStart = 1
" let g:LanguageClient_loadSettings = 1
" let g:LanguageClient_diagnosticsEnable = 0
" let g:LanguageClient_serverCommands = {
"     \ 'rust': ['rls'],
"     \ }

" ==== Paredit ====
let g:paredit_leader = ','
let g:paredit_smartjump = 1
let g:paredit_electric_return = 0

" ==== ALE ====
let g:ale_enabled = 0
" let g:ale_sign_column_always = 0
" let g:ale_c_clang_options = "-std=c99 -Wall -Wpedantic -Wextra -fsanitize=address"
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_insert_leave = 1
" let g:ale_lint_on_save = 1
" let g:ale_lint_on_enter = 0
" let g:ale_virtualtext_cursor = 1

let g:ale_fixers = { 'haskell': ['fourmolu'], 'c': ['clang-format']}
let g:ale_c_clangformat_options = '-i -style=WebKit'


" nmap <silent> <space>af :exe ":silent !fourmolu -i --indentation 2 %"<CR>
nmap <silent> <space>af :exe ":silent %!fourmolu --indentation 2"<CR>
nmap <silent> <space>ah :exe ":silent !hlint --refactor --refactor-options=\"--inplace\" %"<CR>

" map <space>ap :ALEPrevious<CR>
" map <space>an :ALENextWrap<CR>

" " Ale for Rust
" let g:ale_rust_rls_config = {
"     \ 'rust': {
"         \ 'all_targets': 1,
"         \ 'build_on_save': 1,
"         \ 'clippy_preference': 'on'
"     \ }
"     \ }
" let g:ale_rust_rls_toolchain = ''
" let g:ale_linters = {'rust': ['rls']}

" ==== Rust autoformat
let g:rustfmt_command = "rustfmt +nightly"
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0

" === easymotion ===
" <Leader>f{char} to move to {char}
" map <CR> <Plug>(easymotion-overwin-f)
nmap <space><CR> <Plug>(easymotion-overwin-f)

" ==== Deoplete ====
" let g:deoplete#enable_at_startup = 1

" ==== Markdown-preview
nmap <Space>tt <Plug>MarkdownPreviewToggle
nmap <Space>ts <Plug>MarkdownPreview

nmap <Space>lt :vs +term<CR>

" === Grep ===
if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

" ==== Slime ====
if exists('$TMUX')
    let g:slime_target = "tmux"
    let g:slime_paste_file = "$HOME/.slime_paste"
    let g:slime_default_config = {"socket_name": split($TMUX, ",")[0], "target_pane": ":.1"}
    let g:slime_python_ipython = 1
end

autocmd FileType scheme nnoremap <c-c><c-d> :SlimeSend1 (load "<c-r>%")<CR>
autocmd FileType scheme nnoremap <c-c><c-r> :SlimeSend1 scm
autocmd FileType clojure nnoremap <c-c><c-d> :SlimeSend1 (load-file "<c-r>%")<CR>

" ==== Hardtime ====
let g:hardtime_default_on = 0

" =================
" === LANGAUGES ===
" =================

" ==== TEX ====
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=0
let g:tex_conceal='abdmg'

" ==== PDF preview ====
let g:livepreview_previewer = 'open -a Preview'

" ==== MAKEFILE ====
autocmd FileType make setlocal noexpandtab

" ==== Rainbow Parens
" au VimEnter *.scm,*.clj RainbowParenthesesToggle
" au Syntax *.scm,*.clj RainbowParenthesesLoadRound
" au Syntax *.scm,*.clj RainbowParenthesesLoadSquare
" au Syntax *.scm,*.clj RainbowParenthesesLoadBraces

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" ================
" === SETTINGS ===
" ================

filetype plugin indent on
syntax on
" set encoding=utf-8
set path=.,src/**                            " Make certain commands look for all files in all subfolders
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
" set dict+=~/.config/nvim/dicts/ordliste_aspell.txt
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
set cmdheight=2
set updatetime=300
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

set wrap

" Permanent undo
set undodir=~/.config/nvim/.vimdid
set undofile

let &runtimepath.=',~/.vim/bundle/neoterm'

" Diff
" set diffopt=vertical,filler,context:3,indent-heuristic,algorithm:patience,internal



" function! RunFormat()
"     :!fourmolu -i --indentation 2 %
"     :e!
" endfunction

" ==================
" === Autogroups ===
" ==================
augroup configgroup
    autocmd!
    autocmd BufEnter *.jadd setlocal ft=java
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    autocmd BufEnter *.s setlocal tabstop=4
    autocmd BufEnter *.s setlocal shiftwidth=4
    autocmd BufEnter *.s setlocal softtabstop=4
    autocmd BufEnter *.S setlocal tabstop=4
    autocmd BufEnter *.S setlocal shiftwidth=4
    autocmd BufEnter *.S setlocal softtabstop=4
    autocmd BufEnter *.hs setlocal tabstop=2
    autocmd BufEnter *.hs setlocal shiftwidth=2
    autocmd BufEnter *.hs setlocal softtabstop=2
    autocmd BufEnter *.pl setlocal filetype=prolog
    autocmd BufEnter *.mini setlocal filetype=clojure
    autocmd BufEnter *.x setlocal filetype=haskell
    autocmd BufEnter *.y setlocal filetype=haskell
    autocmd FileType asm setlocal commentstring=#\ %s
    autocmd BufEnter *.cmp setlocal filetype=pascal
    autocmd FileType pascal setlocal commentstring=\(\*\ %s\ \*\)
    autocmd BufEnter *.scm setlocal tabstop=2
    autocmd BufEnter *.scm setlocal shiftwidth=2
    autocmd BufEnter *.scm setlocal softtabstop=2
augroup END

augroup vimrc-incsearch-highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

" ==============
" === COLORS ===
" ==============

let g:gruvbox_bold = 1
let g:gruvbox_contrast_dark  ='hard'
let g:gruvbox_contrast_light ='hard'

" === COLORSCHEME ===
let base16colorspace=256
if (has("termguicolors"))
 set termguicolors
endif
set background=dark
colorscheme gruvbox
hi Normal guibg=none
" let g:airline_theme='solarized'
let g:airline_theme='gruvbox'

" === COC ===
" After colorscheme to ensure highlighting works as intented
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" nmap <space>rn <Plug>(coc-rename)
nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> <leader>co :CocList --number-select outline<CR>
" nmap <leader>cs :CocList --number-select -I symbols<CR>
" nmap <leader>cl :CocList --number-select <CR>
nmap <space>ch :call CocAction('doHover')<CR>
" " nmap <leader>cf :call CocAction('format')<CR>
" nmap <leader>cf :CocFix<CR>
" nmap <silent> <leader>ct <Plug>(coc-type-definition)
" nmap <silent> <leader>ci  <Plug>(coc-implementation)
" nmap <silent> <leader>cr <Plug>(coc-references)
" nmap <silent> <space>c<c-p> <Plug>(coc-diagnostic-prev)
" nmap <silent> <space>c<c-n> <Plug>(coc-diagnostic-next)
nmap <silent> <space>of :CocFix<CR>
nmap <silent> <space>oa <Plug>(coc-codelens-action)
highlight CocHighlightText  guibg=None ctermbg=None

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

nnoremap <silent> K :call <SID>show_documentation()<CR>

command! -nargs=0 Format :call CocAction('format')

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" =================
" === KEY BINDS ===
" =================

" Map ctrl-s to enter command mode.
map <C-s> :

cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>

map <space>s :source ~/.config/nvim/init.vim<CR>
map <space>ee :vs $MYVIMRC<CR>
map <space>en :sp ~/.config/nvim/ftplugin/abbrevs.vim<CR>
map <space>w :write<CR>
map <space>q :q<CR>
nnoremap <space><space> <C-^>
nnoremap <space>o :ALEToggle<CR>

" === FZF ===
map <space>b :Buffers<CR>
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> - :Files <C-r>=expand("%:h")<CR>/<CR>
nnoremap <space>rr :Rg<CR>
nnoremap <space>rw yiw:Rg <C-r>=expand('<cword>')<CR><CR>
nnoremap <space>tt :Tags<CR>
nnoremap <space>h :Helptags<CR>

let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Ignore'],
            \ 'pointer': ['fg', 'Ignore'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" Preview in :Files
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" =======================

" Automatic formatting
nnoremap <F12> :silent! !clang-format -i -style='WebKit' %<CR>
autocmd FileType haskell set formatprg=stylish-haskell

" F-buttons (Fairly rare and specific uses)
autocmd FileType python map <F9> :w<CR>:!python %<CR>
autocmd FileType python map <silent> <F10> :!python % > out<CR><CR>
autocmd FileType c map <silent> <F9> :!make; ./out<CR>
autocmd FileType c map <silent> <F10> :!make; ./out > clang_output<CR><CR>
autocmd FileType tex map <silent> <space>y :!pdflatex %<CR>
autocmd FileType haskell map <F9> :w<CR>:!runhaskell %<CR>

" Handy maps
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap Y y$

" Move between tabs
nnoremap <space>tn gt
nnoremap <space>tp gT

" Fugitive (git)
nnoremap <space>ga :Gwrite<CR>
nnoremap <space>gc :Gcommit<CR>
nnoremap <space>gr :Gread<CR>
nnoremap <space>gp :Gpush<CR>
nnoremap <space>gg :G<CR>

" Quickfix list
nnoremap <space>cn :cnext<CR>
nnoremap <space>cp :cprevious<CR>
nnoremap <space>co :copen<CR>
nnoremap <space>cc :cclose<CR>

" Reload syntax
nnoremap <space>ls :syntax sync fromStart<CR>

" Leave insert mode in built-in Terminal emulator
tnoremap <Esc> <C-\><C-n>

" Indent entire file, retain cursor position and center it on screen
nnoremap == msgg=G'szz

set nottimeout
