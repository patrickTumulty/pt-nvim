local M = {}

function M.mason_bin_path(lsp)
    local home = vim.fn.stdpath("data")     -- typically ~/.local/share/nvim
    local path = home .. "/mason/bin/"
    return path .. lsp
end

function M.file_exists(path)
    local stat = vim.loop.fs_stat(path)
    return stat ~= nil
end

return M

