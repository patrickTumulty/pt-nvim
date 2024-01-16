return {
    { 'mbbill/undotree', },
    {
        'christoomey/vim-tmux-navigator',
        lazy = false
    },
    -- Git related plugins
    { 'tpope/vim-fugitive' },
    { 'tpope/vim-rhubarb' },
    {
        'kdheepak/lazygit.nvim',



        dependencies = {
            'nvim-lua/plenary.nvim',
        },
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        opts = {} -- this is equalent to setup({}) function
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
                icons_enabled = false,
                theme = 'onedark',
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
}
