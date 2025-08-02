return {
    { 'mbbill/undotree', },
    {
        'christoomey/vim-tmux-navigator',
        lazy = false
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        dependencies = { 'hrsh7th/nvim-cmp' },
        config = function()
            require('nvim-autopairs').setup {}
            -- If you want to automatically add `(` after selecting a function or method
            local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
            local cmp = require 'cmp'
            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end,
    },
    { "j-hui/fidget.nvim" },
    { 'rcarriga/nvim-notify' },
    -- { 'rcarriga/nvim-dap-ui' },
    -- {
    --     'mfussenegger/nvim-dap',
    --     dependencies = {
    --         { "nvim-neotest/nvim-nio" }
    --     }
    -- },
    -- { 'theHamsta/nvim-dap-virtual-text' },
    -- { 'nvim-telescope/telescope-dap.nvim' },
    {
        'tzachar/local-highlight.nvim',
        dependencies = {
            {
                "folke/snacks.nvim",
                lazy = false
            }
        },
        config = function()
            require('local-highlight').setup()
            require('snacks').setup()
        end

    },
    {
        'folke/which-key.nvim',
        opts = {}
    },
    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`
        opts = {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = '|',
                section_separators = '',
            },
        },
    },
    {
        "mason-org/mason.nvim",
        opts = {}
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {}
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end,
    },
    {
        'NvChad/nvim-colorizer.lua',
        config = function()
            require("colorizer").setup()
        end
    },
}
