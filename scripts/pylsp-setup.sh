#!/bin/bash

VENV_PIP="./venv/bin/pip"
MASON_PIP="$HOME/.local/share/nvim/mason/packages/python-lsp-server/venv/bin/pip"

if [ -f "$VENV_PIP" ]; then
    echo "Installing into project venv..."
    $VENV_PIP install python-lsp-server pylsp-rope python-lsp-ruff pylsp-mypy
else
    echo "Installing into Mason venv..."
    $MASON_PIP install pylsp-rope
    # ruff and mypy installed separately via Mason
fi
