-- sudo wget https://github.com/clangd/clangd/releases/download/19.1.2/clangd-linux-19.1.2.zip
-- Then moved directory to .local/lsp and renamed to clangd


local home = utils.is_windows() and os.getenv("USERPROFILE") or os.getenv("HOME")

local drivers = {}
if utils.is_windows() then
    -- Windows-specific compiler paths
    table.insert(drivers, "C:/msys64/mingw64/bin/*gcc.exe")
    table.insert(drivers, "C:/msys64/mingw64/bin/*g++.exe")
    table.insert(drivers, "C:/mingw64/bin/*gcc.exe")
    table.insert(drivers, "C:/mingw64/bin/*g++.exe")
else
    -- Unix-specific paths
    table.insert(drivers, home .. "/.espressif/tools/**/bin/*gcc")
    table.insert(drivers, "/usr/bin/*gcc")
    table.insert(drivers, "/usr/bin/*g++")
    table.insert(drivers, "/opt/nos/sysroots/x86_64-tdsdk-linux/usr/bin/aarch64-oe4t-linux/aarch64-oe4t-linux-g*")

end

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
