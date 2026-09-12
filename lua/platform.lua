-- Platform-specific utilities for cross-platform compatibility
local M = {}

-- Get the OS path separator
M.sep = package.config:sub(1,1)

-- Check if running on Windows
M.is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

-- Get home directory
M.home = M.is_windows and (os.getenv("USERPROFILE") or os.getenv("HOME")) or os.getenv("HOME")

-- Join paths with proper separator
function M.join(...)
    local parts = {...}
    return table.concat(parts, M.sep)
end

-- Convert Unix path to OS-specific path
function M.normalize(path)
    if M.is_windows then
        return path:gsub("/", "\\")
    else
        return path
    end
end

-- Get executable extension
M.exe = M.is_windows and ".exe" or ""

-- Get script extension
M.script_ext = M.is_windows and ".cmd" or ""

-- Check if a command exists
function M.has_command(cmd)
    if M.is_windows then
        local where_cmd = "where " .. cmd .. " 2>nul"
        local handle = io.popen(where_cmd)
        if handle then
            local result = handle:read("*a")
            handle:close()
            return result ~= ""
        end
    else
        return vim.fn.executable(cmd) == 1
    end
    return false
end

return M