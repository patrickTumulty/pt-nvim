vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("i", "<S-TAB>", "<C-d>")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Go to netrw directory listing" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste without overwriting yank'd text
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without overrwriting yank register" })

-- yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard (\"+y)" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy to system clipboard (\"+Y)" })

-- delete to void register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to void register" })

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, { desc = "LSP Format" })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>sf", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace current word" })
