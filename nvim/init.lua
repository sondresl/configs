
require('my.plugins')
require('my.mappings')
require('my.telescope')
require('my.lsp')
require('my.compe')
require('my.easymotion')
require('my.lualine')

vim.g.builtin_lsp = true
vim.opt.path:append(".,**")

vim.opt.hidden          = true
vim.opt.hlsearch        = false
vim.opt.showmode        = false

vim.opt.incsearch       = true
vim.opt.inccommand      = "nosplit"

vim.opt.scrolloff       = 2

vim.opt.completeopt     = "menuone,noinsert,noselect"
-- vim.opt.completeopt     = "menuone,noselect"
vim.opt.wildmenu        = true

vim.opt.swapfile        = false

vim.opt.number          = false
vim.opt.relativenumber  = false
vim.opt.cursorline      = true

-- vim.opt.t_vb            =
vim.opt.mouse           = "a"
vim.opt.ignorecase      = true
vim.opt.smartcase       = true
vim.opt.binary          = true
vim.opt.showmatch       = true
vim.opt.clipboard       = "unnamed"
vim.opt.laststatus      = 2

vim.opt.tabstop         = 4
vim.opt.shiftwidth      = 4
vim.opt.shiftround      = true
vim.opt.softtabstop     = 4
vim.opt.expandtab       = true
vim.opt.smarttab        = true

-- Split window below / right
vim.opt.splitbelow      = true
vim.opt.splitright      = true

vim.opt.background      = "light"
vim.g.colors_name       = "gruvbox"
-- vim.cmd([[colorscheme gruvbox]])

-- Permanent undo
-- vim.opt.undodir         = "~/.config/nvim/.vimdid"
vim.opt.undofile        = true


vim.api.nvim_exec([[
augroup vimrc-incsearch-highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

augroup lang-indents
    autocmd!
    autocmd BufEnter *.hs :set tabstop=2 shiftwidth=2 softtabstop=2
augroup END
    ]],
    false)

