vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function opts(desc)
    return { noremap = true, silent = true, desc = desc }
end

vim.keymap.set("i", "<S-TAB>", "<C-d>", opts())

-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Go to netrw directory listing" })
vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", opts("(OIL) Go to directory listing"))

vim.keymap.set("n", "U", vim.cmd.redo, opts("Redo"))
vim.keymap.set("v", "U", vim.cmd.redo, opts("Redo"))

local toggle_modes = { "n", "t" }

vim.keymap.set(toggle_modes, "<C-h>", "<C-w>h", opts("Move to split pane left"))
vim.keymap.set(toggle_modes, "<C-j>", "<C-w>j", opts("Move to split pane down"))
vim.keymap.set(toggle_modes, "<C-k>", "<C-w>k", opts("Move to split pane up"))
vim.keymap.set(toggle_modes, "<C-l>", "<C-w>l", opts("Move to split pane right"))

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts("Move line down"))
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts("Move line up"))

vim.keymap.set("n", "<C-d>", "<C-d>zz", opts("Half Page Down"))
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts("Half Page Up"))
vim.keymap.set("n", "n", "nzzzv", opts("Next search result"))
vim.keymap.set("n", "N", "Nzzzv", opts("Previous search result"))

-- paste without overwriting yank'd text
vim.keymap.set("x", "<leader>p", [["_dP]], opts("Paste without overrwriting yank register"))

-- yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], opts("Copy to system clipboard"))
vim.keymap.set("n", "<leader>Y", [["+Y]], opts("Copy line to system clipboard"))
vim.keymap.set("n", "<leader>P", [["+P]], opts("Paste from system clipboard"))

-- delete to void register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], opts("Delete to void register"))

vim.keymap.set("n", "Q", "<nop>", opts("Disable Ex mode"))

vim.keymap.set("n", "][", "<C-o>", opts("Jump List: Backward"))
vim.keymap.set("n", "[]", "<C-i>", opts("Jump List: Forward"))
