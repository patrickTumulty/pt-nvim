-- Prefer the project's venv pylsp so its plugins (mypy, ruff, rope) see the project's deps
local venv_pylsp = utils.venv_pylsp_path()
local pylsp_cmd = utils.file_exists(venv_pylsp) and venv_pylsp or utils.mason_bin_path("pylsp")

return {
    cmd = { pylsp_cmd },
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
