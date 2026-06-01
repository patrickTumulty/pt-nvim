vim.pack.add({
    "https://github.com/akinsho/bufferline.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons" -- dep
})

local bufferline = require("bufferline")

bufferline.setup {
    options = {
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
            local icon = level:match("error") and '💩' or '😮'
            return " " .. icon .. count
        end
    },
}

vim.keymap.set("n", "<leader>bj", "<cmd>BufferLinePick<cr>", { desc = "[B]uffer [J]ump" })
vim.keymap.set("n", "<leader>bc", "<cmd>BufferLinePickClose<cr>", { desc = "Select [B]uffer to [C]lose" })
vim.keymap.set("n", "<leader>bb", "<cmd>BufferLineCyclePrev<cr>", { desc = "Buffer [B]ack" })
vim.keymap.set("n", "<leader>bn", "<cmd>BufferLineCycleNext<cr>", { desc = "Buffer [N]ext" })
vim.keymap.set("n", "<leader>ba", "<cmd>BufferLineCloseOthers<cr>", { desc = "[B]uffer [A]ll Other Buffers" })

bufferline.setup()
