
-- === KEY BINDS ===

-- Map ctrl-s to enter command mode.
vim.api.nvim_set_keymap("n", "<C-s>", ":", { noremap = true, silent = false })
vim.api.nvim_set_keymap("v", "<C-s>", ":", { noremap = true, silent = false })

vim.api.nvim_set_keymap("n", "<space>s",         ":source $MYVIMRC<CR>",  { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<space>e",         ":vs $MYVIMRC<CR>",      { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<space>w",         ":write<CR>",            { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<space>q",         ":q<CR>",                { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<space><space>",   ":e#<CR>",               { noremap = true, silent = true })

-- Moving in panes
vim.api.nvim_set_keymap("n", "<C-J>", "<C-W><C-J>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-K>", "<C-W><C-K>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-L>", "<C-W><C-L>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-H>", "<C-W><C-H>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<Space>j", ":cprev<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Space>k", ":cnext<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true, silent = true})

-- ================
-- == TELESCOPE ===
-- ================

vim.api.nvim_set_keymap("n", "<C-p>",     "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<space>rr", "<cmd>Telescope live_grep<cr>",  { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<space>b",  "<cmd>Telescope buffers<cr>",    { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<space>h",  "<cmd>Telescope help_tags<cr>",  { noremap = true, silent = true })

-- Leave insert mode in built-in Terminal emulator
vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

