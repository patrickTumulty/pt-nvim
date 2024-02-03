return {
    "kwkarlwang/bufjump.nvim",
    config = function()
        require("bufjump").setup({
            forward = "[]",
            backward = "][",
            on_success = function()
                vim.cmd([[execute "normal! g`\"zz"]])
            end,
        })
    end,
}
