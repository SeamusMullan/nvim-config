# Neovim learning guide

This guide is matched to the current config in `lua/user/plugins.lua`, `lua/user/keymaps.lua`, and `lua/user/options.lua`.

## Mental model

Your config is split into three pieces:

- `init.lua` loads options, keymaps, then plugins.
- `lua/user/options.lua` sets editor behavior like line numbers, completion, splits, and undo.
- `lua/user/keymaps.lua` defines the shortcuts you use day to day.
- `lua/user/plugins.lua` installs and configures language tooling.

If you learn those three files first, the rest of the setup becomes much easier to extend.

## Core keys

### Editing

- `<Space>` is the leader key.
- `<leader>w` saves the current file.
- `<leader>q` quits the current window.
- `<leader>d` generates a documentation block with Neogen.
- `<leader>ca` opens LSP code actions.

### Navigation

- `<leader>ft` finds files with Telescope.
- `<leader>fg` searches text across the project.
- `<leader>fb` switches buffers.
- `<leader>fd` shows diagnostics.
- `<leader>fe` opens the Oil file explorer.
- `<leader>xx` opens Trouble diagnostics.
- `<leader>?` opens WhichKey for leader shortcuts.

### Formatting

- `<leader>ff` formats the current buffer.
- Format-on-save is enabled through Conform.
- C/C++ uses `clang-format`.
- Python uses `ruff_format`.
- Lua uses `stylua`.
- CMake uses `cmake-format` when available.

### Debugging tools

- `<leader>db` toggles a breakpoint.
- `<leader>dc` starts or continues debugging.
- `<leader>do` steps over.
- `<leader>di` steps into.
- `<leader>du` toggles the debug UI.

### CMake tooling

- Telescope: fuzzy find files, text, buffers, and diagnostics.
- Oil: a lightweight file explorer in a normal buffer.
- Gitsigns: shows git changes in the sign column and blame for the current line.
- Trouble: collects diagnostics and code issues into a searchable list.

### Editing helpers

- nvim-autopairs: closes brackets and quotes automatically.
- nvim-surround: adds, changes, and removes surroundings like quotes or brackets.
- Comment.nvim: toggles comments cleanly.
- WhichKey: shows available shortcuts as a popup while you type.

### Language assistance

- Treesitter: better syntax highlighting and parsing.
- Neogen: generates Doxygen-style docs for C and C++, and Google-style docs for Python.
- nvim-cmp: completion menu.
- LuaSnip + friendly-snippets: snippet expansion for common patterns.

### Language servers

- `clangd` for C and C++.
- `pyright` for Python.
- `lua_ls` for Neovim Lua config files.

### Formatting and linting

- Conform handles formatting.
- nvim-lint runs light-weight lint checks on save and when leaving insert mode.
- Mason and mason-tool-installer install the external tools you need.

### Debugging

- nvim-dap is the core debugger interface.
- nvim-dap-ui provides the side panel with stacks, scopes, and watches.
- nvim-dap-virtual-text shows variable values inline.
- nvim-dap-python adds Python debugging support.

### CMake

- cmake-tools.nvim handles configure, build, and run commands for CMake projects.

## Typical workflows

### C or C++

1. Open a project that has a `compile_commands.json` file if possible.
2. Use Telescope to jump between files.
3. Use `<leader>d` to generate a doc comment above a function.
4. Use `<leader>ff` or save the file to format it.
5. Use `<leader>db` and `<leader>dc` to debug the compiled binary.
6. Use `<leader>cg`, `<leader>cb`, and `<leader>cr` for CMake projects.

### Python

1. Open a Python file.
2. Use LSP completion from `pyright` and snippets from LuaSnip.
3. Format with `<leader>ff`.
4. Check diagnostics with `<leader>fd` or `<leader>xx`.
5. Debug with `<leader>dc`.

### Editing docs and comments

- Use Neogen to generate starter comments for functions and classes.
- Use Comment.nvim for quick line or block comments.
- Use nvim-surround to refactor quoted strings, parentheses, and markup.

## Installed tooling to know

These are the main external tools managed by Mason:

- `clangd`
- `clang-format`
- `ruff`
- `black`
- `isort`
- `debugpy`
- `codelldb`
- `cmake-language-server`
- `cmakelang`
- `stylua`

If one of those is missing, start with `:Mason` and install it there.

## Useful commands

- `:Lazy` opens the plugin manager.
- `:Mason` opens the tool installer.
- `:LspInfo` shows active LSP clients.
- `:checkhealth` helps find missing dependencies.
- `:CMakeGenerate`, `:CMakeBuild`, and `:CMakeRun` are available through cmake-tools.

## Learning tips

- Learn one plugin at a time instead of trying to memorize everything.
- Start with Telescope, formatting, and LSP basics first.
- Then add debugging and CMake workflows.
- Keep `compile_commands.json` up to date for the best C/C++ experience.
- If completion or formatting feels slow, check `:checkhealth` and `:Mason` first.

## Good next steps

If you want to go deeper, the most valuable follow-ups are:

1. Add project-specific CMake preset support.
2. Add per-language formatter and linter overrides.
3. Add a dedicated debug launch menu for common C++ binaries.
4. Add Telescope keymaps for help tags, diagnostics, and git history.
