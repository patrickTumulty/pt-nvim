return {
    { 'mbbill/undotree', },
    {
        'christoomey/vim-tmux-navigator',
        lazy = false
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        opts = {} -- this is equalent to setup({}) function
    },
    { "j-hui/fidget.nvim" },
    { 'rcarriga/nvim-notify' },
    { 'rcarriga/nvim-dap-ui' },
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            { "nvim-neotest/nvim-nio" }
        }
    },
    {
        'tzachar/local-highlight.nvim',
        dependencies = {
            { "folke/snacks.nvim" }
        },
        config = function()
            require('local-highlight').setup()
        end

    },
    { 'theHamsta/nvim-dap-virtual-text' },
    { 'nvim-telescope/telescope-dap.nvim' },
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
