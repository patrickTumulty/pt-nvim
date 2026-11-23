local function opts(desc)
    return { noremap = true, silent = true, desc = desc }
end

local function set_dark_mode(dark_mode)
    if dark_mode then
    vim.cmd(":set background=dark")
    else
    vim.cmd(":set background=light")
    end
end

vim.keymap.set("n", "<leader>td", function() set_dark_mode(true) end, opts("[T]heme: [D]ark"))
vim.keymap.set("n", "<leader>tl", function() set_dark_mode(false) end, opts("[T]heme: [L]ight"))
