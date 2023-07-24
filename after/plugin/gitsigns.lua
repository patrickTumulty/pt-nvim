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

        map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, "Hunk Next", { expr = true })

        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, "Previous Hunk", { expr = true })

        map('n', '<leader>hp', gs.preview_hunk, '[H]unk [P]review')
        map('n', '<leader>hs', gs.stage_hunk, "Stage Hunk")
        map('n', '<leader>hr', gs.reset_hunk, "Reset Hunk")
        map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, "Stage Hunk")
        map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, "Reset Hunk")
        map('n', '<leader>hS', gs.stage_buffer, "Stage Buffer")
        map('n', '<leader>hu', gs.undo_stage_hunk, "Undo Stage Hunk")
        map('n', '<leader>hR', gs.reset_buffer, "Reset Buffer")
        map('n', '<leader>hb', function() gs.blame_line { full = true } end, "Blame Line")
        map('n', '<leader>tb', gs.toggle_current_line_blame, "Toggle Current Blame Line")
        map('n', '<leader>hd', gs.diffthis, "Diff This")
        map('n', '<leader>hD', function() gs.diffthis('~') end, "Diff This")
        map('n', '<leader>td', gs.toggle_deleted, "Toggle Deleted")
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', "Select Hunk")
    end,

}
