return {
    -- {
    --     'NTBBloodbath/doom-one.nvim',
    -- },
    -- { "nyoom-engineering/oxocarbon.nvim" },
    -- {
    --     "catppuccin/nvim",
    --     name = "catppuccin",
    --     priority = 1000,
    --     -- config = function()
    --     --     require("catppuccin").setup({
    --     --         no_italic = true, -- Force no italic
    --     --     })
    --     --     vim.cmd("colorscheme catppuccin-macchiato")
    --     -- end,
    -- },
    -- {
    --     "briones-gabriel/darcula-solid.nvim",
    --     dependencies = "rktjmp/lush.nvim",
    -- },
    -- {
    --     'navarasu/onedark.nvim',
    --     -- config = function()
    --     --     require("onedark").setup({
    --     --         style = "warm"
    --     --     })
    --     --     vim.cmd("colorscheme onedark")
    --     -- end,
    -- },
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        config = function()
            vim.cmd("colorscheme gruvbox-material")
        end,
    }
}
