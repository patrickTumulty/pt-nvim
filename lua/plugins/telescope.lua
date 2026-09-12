vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name = ev.data.spec.name
        local kind = ev.data.kind

        if kind ~= 'install' and kind ~= 'update' then
            return
        end

        if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
            utils.run_build(name, { 'make' }, ev.data.path)
            return
        end
    end
})

local telescope_plugins = {
    utils.gh 'nvim-lua/plenary.nvim',
    utils.gh 'nvim-telescope/telescope.nvim',
    utils.gh 'nvim-telescope/telescope-ui-select.nvim',
}
if vim.fn.executable 'make' == 1 then
    table.insert(telescope_plugins, utils.gh 'nvim-telescope/telescope-fzf-native.nvim')
end

vim.pack.add(telescope_plugins)

local builtin = require('telescope.builtin')

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = 'Telescope: [?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = 'Telescope: [ ] Find existing buffers' })
vim.keymap.set('n', '<leader>fc', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = 'Telescope: [F]uzzily search in [c]urrent buffer' })

require("telescope").setup({
    pickers = {
        find_files = {
            hidden = true
        },
        lsp_document_symbols = {
            symbol_width = 50, -- Increase this number (default is usually 25)
            show_line = true,  -- Optional: shows the line number
        },
    },
    extensions = {
        ['ui-select'] = { require('telescope.themes').get_dropdown() },
    },
    defaults = {
        layout_strategy = "vertical",
        layout_config = {
            vertical = { width = 0.7 },
            preview_cutoff = 1
        },
        path_display = { "smart" },
    }
})

vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Telescope: Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope: [F]ind [F]iles' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope: [F]ind [H]elp' })
vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Telescope: [F]ind current [W]ord' })
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope: [F]ind by [G]rep' }) -- See multigrep.lua
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Telescope: [F]ind [D]iagnostics' })
vim.keymap.set('n', '<leader>bh', builtin.git_bcommits, { desc = 'Telescope: [B]uffer Git [H]istory' })
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Telescope: [G]it [S]tatus' })

require("config.multigrep").setup()
