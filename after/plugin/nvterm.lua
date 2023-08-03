local nvterm = require("nvterm")

nvterm.setup()

local terminal = require("nvterm.terminal")

local toggle_modes = { "n", "t" }

vim.keymap.set(toggle_modes, "<c-t>", function()
    terminal.toggle("horizontal")
end, { desc = "Toggle Terminal Horizontal" })

vim.keymap.set(toggle_modes, "<c-f>", function()
    terminal.toggle("float")
end, { desc = "Toggle Terminal Float" })
