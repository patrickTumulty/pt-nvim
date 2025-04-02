return {
    "kkoomen/vim-doge",
    config = function()
        vim.keymap.set('n', '<Leader>dg', '<Plug>(doge-generate)')
        -- vim.cmd("call doge#install()")
    end
}
