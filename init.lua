_G.utils = require("utils")

require("config.vim-config")
require("config.remap")
require("config.itar")
require("config.template")
require("config.xdotool")

for name, type in vim.fs.dir(vim.fn.stdpath("config") .. "/lua/plugins") do
    if type == "file" and name:match("%.lua$") then
        local module = "plugins." .. name:gsub("%.lua$", "")
        require(module)
    end
end

require("config.lsp-setup")
