local function onLspAttach(ev)

    --
    -- COMMENTED OUT BECAUSE I'M USING blink.cmp
    --
    -- local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    -- if client:supports_method('textDocument/completion') then
    --     vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    -- end

    local bufnr = ev.buf

    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>lr', vim.lsp.buf.rename, '[L]SP [R]ename')
    nmap('<leader>la', vim.lsp.buf.code_action, '[L]SP Code [A]ction')

    vim.keymap.set('v', '<leader>la', vim.lsp.buf.code_action, { desc = '[L]SP Code [A]ction' })

    local telescope = require("telescope.builtin")

    nmap('gd', telescope.lsp_definitions, '[G]oto [D]efinition')
    nmap('gr', telescope.lsp_references, '[G]oto [R]eferences')
    nmap('gi', telescope.lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>ls', telescope.lsp_document_symbols, 'Document [S]ymbols')
    nmap('<leader>lw', telescope.lsp_dynamic_workspace_symbols, '[W]orkspace Symbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Turn off inline diagnostics
    vim.diagnostic.config({
        virtual_text = false,
    })
    nmap("<leader>ld", ':lua vim.diagnostic.open_float()<CR>', "[L]SP [D]iagnostics")

    -- Lesser used LSP functionality
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    vim.keymap.set({ 'n', 'v' }, '<leader>lf', vim.lsp.buf.format, { buffer = bufnr, desc = "[L]SP [F]ormat" })
end

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        onLspAttach(ev)
    end,
})

local blink_caps = require('blink.cmp').get_lsp_capabilities()

vim.lsp.config('*', {
    capabilities = blink_caps,
})

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '💩',
            [vim.diagnostic.severity.WARN] = '😮',
            [vim.diagnostic.severity.INFO] = '🧠',
            [vim.diagnostic.severity.HINT] = '🔮',
        }
    },
    float = {
        border = "rounded", -- Options: "single", "double", "rounded", "solid", "shadow"
    },
})

vim.lsp.enable('luals')
vim.lsp.enable('gopls')
vim.lsp.enable('tsserver')
vim.lsp.enable('clangd')
vim.lsp.enable('jsonls')
