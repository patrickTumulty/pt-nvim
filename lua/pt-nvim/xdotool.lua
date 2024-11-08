local function is_xdotool_installed()
    local handle = io.popen("command -v xdotool")
    if handle == nil then
        return false
    end
    local result = handle:read("*a")
    handle:close()
    return result ~= ""
end

local browser = "chrome" -- or 'firefox'

-- Get the current active window and store that in tmp file
local nvim_window_id_cmd = "xdotool getactivewindow > /tmp/nvim_window_id"
-- Refresh browser
local browser_refresh_cmd = string.format("xdotool search --onlyvisible --class '%s' windowactivate --sync key F5", browser)
-- Use stored window id to refocus the window
local refocus_nvim_cmd = "xdotool windowactivate $(cat /tmp/nvim_window_id)"

if is_xdotool_installed() then
    vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*.html",
        command = string.format("silent! !%s && %s && %s", nvim_window_id_cmd, browser_refresh_cmd, refocus_nvim_cmd)
    })
end
