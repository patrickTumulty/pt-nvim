return {
    'numToStr/Comment.nvim',
    config = function()
        local comment = require("Comment")

        comment.setup({
            opleader = {
                ---Line-comment keymap
                line = '<leader>/',
                ---Block-comment keymap
                block = '<leader>.',
            },
        })
    end,
}
