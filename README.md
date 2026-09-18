# pt-nvim

```text
                 __                     _
    ____  __  __/ /_      ____ _   __  (_)___ ___
   / __ \/ /_/ / __/_____/ __ \ | / / / / __ `__ \
  / /_/ / __/ / /_/_____/ / / / |/ / / / / / / / /
 / .___/\__/  \__/     /_/ /_/|___/ /_/_/ /_/ /_/
/_/

  +--------------------------------------------------+
  |  MODAL EDITING. WARM COLORS. COLD-BLOODED SEARCH.  |
  +--------------------------------------------------+
```

A personal Neovim setup for living in the terminal. Gruvbox Material on the
outside; native LSP, fuzzy finding, and a full Git workbench underneath.
Lua all the way down, with plugins managed by Neovim itself.

**Leader:** `Space` / **Plugins:** `vim.pack` / **Theme:** Gruvbox Material

## The Loadout

| Job | Tools |
| --- | --- |
| Find anything | Telescope, native FZF sorting, custom live multigrep |
| Move files like text | Oil, with automatic Git add/move/remove integration |
| Write code | Native LSP, Mason, Blink completion, autopairs, autotag |
| Read code | Treesitter highlighting, indentation, sticky context |
| Ship changes | Neogit, Fugitive, Diffview, Gitsigns |
| Keep your bearings | Bufferline, mini.statusline, indent guides, scrollbar |
| Leave breadcrumbs | TODO highlighting, Comment.nvim, Doge documentation generation |

Relative line numbers, persistent undo, four-space indentation, and a
100-column guide round things out. Diagnostics stay out of the text and are
available through signs, floating windows, and Telescope.

## Before You Drop In

- **Neovim 0.12+**, with `vim.pack` support. Older versions will not load this config.
- **Git** and network access to fetch plugins and language tooling.
- **Rust / Cargo**, available through [rustup](https://rustup.rs/), for the CLI tools below and the Blink build hook.
- **A C compiler and `make`** for parser builds and Telescope's native FZF extension. The extension is only added when `make` is available; the standalone `fzf` command is not required.
- **`curl`, `tar`, and `unzip`** for downloading and unpacking tooling.
- **A Nerd Font** and a true-color terminal for the intended look.

### Cargo Crew

Install the external search and parser tools, not just the Neovim plugins:

```sh
cargo install --locked fd-find ripgrep tree-sitter-cli
```

| Cargo package | Command | What it does here |
| --- | --- | --- |
| `fd-find` | `fd` | Fast file discovery for Telescope; recommended, with other search backends available |
| `ripgrep` | `rg` | Powers text search and the custom live multigrep picker |
| `tree-sitter-cli` | `tree-sitter` | Parser generation tooling used by nvim-treesitter |

Make sure Cargo's binary directory is on the `PATH` inherited by Neovim.
On Linux/macOS, that is normally `$HOME/.cargo/bin`:

```sh
export PATH="$HOME/.cargo/bin:$PATH"

