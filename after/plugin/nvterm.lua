local nvterm = require("nvterm")

nvterm.setup()

local terminal = require("nvterm.terminal")

local toggle_modes = { "n", "t" }

vim.keymap.set(toggle_modes, "<leader>th", function()
    terminal.toggle("horizontal")
end, { desc = "Toggle Terminal Horizontal" })

vim.keymap.set(toggle_modes, "<leader>tv", function()
    terminal.toggle("vertical")
end, { desc = "Toggle Terminal Vertical" })

vim.keymap.set(toggle_modes, "<leader>tf", function()
    terminal.toggle("float")
end, { desc = "Toggle Terminal Float" })
