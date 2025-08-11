-- MacOS
-- brew install lua-language-server

-- Linux
-- Download From Github: https://github.com/LuaLS/lua-language-server/releases
-- Untar and copy contents into ~/.local/lsp/luals

return {
    cmd = { utils.mason_bin_path('lua-language-server') },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            signatureHelp = { enabled = true },
        },
    },
}
