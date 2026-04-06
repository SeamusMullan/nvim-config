local set = vim.opt

-- Line numbers
set.number = true
set.relativenumber = true

-- Indentation
set.tabstop = 4       -- number of visual spaces per TAB
set.softtabstop = 4   -- number of spaces in tab when editing
set.shiftwidth = 4    -- number of spaces for autoindent
set.expandtab = true  -- tabs are spaces

-- Highlighting
set.cursorline = true     -- highlight current line
set.termguicolors = true  -- enable 24-bit colors
set.scrolloff = 8         -- keep cursor away from screen edge
set.signcolumn = "yes"
set.updatetime = 200
set.timeoutlen = 300
set.splitright = true
set.splitbelow = true
set.ignorecase = true
set.smartcase = true
set.undofile = true
set.completeopt = { "menu", "menuone", "noselect" }
