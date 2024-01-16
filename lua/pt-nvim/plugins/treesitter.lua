return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    config = function()
        local treesitter = require("nvim-treesitter.configs")

        treesitter.setup({
            ensure_installed = {
                "c",
                "lua",
                "java",
                "rust",
                "python",
                "cmake",
                "cpp",
                "bash",
                "json",
                "kotlin",
                "markdown",
                "typescript",
                "tsx",
                "javascript",
                "html",
                "css"
            },
            auto_install = true,
            highlight = {
                enable = true
            },
            indent = {
                enable = true
            },
            autotag = {
                enabled = true
            }
        })
    end
}
