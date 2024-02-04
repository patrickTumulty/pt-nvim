local dap = require("dap")
local dap_ui = require("dapui")

-- Keymaps
vim.keymap.set("n", "<leader>bp", function() dap.toggle_breakpoint() end, { desc = "Toggle [B]reak[p]oint" })
vim.keymap.set("n", "<leader>du", function() dap.toggle_breakpoint() end, { desc = "Toggle [D]ebug [U]I" })
vim.keymap.set("n", "<F2>", function() dap.continue() end, { desc = "Debug: Start" })
vim.keymap.set("n", "<F3>", function() dap.step_into() end, { desc = "Debug: Step Into" })
vim.keymap.set("n", "<F4>", function() dap.step_over() end, { desc = "Debug: Step Over" })
vim.keymap.set("n", "<F5>", function() dap.step_out() end, { desc = "Debug: Step Out" })

-- codelldb config
local codelldb_port = "65472"

dap.adapters.codelldb = {
    type = 'server',
    port = codelldb_port,                                                             -- May need to change
    executable = {
        command = os.getenv("HOME") .. "/" .. ".local/share/nvim/mason/bin/codelldb", -- install with mason
        args = { "--port", codelldb_port }
    },
    name = "codelldb"
}

local codelldb = {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = function()
        local input = vim.fn.input("Input Args: ")
        return vim.fn.split(input, " ", true)
    end,
    runInTerminal = false
}

dap.configurations.rust = { codelldb }
dap.configurations.c = { codelldb }
dap.configurations.cpp = { codelldb }


dap_ui.setup()

vim.fn.sign_define('DapBreakpoint', { text = '🔴' })
