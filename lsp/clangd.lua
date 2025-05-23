-- sudo wget https://github.com/clangd/clangd/releases/download/19.1.2/clangd-linux-19.1.2.zip
-- Then moved directory to .local/lsp and renamed to clangd
--

return {
    cmd = { 'clangd', '--background-index' },
    root_markers = { 'compile_commands.json', 'compile_flags.txt' },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
    single_file_support = true,
    capabilities = {
        textDocument = {
            completion = {
                editsNearCursor = true,
            },
        },
        offsetEncoding = { 'utf-8', 'utf-16' },
    },
}
