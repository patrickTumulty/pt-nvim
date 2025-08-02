-- npm install --save vscode-json-languageservice

-- sudo snap install vscode-json-languageserver

return {
    cmd = { utils.mason_bin_path('vscode-json-language-server'), '--stdio' },
    filetypes = { 'json', 'jsonc' },
    root_markers = { '.git' },
    single_file_support = true,
    init_options = {
        provideFormatter = true,
    }
}
