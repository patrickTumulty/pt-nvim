-- MacOS
-- brew install lua-language-server

-- Linux
-- Download From Github: https://github.com/LuaLS/lua-language-server/releases
-- Untar and copy contents into ~/.local/lsp/luals
return {
    cmd = { 'lua-language-server' },
    filetypes = {'lua'},
    root_markers = { '.luarc.json', '.luarc.jsonc' },
}
