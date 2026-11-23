vim.pack.add { { src = utils.gh 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' } }
require('luasnip').setup {}

vim.pack.add({
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range('1.*') }
})

require("blink.cmp").setup({
    keymap = {
        preset = 'default',
        ['<CR>'] = { 'accept', 'fallback' },

    },
    -- completion.list.selection = { preselect = true, auto_insert = true },
    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
    },
    signature = { enabled = true },
    completion = {
        list = {
            selection = {
                preselect = true,
                auto_insert = true
            },
        },
    },
    sources = {
        default = { 'lsp', 'path', 'snippets' },
    },
    fuzzy = { implementation = 'lua' },
})
