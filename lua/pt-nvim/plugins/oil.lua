return {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup({
            view_options = {
                show_hidden = true,
                is_hidden_file = function(name, bufnr)
                    return vim.startswith(name, ".")
                end,
            },
            -- EXPERIMENTAL support for performing file operations with git
            git = {
                -- Return true to automatically git add/mv/rm files
                add = function(path)
                    return true
                end,
                mv = function(src_path, dest_path)
                    return true
                end,
                rm = function(path)
                    return true
                end,
            },
        })
    end
}
