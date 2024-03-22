
nnoremap <space>w :w<CR>
nnoremap <space>q :q<CR>
nnoremap <space><space> :e#<CR>
nnoremap <C-s> :

" Navigation
nnoremap <C-h> <C-w><C-h>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-j> <C-w><C-j>

" Use system clipboard as default
set clipboard=unnamedplus
set ignorecase smartcase

" Highlight during a search
augroup vimrc-incsearch-highlight
  autocmd!
  autocmd CmdlineEnter /,\? :set hlsearch
  autocmd CmdlineLeave /,\? :set nohlsearch
augroup END
