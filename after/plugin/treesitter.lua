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
        "markdown"
    },
    auto_install = true,
    highlight = {
        enable = true
    },
    indent = {
        enable = true
    },
})
