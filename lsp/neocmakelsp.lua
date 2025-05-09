 -- cargo install neocmakelsp

return {
    cmd = { 'neocmakelsp', '--stdio' },
    root_markers = { '.git', 'build', 'cmake' },
    filetypes = { 'cmake' }
}
