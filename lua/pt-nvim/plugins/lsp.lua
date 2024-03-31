return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },

            -- Omnisharp
            { 'Hoffs/omnisharp-extended-lsp.nvim' }
        },
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()

            lsp_zero.set_sign_icons({
                error = '💩',
                warn = '😮',
                info = '🧠',
                hint = '🔮'
            })

            -- [[ Configure LSP ]]
            --  This function gets run when an LSP connects to a particular buffer.
            lsp_zero.on_attach(function(_, bufnr)
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

                -- Create a command `:Format` local to the LSP buffer
                vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                    vim.lsp.buf.format()
                end, { desc = 'Format current buffer with LSP' })

                nmap('<leader>lf', vim.lsp.buf.format, "[L]SP [F]ormat")
            end)

            lsp_zero.setup()

            local lsp_config = require("lspconfig")

            --- if you want to know more about lsp-zero and mason.nvim
            --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {
                },
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        lsp_config.lua_ls.setup(lua_opts)
                    end,
                    omnisharp = function()
                        lsp_config.omnisharp.setup({
                            handlers = {
                                ['textDocument/definition'] = require("omnisharp_extended").handlers,
                            },
                            cmd = { os.getenv('HOME') .. '/.local/share/nvim/mason/bin/omnisharp' },
                            organize_imports_on_format = true,
                            enable_roslyn_analyzers = false,
                            analyze_open_documents_only = false,
                            enable_import_completion = false,
                        })
                    end
                }
            })

            local cmp = require('cmp')
            local cmp_format = lsp_zero.cmp_format()

            cmp.setup({
                formatting = cmp_format,
                mapping = cmp.mapping.preset.insert({
                    -- scroll up and down the documentation window
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
            })

            vim.diagnostic.config({
                virtual_text = true
            })
        end,
    },
}
