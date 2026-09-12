vim.pack.add({ "https://github.com/numtostr/comment.nvim" })

local comment = require("Comment")

comment.setup({
    opleader = {
        ---Line-comment keymap
        line = '<leader>/',
        ---Block-comment keymap
        block = '<leader>.',
    },
})
