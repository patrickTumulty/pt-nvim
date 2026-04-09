local notify = require("notify")
local is_ssh = os.getenv("SSH_CLIENT") ~= nil or os.getenv("SSH_TTY") ~= nil

if is_ssh then
    notify.setup({ stages = "static" })
end

vim.notify = notify

require("fidget").setup({
    progress = {
        display = {
            render_limit = is_ssh and 0 or 16,
        },
    },
})
