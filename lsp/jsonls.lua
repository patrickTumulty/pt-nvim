-- npm install --save vscode-json-languageservice

-- sudo snap install vscode-json-languageserver

local home = vim.fn.stdpath("data")     -- typically ~/.local/share/nvim
local path = home .. "/mason/bin/"
return {
    cmd = { path .. 'vscode-json-language-server', '--stdio' },
    filetypes = { 'json', 'jsonc' },
    root_markers = { '.git' },
    single_file_support = true,
    init_options = {
        provideFormatter = true,
    }
}