fd --version
rg --version
tree-sitter --version
```

Add the `export` to your shell configuration if it is not already there.
The Cargo package is called **`fd-find`**, but the installed executable is **`fd`**.

## Boot Sequence

Back up any existing Neovim configuration first. On Linux/macOS, clone into
Neovim's configuration directory:

```sh
git clone https://github.com/patrickTumulty/pt-nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
nvim
```

On first launch, `vim.pack` handles plugin installation. Allow any installation
prompts and let the native build hooks finish. Plugin revisions are tracked in
[`nvim-pack-lock.json`](nvim-pack-lock.json); Treesitter installs missing parsers
as you open supported filetypes.

Then check the instruments:

```vim
:checkhealth
:Mason
```

Windows notes live in [`WINDOWS_SETUP.md`](WINDOWS_SETUP.md). The **0.12+**
requirement here supersedes that guide's older Neovim version requirement.

## Give It Language Servers

Mason is configured, but language servers are **not automatically installed**.
Open `:Mason`, install the servers you need, then restart Neovim. Most configured
servers are enabled only when their Mason executable is present.

| Language | Server |
| --- | --- |
| Lua | `lua-language-server` |
| C / C++ | `clangd` |
| Go | `gopls` |
| JavaScript / TypeScript | `typescript-language-server` |
| HTML / CSS / JSON | VS Code HTML, CSS, and JSON language servers |
| CMake | `neocmakelsp` |
| Java | `jdtls` |
| Rust | `rust-analyzer`, installed separately and available on `PATH` |
| Python | `python-lsp-server`, in a project-local `venv` |

Language runtimes still matter: install Node.js, a JDK, Go, or the relevant
toolchain for the servers you choose. Per-server settings live in [`lsp/`](lsp/).
The clangd configuration includes machine-specific compiler paths worth reviewing
before using it on another machine.

For Python, launch Neovim from the project root after setting up the expected
environment:

```sh
python3 -m venv venv
./venv/bin/python -m pip install python-lsp-server pylsp-rope python-lsp-ruff pylsp-mypy
nvim .
```

The Python launch command targets `venv/bin/pylsp` on Unix or
`venv\Scripts\pylsp.exe` on Windows. Installing the server in Mason alone does
not satisfy that launch path. Formatting uses the attached LSP server.

## Muscle Memory

`<leader>` means `Space`. These are normal-mode mappings unless noted.

| Keys | Action |
| --- | --- |
| `<leader>pv` | Open Oil's directory editor |
| `<leader>ff` / `<leader>gf` | Find files / Git-tracked files |
| `<leader>fg` / `<leader>fw` | Live multigrep / search the word under the cursor |
| `<leader>fc` | Fuzzy search the current buffer |
| `<leader><Space>` / `<leader>?` | Open buffers / recent files |
| `<leader>bj` / `<leader>bc` | Pick a buffer / pick a buffer to close |
| `<leader>bb` / `<leader>bn` | Previous / next buffer |
| `gd` / `gr` / `gi` | Definition / references / implementation |
| `K` | Hover documentation |
| `<leader>lr` / `<leader>la` | Rename / code action |
| `<leader>lf` | LSP format; also available in visual mode |
| `<leader>ld` / `<leader>lD` | Floating diagnostics / diagnostic picker |
| `<leader>gg` | Open Neogit through the repository/submodule picker |
| `<leader>do` / `<leader>dc` | Open / close Diffview |
| `<leader>dh` / `<leader>df` | File history / compare the file with a branch |
| `<leader>hn` / `<leader>hp` | Next hunk / preview hunk |
| `<leader>hr` / `<leader>gb` | Reset hunk / blame the current line |
| `<leader>dg` | Generate documentation |
| `<leader>dm` / `<leader>lm` | Dark / light background |
| `Ctrl-h/j/k/l` | Navigate splits |
| `J` / `K` in visual mode | Move selected lines down / up |
| `U` | Redo |

### Search With Teeth

The `<leader>fg` picker accepts a search pattern, **two spaces**, then a file glob:

```text
TODO  *.lua
malloc  *.c
useState  *.tsx
```

Leave off the glob to search across the project. Ripgrep does the hunting;
Telescope handles the preview.

## Under The Hood

```text
.
|-- init.lua             Entry point; loads config, plugins, then LSP
|-- lua/
|   |-- config/          Options, mappings, templates, custom workflows
|   |-- plugins/         Plugin declarations and setup, one module at a time
|   |-- platform.lua     Platform helpers
|   `-- utils.lua        Shared utilities and build helpers
|-- lsp/                 Native per-server LSP configurations
|-- after/plugin/        Extra integrations and overrides
|-- templates/           Skeletons for new source files
|-- scripts/             Personal setup and workflow helpers
`-- nvim-pack-lock.json  Plugin revision lockfile
```

Every `.lua` file in `lua/plugins/` is loaded automatically. Start there to
change the loadout, in `lua/config/remap.lua` to change the controls, or in
`lua/plugins/colorscheme.lua` to change the paint.

## Field Notes

- **Clipboard:** copy/paste uses OSC 52. Your terminal or multiplexer must support it; clipboard reads may require explicit permission or may be unsupported.
- **File operations:** Oil can stage Git additions, moves, and removals automatically. Treat directory edits as real filesystem operations.
- **Templates:** new files can pick up skeletons from `templates/`, including files created through Oil.
- **Optional extras:** browser refresh automation uses `xdotool` on X11; the Unity launcher uses Kitty and `nvr`. Neither is needed for the core editor.
- **Personal config, not a distribution:** review local paths and workflow helpers before making it your daily driver. Debugger configuration is currently commented out.

```text
  [ NORMAL ]  less mouse, more motion.                         :wq
```
