return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require('telescope.builtin')

        -- Enable telescope fzf native, if installed
        pcall(require('telescope').load_extension, 'fzf')
        vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = 'Telescope: [?] Find recently opened files' })
        vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = 'Telescope: [ ] Find existing buffers' })
        vim.keymap.set('n', '<leader>/', function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end, { desc = 'Telescope: [/] Fuzzily search in current buffer' })

        require("telescope").setup({
            pickers = {
                find_files = {
                    hidden = true
                }
            },
            defaults = {
                layout_strategy = "vertical",
                layout_config = {
                    vertical = { width = 0.7 }
                }
            }
        })

        vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Telescope: Search [G]it [F]iles' })
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope: [F]ind [F]iles' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope: [F]ind [H]elp' })
        vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Telescope: [F]ind current [W]ord' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope: [F]ind by [G]rep' })
        vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Telescope: [F]ind [D]iagnostics' })
        vim.keymap.set('n', '<leader>bh', builtin.git_bcommits, { desc = 'Telescope: [B]uffer Git [H]istory' })
        vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Telescope: [G]it [S]tatus' })
        vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Telescope: [G]it [S]tatus' })
        vim.keymap.set('n', '<leader>fs', builtin.treesitter, { desc = 'Telescope: [F]ind [S]ymbols' })
    end,
}
