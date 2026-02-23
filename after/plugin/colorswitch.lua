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

vim.keymap.set("n", "<leader>dm", function() set_dark_mode(true) end, opts("[D]ark [M]ode"))
vim.keymap.set("n", "<leader>lm", function() set_dark_mode(false) end, opts("[L]ark [M]ode"))
