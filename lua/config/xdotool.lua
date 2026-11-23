-- xdotool is X11-only
if utils.is_windows() or vim.fn.executable("xdotool") == 0 then
    return
end

local function xdotool(args, on_exit)
    vim.system(vim.list_extend({ "xdotool" }, args), { text = true }, on_exit)
end

-- Focus the browser window showing this page, press F5, then refocus nvim.
local function refresh_page(title)
    xdotool({ "getactivewindow" }, function(active)
        local nvim_window_id = vim.trim(active.stdout or "")
        xdotool({ "search", "--onlyvisible", "--name", title, "windowactivate", "--sync", "key", "F5" }, function(search)
            if search.code ~= 0 or nvim_window_id == "" then
                return
            end
            xdotool({ "windowactivate", nvim_window_id })
        end)
    end)
end

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.html",
    callback = function()
        -- The <title> is assumed to be near the top of the file; it's how we find the browser window.
        local head = vim.fn.getline(1, math.min(20, vim.fn.line("$")))
        local title = table.concat(head, "\n"):match("<title>(.-)</title>")

        if not title then
            return
        end

        refresh_page(title)
    end
})
