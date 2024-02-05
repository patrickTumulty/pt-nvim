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
        config = function()
            vim.cmd("colorscheme catppuccin-macchiato")
            return true
        end,
    }
}
