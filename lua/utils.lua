local M = {}

function M.mason_bin_path(lsp)
    local home = vim.fn.stdpath("data") -- typically ~/.local/share/nvim
    local path = home .. "/mason/bin/"
    return path .. lsp
end

function M.file_exists(path)
    if path == nil then
        return false
    end
    local stat = vim.loop.fs_stat(path)
    return stat ~= nil
end

function M.program_exists(cmd)
    return vim.fn.executable(cmd) == 1
end

function M.run_build(name, cmd, cwd)
    local result = vim.system(cmd, { cwd = cwd }):wait()
    if result.code ~= 0 then
        local stderr = result.stderr or ''
        local stdout = result.stdout or ''
        local output = stderr ~= '' and stderr or stdout
        if output == '' then output = 'No output from build command.' end
        vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
    end
end

function M.gh(repo)
    return 'https://github.com/' .. repo
end

return M
