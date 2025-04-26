vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("i", "<S-TAB>", "<C-d>")

-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Go to netrw directory listing" })
vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "(OIL) Go to directory listing" })

vim.keymap.set("n", "U", vim.cmd.redo, { desc = "Redo" })
vim.keymap.set("v", "U", vim.cmd.redo, { desc = "Redo" })

-- Comementing these lines out because the vim-tmux-navigator plugin 
-- adds it them automatically

-- local toggle_modes = { "n", "t" }

-- vim.keymap.set(toggle_modes, "<C-h>", "<C-w>h", { desc = "Move to split pane left" })
-- vim.keymap.set(toggle_modes, "<C-j>", "<C-w>j", { desc = "Move to split pane down" })
-- vim.keymap.set(toggle_modes, "<C-k>", "<C-w>k", { desc = "Move to split pane up" })
-- vim.keymap.set(toggle_modes, "<C-l>", "<C-w>l", { desc = "Move to split pane right" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half Page Down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half Page Up" })
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste without overwriting yank'd text
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without overrwriting yank register" })

-- yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard (\"+y)" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy to system clipboard (\"+Y)" })
vim.keymap.set("n", "<leader>P", [["+P]], { desc = "Paste from system clipboard (\"+P)" })

-- delete to void register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to void register" })

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "][", "<C-o>", { desc = "Jump List: Backward" })
vim.keymap.set("n", "[]", "<C-i>", { desc = "Jump List: Forward" })
