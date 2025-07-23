-- npm install -g typescript-language-server typescript

-- sudo snap install typescript-language-server

local home = vim.fn.stdpath("data")     -- typically ~/.local/share/nvim
local path = home .. "/mason/bin/"
return {
    cmd = { path .. 'typescript-language-server', '--stdio' },
    filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
    },
    root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
    single_file_support = true
}
