-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- === SETTINGS ===
lvim.transparent_window = true

lvim.builtin.bufferline.active = false
lvim.builtin.breadcrumbs.active = false
lvim.builtin.project.manual_mode = true
vim.opt.showcmd = true


-- === KEYBINDS ===
lvim.keys.normal_mode["<C-s>"] = ":"
lvim.keys.normal_mode["<space><space>"] = ":e#<CR>"
lvim.keys.normal_mode["<C-p>"] = "<cmd>Telescope find_files<CR>"
lvim.keys.normal_mode["<C-b>"] = "<cmd>Telescope buffers<CR>"

lvim.keys.normal_mode["<A-j>"] = false
lvim.keys.normal_mode["<A-k>"] = false
lvim.keys.insert_mode["<A-j>"] = false
lvim.keys.insert_mode["<A-k>"] = false

-- Resize windows
lvim.keys.normal_mode["<F2>"] = "<C-w>>"
lvim.keys.normal_mode["<F3>"] = "10<C-w>>"
lvim.keys.normal_mode["<F4>"] = "10<C-w><"
lvim.keys.normal_mode["<F5>"] = "<C-w><"

-- Git
lvim.keys.normal_mode["<space>ga"] = ":ToggleBlame<CR>"

-- === PLUGINS ===

lvim.plugins = {
  { "rottencandy/vimkubectl" },
  { 'towolf/vim-helm', ft = 'helm' },
  { "FabijanZulj/blame.nvim" },
}

lvim.builtin.lualine.sections.lualine_c = {{ "filename", path = 1 }}

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'} , {
    pattern = '.yaml',
    callback = function()
          vim.opt_local.filetype = 'helm'
    end
})
