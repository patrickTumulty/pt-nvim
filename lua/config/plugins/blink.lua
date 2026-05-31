return {
    {
        'saghen/blink.cmp',
        dependencies = { 'saghen/blink.lib', 'rafamadriz/friendly-snippets' },
        build = function()
            -- Use blink.cmp's installer which returns a promise-like object
            local ok, blink = pcall(require, 'blink.cmp')
            if not ok or not blink or not blink.build then
                vim.notify('blink.cmp build function not available', vim.log.levels.WARN)
                return
            end
            -- Call build and wait for it to finish if possible
            local res = blink.build()
            if res and type(res.pwait) == 'function' then
                pcall(function() res:pwait() end)
            end
        end,
    },
}
