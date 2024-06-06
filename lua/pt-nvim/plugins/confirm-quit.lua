return {
    "yutkat/confirm-quit.nvim",
    event = "CmdlineEnter",
    opts = {
        overwrite_q_command = true, -- Replaces :q and :qa with :ConfirmQuit and :ConfirmQuitAll
    },
}
