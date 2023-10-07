local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    "rust_analyzer",
    "lua_ls",
    "clangd",
    "jdtls",
    "gradle_ls",
    "pyright",
    "bashls",
    "eslint",
    "tsserver"
})

lsp.nvim_workspace()

lsp.set_sign_icons({
    error = '💩',
    warn = '😮',
    info = '🧠',
    hint = '🔮'
})

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
lsp.on_attach(function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
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

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', telescope.lsp_references, '[G]oto [R]eferences')
    nmap('gi', telescope.lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', telescope.lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', telescope.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })

    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "[L]SP [F]ormat" })
end)

lsp.skip_server_setup({ 'jdtls' })

lsp.setup()

local cmp = require("cmp")
cmp.setup({
    mapping = {
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }
})

vim.diagnostic.config({
    virtual_text = true
})
