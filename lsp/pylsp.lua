-- local local_pylsp = 
-- local mason_pylsp = utils.mason_bin_path("pylsp")
--
-- local lsp_path = mason_pylsp
--
-- if utils.file_exists(local_pylsp) then
--     lsp_path = local_pylsp
-- end

return {
    cmd = { vim.fn.getcwd() .. "/venv/bin/pylsp" },
    filetypes = { 'python' },
    root_markers = {
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        'Pipfile',
        '.git',
    },
    settings = {
        pylsp = {
            plugins = {
                -- Rope gives pylsp a much better understanding of your project,
                -- fixing cross-file go-to-def and references
                rope_completion = { enabled = true },
                rope_autoimport = { enabled = true },

                -- Mypy for real type checking (replaces the weak pyflakes "might be undefined")
                pylsp_mypy = {
                    enabled = true,
                    live_mode = false, -- true hammers disk on every keystroke
                    strict = false,    -- flip to true if your project has full type annotations
                },

                -- Ruff replaces pycodestyle + pyflakes + mccabe + isort
                ruff = {
                    enabled = true,
                    formatEnabled = true,
                },

                -- Disable the plugins ruff supersedes
                pyflakes = { enabled = false },
                pycodestyle = { enabled = false },
                mccabe = { enabled = false },
                autopep8 = { enabled = false },
                yapf = { enabled = false },
            },
        },
    },
}
