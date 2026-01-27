return {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = 'v1.*',
    opts = {
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
        }
    }
}
