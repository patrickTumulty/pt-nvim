vim.loader.enable()

_G.utils = require("utils")

require("config.vim-config")
require("config.remap")
require("config.itar")
require("config.template")
require("config.xdotool")
require("config.pack")

-- vim.fs.dir yields entries in filesystem order, so sort for a deterministic load order
local plugin_files = {}
for name, type in vim.fs.dir(vim.fn.stdpath("config") .. utils.sep .. "lua" .. utils.sep .. "plugins") do
    if type == "file" and name:match("%.lua$") then
        table.insert(plugin_files, name)
    end
end
table.sort(plugin_files)
for _, name in ipairs(plugin_files) do
    require("plugins." .. name:gsub("%.lua$", ""))
end

require("config.lsp-setup")
