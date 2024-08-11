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
        end,
    },
    {
        "briones-gabriel/darcula-solid.nvim",
        dependencies = "rktjmp/lush.nvim",
    },
    {
        'navarasu/onedark.nvim',
        -- config = function()
        --     require("onedark").setup({
        --         style = "warm"
        --     })
        --     vim.cmd("colorscheme onedark")
        -- end,
    }
}
