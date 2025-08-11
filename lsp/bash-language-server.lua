return {
    cmd = { utils.mason_bin_path('bash-language-server'), 'start' },
    filetypes = { 'sh', 'bash' },
    root_markers = { '.git' },
    settings = {
        bashIde = {
            globPattern = "*@(.sh|.inc|.bash|.command)"
        }
    }
}
