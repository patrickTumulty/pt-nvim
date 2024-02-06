return {
    {
        'NTBBloodbath/doom-one.nvim',
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
    },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
    },
    { "nyoom-engineering/oxocarbon.nvim" },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = true 
    },
    {
        "briones-gabriel/darcula-solid.nvim",
        dependencies = "rktjmp/lush.nvim",
        config = function()
            vim.cmd("colorscheme darcula-solid")
        end,
    }
}
