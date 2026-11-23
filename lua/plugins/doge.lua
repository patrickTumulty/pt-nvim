-- Must be set before the plugin loads; its default <Leader>d mapping clashes with the <leader>d* group
vim.g.doge_enable_mappings = 0
vim.pack.add({ "https://github.com/kkoomen/vim-doge" })

vim.keymap.set('n', '<Leader>dg', '<Plug>(doge-generate)')
