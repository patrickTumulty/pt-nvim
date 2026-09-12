vim.pack.add({ "https://github.com/sainnhe/gruvbox-material" })

-- Use global variables for configuration
vim.g.gruvbox_material_background = 'hard'
vim.g.gruvbox_material_foreground = 'material' -- options: material, mix, original

-- Load the colorscheme
vim.cmd.colorscheme('gruvbox-material')
