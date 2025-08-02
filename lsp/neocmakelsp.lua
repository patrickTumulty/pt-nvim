-- cargo install neocmakelsp

return {
    cmd = { utils.mason_bin_path('neocmakelsp'), '--stdio' },
    root_markers = { '.git', 'build', 'cmake' },
    filetypes = { 'cmake' }
}
