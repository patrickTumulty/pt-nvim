local function is_xdotool_installed()
    local handle = io.popen("command -v xdotool")
    if handle == nil then
        return false
    end
    local result = handle:read("*a")
    handle:close()
    return result ~= ""
end

-- Get the current active window and store that in tmp file
local nvim_window_id_cmd = "xdotool getactivewindow > /tmp/nvim_window_id"
-- Use stored window id to refocus the window
local refocus_nvim_cmd = "xdotool windowactivate $(cat /tmp/nvim_window_id)"

local function refresh_page(title)
    local refresh_cmd = string.format("xdotool search --onlyvisible --name '%s' windowactivate --sync key F5", title)

    local command = string.format("silent! !%s && %s && %s", nvim_window_id_cmd, refresh_cmd,
        refocus_nvim_cmd)

    vim.api.nvim_command(command)
end


if is_xdotool_installed() then
    return
end

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.html",
    callback = function()
        -- [[
        -- We are getting the first 20 lines of HTML and parsing
        -- out the title. Once we have that information, we can
        -- use xdotool to refresh that webpage if it is open.
        -- ]]
        local content = vim.fn.getline(1, math.min(20, vim.fn.line("$")))
        local full_conent = table.concat(content, "\n")
        local title = full_conent:match("<title>(.-)</title>")

        if not title then
            return
        end

        refresh_page(title)
    end
})
