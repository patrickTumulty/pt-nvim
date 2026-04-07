-- sudo wget https://github.com/clangd/clangd/releases/download/19.1.2/clangd-linux-19.1.2.zip
-- Then moved directory to .local/lsp and renamed to clangd


local home = os.getenv("HOME")

local drivers = {
    home .. "/.espressif/tools/**/bin/*gcc",
    "/usr/bin/*gcc",
    "/usr/bin/*g++",
    "/opt/nos/sysroots/**/bin/*gcc",
    "/opt/nos/sysroots/**/bin/*g++",
}

return {
    cmd = {
        utils.mason_bin_path("clangd"),
        "--background-index",
        "--query-driver=" .. table.concat(drivers, ",")
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
