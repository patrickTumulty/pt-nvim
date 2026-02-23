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
        priority = 1000,
        config = function()
            -- Use global variables for configuration
            vim.g.gruvbox_material_background = 'hard'
            vim.g.gruvbox_material_foreground = 'material' -- options: material, mix, original

            -- Load the colorscheme
            vim.cmd.colorscheme('gruvbox-material')
        end,
    }
}
