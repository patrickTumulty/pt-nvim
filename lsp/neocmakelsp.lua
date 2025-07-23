-- cargo install neocmakelsp

local home = vim.fn.stdpath("data") -- typically ~/.local/share/nvim
local path = home .. "/mason/bin/"
return {
    cmd = { path .. 'neocmakelsp', '--stdio' },
    root_markers = { '.git', 'build', 'cmake' },
    filetypes = { 'cmake' }
}
