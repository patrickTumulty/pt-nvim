return {
    { "sindrets/diffview.nvim" },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration

            "nvim-telescope/telescope.nvim", -- optional
        },
        config = true,
        init = function()
            vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Neogit: [G]it" })
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
                _signs_staged_enable = true,
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

                    map('n', 'h]', function()
                        if vim.wo.diff then return 'h]' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, "[H]unk Next", { expr = true })

                    map('n', 'h[', function()
                        if vim.wo.diff then return 'h[' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, "[H]unk Prev", { expr = true })


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
