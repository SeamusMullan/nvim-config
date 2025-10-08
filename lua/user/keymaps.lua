-- Shorten function name
local keymap = vim.keymap.set

-- Space as leader
vim.g.mapleader = " "

-- Example keymaps
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>d", function()
  vim.lsp.buf.code_action({
    context = { only = { "source.generate.doxygen" } }
  })
end, { desc = "Generate Doxygen comment (lazydocs)" })

vim.keymap.set("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "Show all code actions" })

