-- local dap = require("dap")
-- local dap_ui = require("dapui")
-- local dap_ui_widgets = require('dap.ui.widgets')
--
-- -- Keymaps
-- vim.keymap.set("n", "<leader>bp", function() dap.toggle_breakpoint() end, { desc = "Toggle [B]reak[p]oint" })
-- vim.keymap.set("n", "<leader>du", function() dap_ui.toggle() end, { desc = "Toggle [D]ebug [U]I" })
-- vim.keymap.set("n", "<leader>ds", function() dap.continue() end, { desc = "Debug: [S]tart" })
-- vim.keymap.set("n", "<leader>di", function() dap.step_into() end, { desc = "Debug: [S]tep [I]nto" })
-- vim.keymap.set("n", "<leader>dn", function() dap.step_over() end, { desc = "Debug: [S]tep Over" })
-- vim.keymap.set("n", "<leader>dp", function() dap.step_out() end, { desc = "Debug: [S]tep Out" })
-- vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function() dap_ui_widgets.hover() end, { desc = "Debug: [H]over" })
-- vim.keymap.set('n', '<Leader>dl', function() dap_ui_widgets.centered_float(dap_ui_widgets.scopes) end, { desc = 'Debug: Scopes'})
--
-- -- codelldb config
-- local codelldb_port = "65472"
--
-- dap.adapters.codelldb = {
--     type = 'server',
--     port = codelldb_port,                                                             -- May need to change
--     executable = {
--         command = os.getenv("HOME") .. "/" .. ".local/share/nvim/mason/bin/codelldb", -- install with mason
--         args = { "--port", codelldb_port }
--     },
--     name = "codelldb"
-- }
--
-- local codelldb = {
--     name = "Launch file",
--     type = "codelldb",
--     request = "launch",
--     program = function()
--         return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--     end,
--     cwd = '${workspaceFolder}',
--     stopOnEntry = false,
--     args = function()
--         local input = vim.fn.input("Input Args: ")
--         return vim.fn.split(input, " ", true)
--     end,
--     runInTerminal = false
-- }
--
-- dap.configurations.rust = { codelldb }
-- dap.configurations.c = { codelldb }
-- dap.configurations.cpp = { codelldb }
--
--
-- dap.adapters.coreclr = {
--     type = 'executable',
--     command = os.getenv("HOME") .. "/" .. '.local/share/nvim/mason/bin/netcoredbg',
--     args = { '--interpreter=vscode' }
-- }
--
-- local coreclr = {
--     type = "coreclr",
--     name = "launch - netcoredbg",
--     request = "launch",
--     program = function()
--         return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
--     end,
-- }
--
-- dap.configurations.cs = { coreclr }
--
-- dap.listeners.before.attach.dapui_config = function()
--     dap_ui.open()
-- end
-- dap.listeners.before.launch.dapui_config = function()
--     dap_ui.open()
-- end
-- dap.listeners.before.event_terminated.dapui_config = function()
--     dap_ui.close()
-- end
-- dap.listeners.before.event_exited.dapui_config = function()
--     dap_ui.close()
-- end
--
-- dap_ui.setup()
--
-- vim.fn.sign_define('DapBreakpoint', { text = '🔴' })
