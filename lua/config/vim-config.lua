-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.hl.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- Enable break indent
vim.o.breakindent = true

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

if vim.fn.has("termguicolors") == 1 then
    vim.opt.termguicolors = true
end

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

vim.opt.colorcolumn = "100"

vim.wo.signcolumn = 'yes'

vim.o.completeopt = 'menuone,noselect'

vim.g.netrw_sort_sequence = "[\\/]$,*"

vim.g.no_python_maps = 1  -- must be set before ftplugin loads

-- Enable spellcheck
vim.opt.spell = true
vim.opt.spelllang = { 'en_us' }
vim.opt.spellsuggest = 'best,9'

vim.opt.cursorline = false
vim.opt.cursorcolumn = false

-- vim.o.statusline =
--     "(%{get(b:,'gitsigns_head','')})" ..
--     " %f" ..
--     " %m%r" ..
--     "%=" ..
--     " %p%%" ..
--     " %l:%c "
