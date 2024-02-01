return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local nvim_tree = require("nvim-tree")

        nvim_tree.setup {
            vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', { desc = "File [E]xplorer" }),
            vim.keymap.set('n', '<leader>fe', '<cmd>NvimTreeFindFile<cr>', { desc = "File [F]ile in [E]xplorer" })
        }
    end,
}
