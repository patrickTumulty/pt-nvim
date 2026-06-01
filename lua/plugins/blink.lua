-- vim.api.nvim_create_autocmd('PackChanged', {
--     callback = function(ev)
--         local name, kind = ev.data.spec.name, ev.data.kind
--         if name == 'blink.cmp' and kind == 'update' then
--             if not ev.data.active then vim.cmd.packadd('blink.cmp') end
--             -- vim.cmd('cargo build --release')
--             require('blink.cmp').build():pwait()
--         end
--     end
-- })

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'blink.cmp' then
      local res = vim.system({ 'cargo', 'build', '--release' }, { cwd = ev.data.path })
      if vim.v.shell_error ~= 0 then
        vim.notify('Failed to compile blink.cmp: ' .. res, vim.log.levels.ERROR)
      else
        vim.notify('Successfully compiled blink.cmp', vim.log.levels.INFO)
      end
    end
  end,
})

vim.pack.add({ 

    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range('1.*') 
} })

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
    }
})
