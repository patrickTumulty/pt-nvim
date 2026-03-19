return {
    { "sindrets/diffview.nvim" },
    { 'tpope/vim-fugitive' },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration
            "nvim-telescope/telescope.nvim", -- optional
        },
        config = true,
        init = function()
            -- see git_open.lua
            -- vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Neogit: [G]it" })
            vim.keymap.set("n", "<leader>do", "<cmd>DiffviewOpen<cr>", { desc = "Diffview: [D]iffview [O]pen" })
            vim.keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<cr>", { desc = "Diffview: [D]iffview [C]lose" })
            vim.keymap.set("n", "<leader>dh", "<cmd>DiffviewFileHistory %<cr>",
                { desc = "Diffview: [D]iffview Current File [H]istory" })

            local function diff_current_file_with_branch()
                local builtin = require('telescope.builtin')
                local actions = require('telescope.actions')
                local action_state = require('telescope.actions.state')

                builtin.git_branches({
                    attach_mappings = function(prompt_bufnr, _)
                        -- Override the select action (usually <CR>)
                        actions.select_default:replace(function()
                            -- Close the picker
                            actions.close(prompt_bufnr)

                            -- Get the selected branch name
                            local selection = action_state.get_selected_entry()
                            local branch = selection.value

                            -- Execute the Diffview command
                            -- Result: :DiffviewOpen <branch> -- %
                            vim.cmd("DiffviewOpen " .. branch .. " -- %")
                        end)
                        return true
                    end,
                })
            end

            -- Example Keymap
            vim.keymap.set('n', '<leader>df', diff_current_file_with_branch, { desc = 'Diffview: [D]iffview Compare [F]ile with Branch' })
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            local gs = require("gitsigns")

            gs.setup {
                signs = {
                    add = { text = '┃' },
                    change = { text = '┃' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '~' },
                },
                on_attach = function(bufnr)
                    local function map(mode, l, r, desc, opts)
                        local opt = opts or {}
                        opt.buffer = bufnr
                        if (desc ~= nil)
                        then
                            opt.desc = desc
                        end
                        vim.keymap.set(mode, l, r, opt)
                    end

                    map('n', '<leader>hn', function()
                        if vim.wo.diff then return 'h]' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, "[H]unk [N]ext", { expr = true })

                    map('n', '<leader>hp', function()
                        if vim.wo.diff then return 'h[' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, "[H]unk [P]rev", { expr = true })


                    map('n', '<leader>hp', gs.preview_hunk, '[H]unk [P]review')
                    map('n', '<leader>hr', gs.reset_hunk, "[H]unk [R]eset")
                    map('n', '<leader>hR', gs.reset_buffer, "Reset Buffer")
                    map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                        "[H]unk [R]eset")
                    map('n', '<leader>gb', gs.blame_line, "[G]it [B]lame")
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', "Select Hunk")
                end,

            }
        end,
    }
}
