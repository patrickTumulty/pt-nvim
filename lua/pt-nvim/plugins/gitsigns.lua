return {
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

                map('n', 'h]', function()
                    if vim.wo.diff then return 'h]' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, "Hunk Next", { expr = true })

                map('n', 'h[', function()
                    if vim.wo.diff then return 'h[' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, "Previous Hunk", { expr = true })


                map('n', '<leader>hp', gs.preview_hunk, '[H]unk [P]review')
                map('n', '<leader>hr', gs.reset_hunk, "[H]unk [R]eset")
                map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, "[H]unk [R]eset")
                map('n', '<leader>gb', gs.blame_line, "[G]it [B]lame")
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', "Select Hunk")
            end,

        }
    end,
}
