
-- <Leader>f{char} to move to {char}
--
vim.api.nvim_set_keymap("n", "<Space><CR>", "<Plug>(easymotion-s2)", { noremap = false, silent = false })
-- nmap <Leader>f <Plug>(easymotion-overwin-f)

-- s{char}{char} to move to {char}{char}
-- nmap s <Plug>(easymotion-overwin-f2)

-- Move to line
-- map <Leader>L <Plug>(easymotion-bd-jk)
-- nmap <Leader>L <Plug>(easymotion-overwin-line)

-- Move to word
-- map  <Leader>w <Plug>(easymotion-bd-w)
-- nmap <Leader>w <Plug>(easymotion-overwin-w)
