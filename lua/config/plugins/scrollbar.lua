return {
    "petertriho/nvim-scrollbar",
    dependencies = {
        "lewis6991/gitsigns.nvim"
    },
    config = function()
        if os.getenv("SSH_CLIENT") or os.getenv("SSH_TTY") then
            return
        end
        require("scrollbar").setup()
        require("scrollbar.handlers.gitsigns").setup()
    end
}
