-- https://github.com/nvim-telescope/telescope.nvim

local telescope = require('telescope')

telescope.setup {
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case'
        },
        layout_config = {
            width           = 0.75,
            prompt_position = "bottom",
            preview_cutoff  = 120,
        },
        prompt_prefix      = "» ",
        selection_strategy = "reset",
        sorting_strategy   = "descending",
        layout_strategy    = "horizontal",
        path_display       = {"shorten"},
        winblend           = 0, -- transparency
        border             = {},
        borderchars        = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons     = true,
        use_less           = true,
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default { }, currently unsupported for shells like cmd.exe / powershell.exe
    },
    mappings = {
        i = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-c>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            ["<CR>"] = actions.select_default + actions.center,
            -- To disable a keymap, put [map] = false
            -- So, to not map "<C-n>", just put
            -- ["<c-t>"] = trouble.open_with_trouble,
            -- ["<c-x>"] = false,
            -- ["<esc>"] = actions.close,
            -- Otherwise, just set the mapping to the function that you want it to be.
            -- ["<C-i>"] = actions.select_horizontal,
            -- Add up multiple actions
            -- You can perform as many actions in a row as you like
            -- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
        },
        n = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            -- ["<c-t>"] = trouble.open_with_trouble,
            -- ["<C-i>"] = my_cool_custom_action,
        },
    },
    extensions = {
        -- fzf = {
        --     fuzzy                   = true,
        --     override_file_sorter    = false,
        --     override_generic_sorter = true,
        --     case_mode               = "smart_case",
        -- },
        fzy_native = {
            override_generic_sorter = true,
            override_file_sorter = true,
        },
    },
    pickers = {
        buffers = {
            sort_lastused = true,
            mappings = {
                i = {
                    ["<c-d>"] = require("telescope.actions").delete_buffer,
                },
                n = {
                    ["<c-d>"] = require("telescope.actions").delete_buffer,
                },
            },
        },
    },
}
-- telescope.load_extension('fzf')
telescope.load_extension('fzy_native')
