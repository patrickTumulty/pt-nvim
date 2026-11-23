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
    vim.keymap.set({ 'n', 'v' }, '<leader>la', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'LSP: [L]SP Code [A]ction' })

    local telescope = require("telescope.builtin")

    nmap('gd', telescope.lsp_definitions, '[G]oto [D]efinition')
    nmap('gr', telescope.lsp_references, '[G]oto [R]eferences')
    nmap('gi', telescope.lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>ls', telescope.lsp_document_symbols, 'Document [S]ymbols')
    nmap('<leader>lw', telescope.lsp_dynamic_workspace_symbols, '[W]orkspace Symbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')

    nmap("<leader>ld", vim.diagnostic.open_float, "[L]SP [D]iagnostics")
    nmap("<leader>lD", telescope.diagnostics, "[L]SP [D]iagnostics: Telescope")

    -- Lesser used LSP functionality
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    vim.keymap.set({ 'n', 'v' }, '<leader>lf', vim.lsp.buf.format, { buffer = bufnr, desc = "[L]SP [F]ormat" })
end

-- Neovim's built-in gr* LSP maps make the buffer-local `gr` above ambiguous,
-- so it would only fire after 'timeoutlen'.
for _, lhs in ipairs({ 'grr', 'gri', 'grn', 'gra', 'grt', 'grx' }) do
    for _, mode in ipairs({ 'n', 'x' }) do
        pcall(vim.keymap.del, mode, lhs)
    end
end

vim.api.nvim_create_autocmd('LspAttach', {
    callback = onLspAttach,
})

-- blink.cmp's plugin/ file already registers its completion capabilities via vim.lsp.config('*')

vim.diagnostic.config({
    virtual_text = false,
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

local function enableIfInstalled(lsp, mason, alt_path)
    if mason == nil then
        mason = true
    end
    if mason then
        if alt_path ~= nil and utils.file_exists(alt_path) then
            vim.lsp.enable(lsp)
            return;
        end

        local lsp_path = utils.mason_bin_path(lsp)

        if utils.file_exists(lsp_path) then
            vim.lsp.enable(lsp)
        end
    else
        if vim.fn.executable(lsp) == 1 then
            vim.lsp.enable(lsp)
        end
    end
end

enableIfInstalled('rust-analyzer', false)
enableIfInstalled('lua-language-server')
enableIfInstalled('gopls')
enableIfInstalled('typescript-language-server')
enableIfInstalled('clangd')
enableIfInstalled('vscode-html-language-server')
enableIfInstalled('vscode-css-language-server')
enableIfInstalled("vscode-json-language-server")
enableIfInstalled('neocmakelsp')
enableIfInstalled('jdtls')
enableIfInstalled('bash-language-server')
enableIfInstalled('pylsp', true, utils.venv_pylsp_path())

-- Mason package names differ from the LSP config names for some servers.
-- Only these servers are auto-installed; rust-analyzer comes from rustup, and
-- gopls, typescript-language-server, jdtls, and pylsp are installed by hand.
-- `needs` is the executable Mason shells out to for the install; without it the
-- install would fail on every startup, so those servers are skipped instead.
local auto_installed_mason_servers = {
    { lsp = 'lua-language-server', package = 'lua-language-server' },
    { lsp = 'clangd', package = 'clangd' },
    { lsp = 'vscode-html-language-server', package = 'html-lsp', needs = 'npm' },
    { lsp = 'vscode-css-language-server', package = 'css-lsp', needs = 'npm' },
    { lsp = 'vscode-json-language-server', package = 'json-lsp', needs = 'npm' },
    { lsp = 'neocmakelsp', package = 'neocmakelsp' },
    { lsp = 'bash-language-server', package = 'bash-language-server', needs = 'npm' },
}

local function installMissingMasonServers()
    local registry = require('mason-registry')

    for _, server in ipairs(auto_installed_mason_servers) do
        local lsp, package_name = server.lsp, server.package
        local has_install_tool = server.needs == nil or vim.fn.executable(server.needs) == 1
        if not has_install_tool then
            goto continue
        end

        if registry.has_package(package_name) then
            local package = registry.get_package(package_name)
            if not package:is_installed() and not package:is_installing() then
                vim.notify('Mason: installing ' .. package_name, vim.log.levels.INFO)
                package:install({}, function(success, err)
                    vim.schedule(function()
                        if success then
                            vim.notify('Mason: installed ' .. package_name, vim.log.levels.INFO)
                            vim.lsp.enable(lsp)
                        else
                            vim.notify('Mason: failed to install ' .. package_name .. ': ' .. tostring(err),
                                vim.log.levels.ERROR)
                        end
                    end)
                end)
            end
        else
            vim.notify('Mason: no package named ' .. package_name, vim.log.levels.WARN)
        end

        ::continue::
    end
end

-- The registry may not be downloaded yet on a fresh machine, so refresh before looking up packages.
require('mason-registry').refresh(vim.schedule_wrap(installMissingMasonServers))
