return {
    "kkoomen/vim-doge",
    config = function()
        vim.keymap.set('n', '<Leader>dg', '<Plug>(doge-generate)')
    end
}
