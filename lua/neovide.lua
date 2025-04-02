if vim.g.neovide then
    vim.o.guifont = "JetBRainsMono Nerd Font:h14"
    vim.g.neovide_cursor_vfx_mode = "railgun"
    vim.keymap.set('v', '<D-c>', '"+y')         -- Copy
    vim.keymap.set('n', '<D-v>', '"+P')         -- Paste normal mode
    vim.keymap.set('v', '<D-v>', '"+P')         -- Paste visual mode
    vim.keymap.set('c', '<D-v>', '<C-R>+')      -- Paste command mode
    vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
end
