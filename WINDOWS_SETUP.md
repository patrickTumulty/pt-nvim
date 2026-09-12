# Windows Setup Guide for Neovim Configuration

This Neovim configuration has been updated to work on Windows. Here are the requirements and setup instructions:

## Prerequisites

1. **Neovim** (>= 0.10.0) - Install via winget, scoop, or chocolatey
2. **Git** - Required for plugin management
3. **A C compiler** (for TreeSitter):
   - Option 1: Install MinGW-w64 or MSYS2
   - Option 2: Install Visual Studio Build Tools
4. **ripgrep** - For file searching (install via winget or scoop)
5. **fd** (optional) - For better file finding (install via winget or scoop)
6. **Node.js** (optional) - For some LSP servers

## Installation Steps

1. Clone this configuration to your Neovim config directory:
   ```powershell
   git clone <your-repo> $env:LOCALAPPDATA\nvim
   ```

2. Install Mason (package manager for LSP/DAP/Linters):
   - Mason will be installed automatically on first launch
   - LSP servers will be installed to `%LOCALAPPDATA%\nvim-data\mason\bin`

3. For Python development:
   - Create virtual environments in your project root
   - Windows path: `.\venv\Scripts\pylsp.exe`

4. For C/C++ development:
   - Install clangd via Mason or manually
   - Update compiler paths in `lsp/clangd.lua` if needed

## Windows-Specific Changes Made

1. **Path Separators**: All paths now use `package.config:sub(1,1)` for OS-appropriate separators
2. **Home Directory**: Uses `USERPROFILE` on Windows instead of `HOME`
3. **Undo Directory**: Uses Neovim's standard data directory
4. **Mason Binaries**: Looks for `.cmd` files on Windows
5. **Virtual Environments**: Checks `Scripts` directory on Windows
6. **Git Operations**: PowerShell commands for finding repositories
7. **xdotool**: Disabled on Windows (Linux-only tool)

## Troubleshooting

- If TreeSitter fails to compile parsers, ensure you have a C compiler in PATH
- For LSP issues, check that Mason installed the servers correctly
- Python LSP looks for virtual environments in the current working directory

## Optional Tools

- **Windows Terminal** - Better terminal experience
- **PowerShell 7+** - Improved shell experience
- **fzf** - For fuzzy finding (telescope optional dependency)