local comment = require("Comment")

comment.setup({
    opleader = {
        ---Line-comment keymap
        line = '<leader>/',
        ---Block-comment keymap
        block = '<leader>.',
    },
})
