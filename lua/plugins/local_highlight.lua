vim.pack.add({
    "https://github.com/tzachar/local-highlight.nvim",
    "https://github.com/folke/snacks.nvim" -- only used for local-highlight's animation (snacks.animate)
})

require("snacks").setup({})
require('local-highlight').setup()
