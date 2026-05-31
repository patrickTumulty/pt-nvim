vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == 'blink.cmp' and kind == 'update' then
            if not ev.data.active then vim.cmd.packadd('blink.cmp') end
            vim.cmd('cargo build --release')
        end
    end
})

vim.pack.add({
    "https://github.com/saghen/blink.cmp",
    "https://github.com/rafamadriz/friendly-snippets", -- dep
})

local function load_and_setup_blink()
    -- ensure companion lib is available and add both packages to runtime
    pcall(vim.cmd, 'packadd blink.lib')
    pcall(vim.cmd, 'packadd blink.cmp')

    local ok, blink = pcall(require, 'blink.cmp')
    if not ok or not blink then
        vim.notify('blink.cmp not available; setup skipped', vim.log.levels.WARN)
        return
    end

    if blink.setup then
        blink.setup({
            keymap = {
                preset = "default",
                ["<CR>"] = { "accept", "fallback" },
            },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono",
            },

            signature = {
                enabled = true,
            },

            completion = {
                list = {
                    selection = {
                        preselect = true,
                        auto_insert = true,
                    },
                },
            },
        })
    end
end

load_and_setup_blink()
