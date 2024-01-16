vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("i", "<S-TAB>", "<C-d>")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Go to netrw directory listing" })

local toggle_modes = { "n", "t" }

vim.keymap.set(toggle_modes, "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "Move to split pane left" })
vim.keymap.set(toggle_modes, "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "Move to split pane down" })
vim.keymap.set(toggle_modes, "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "Move to split pane up" })
vim.keymap.set(toggle_modes, "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "Move to split pane right" })

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

vim.keymap.set("n", "<leader>sf", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace current word" })

vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "Lazy Git" })
vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diff View Open" })
vim.keymap.set("n", "<leader>gc", "<cmd>LazyGitFilterCurrentFile<cr>", { desc = "Lazy Git File" })
