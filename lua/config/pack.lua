vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.kind == "update" then
            vim.notify("Plugins updated. Run :restart to use the new code.", vim.log.levels.INFO)
        end
    end,
})

-- Opens the built-in review buffer: nothing is applied until `:write`,
-- closing the buffer (or `:quit`) discards everything.
-- Add `!` to skip the review and apply updates immediately.
vim.api.nvim_create_user_command("PackUpdate", function(args)
    vim.pack.update(nil, { force = args.bang })
end, {
    bang = true,
    desc = "[P]ack [U]pdate plugins (review buffer: :write applies, close discards; ! force)",
})

vim.keymap.set("n", "<leader>pu", "<cmd>PackUpdate<cr>", { desc = "[P]ack [U]pdate plugins" })