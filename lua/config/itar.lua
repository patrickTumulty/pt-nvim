vim.keymap.set("n", "<leader>hi", function()
    local header = {
        "/******************************************************************************",
        " * ITAR CONTROLLED DATA NOTICE",
        " *",
        " * This software contains technical data controlled under the International",
        " * Traffic in Arms Regulations (ITAR), 22 CFR Parts 120–130.",
        " *",
        " * Export, re-export, or disclosure to foreign persons without prior",
        " * authorization from the U.S. Department of State is prohibited.",
        " *",
        " * Access is restricted to U.S. persons or authorized individuals only.",
        " ******************************************************************************/",
        "",
    }
    vim.api.nvim_buf_set_lines(0, 0, 0, false, header)
end, { desc = "Add header: ITAR" })
