-- Shorten function name
local keymap = vim.keymap.set

-- Space as leader
vim.g.mapleader = " "

-- Example keymaps
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Generate documentation comment (Doxygen/JSDoc/etc)
keymap("n", "<leader>d", function()
  require("neogen").generate()
end, { desc = "Generate documentation comment" })

keymap("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "Show all code actions" })

