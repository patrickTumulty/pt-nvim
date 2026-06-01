vim.pack.add({
    "https://github.com/petertriho/nvim-scrollbar",
    "https://github.com/lewis6991/gitsigns.nvim" -- dep
})

if os.getenv("SSH_CLIENT") or os.getenv("SSH_TTY") then
    return
end
require("scrollbar").setup()
require("scrollbar.handlers.gitsigns").setup()
