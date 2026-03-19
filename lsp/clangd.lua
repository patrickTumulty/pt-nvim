-- sudo wget https://github.com/clangd/clangd/releases/download/19.1.2/clangd-linux-19.1.2.zip
-- Then moved directory to .local/lsp and renamed to clangd
--
return {
    cmd = { utils.mason_bin_path("clangd"),
        '--background-index',
        "--query-driver=/usr/bin/g++*,/usr/bin/gcc*,/opt/nos/sysroots/x86_64-tdsdk-linux/usr/bin/aarch64-oe4t-linux/aarch64-oe4t-linux-g*,"
    },
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
