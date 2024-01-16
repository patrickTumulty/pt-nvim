return {
    'Civitasv/cmake-tools.nvim',
    config = function()
        vim.keymap.set("n", "<leader>mb", "<cmd>CMakeBuild<cr>", { desc = "CMake Build" })
        vim.keymap.set("n", "<leader>mr", "<cmd>CMakeRun<cr>", { desc = "CMake Run" })
        vim.keymap.set("n", "<leader>mg", "<cmd>CMakeGenerate<cr>", { desc = "CMake Generate" })
    end,
}
