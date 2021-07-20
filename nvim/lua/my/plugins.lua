
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

return require('packer').startup(function()
    -- Strictly required
    use "wbthomason/packer.nvim" -- let packer manage itself
    -- use "nvim-lua/plenary.nvim"  -- utility functions

--     -- Essentials
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use "nvim-telescope/telescope.nvim" -- fuzzy find ALL the things
    use "nvim-telescope/telescope-fzy-native.nvim" -- Compiled sorter

    -- Look and feel
    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    use "junegunn/goyo.vim"

    --     use "SirVer/ultisnips"
    --     use "honza/vim-snippets"                   -- Snippets library

    use 'sheerun/vim-polyglot'                 -- Better language syntax coloring
    use "tpope/vim-commentary"                 -- Comment properly

    -- Colorschemes

    -- 0.5 features (lsp + treesitter)
    use "neovim/nvim-lsp"                             -- LSP
    use "neovim/nvim-lspconfig"                       -- basic configurations for LSP client
    use "folke/lsp-trouble.nvim"                      -- inline diagnostic info
    use "doums/lsp_status"                            -- show lsp activity in status bar
    --     use {
    --         "nvim-treesitter/nvim-treesitter",            -- treesitter
    --         run = ":TSUpdate",
    --     }
    --     use "nvim-treesitter/nvim-treesitter-textobjects" -- custom text objects from treesitter
    --     use "nvim-treesitter/nvim-treesitter-refactor"    -- nice refactoring helpers

    -- Other nice to have
    use {
        "hrsh7th/nvim-compe",                       -- autocomplete
        requires = {
            "hrsh7th/vim-vsnip",                    -- ...w/ snippet integration
            "hrsh7th/vim-vsnip-integ",
        },
    }
    -- use 'rafamadriz/friendly-snippets'
    use 'SirVer/ultisnips'
    use 'honza/vim-snippets'
    use {
        "nvim-telescope/telescope-fzf-native.nvim", -- fzf sorting for telescope
        run = "make",
    }

    use 'metakirby5/codi.vim'           -- Interactive scratch pad
    use 'easymotion/vim-easymotion'     -- Moving around
end)

-- NOTE
-- If :h <plugin> does not work, run :helptags ALL to add them"

