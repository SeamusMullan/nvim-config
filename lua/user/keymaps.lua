-- Shorten function name
local keymap = vim.keymap.set

-- Example keymaps
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap("n", "<leader>?", function()
  require("which-key").show({ global = false, keys = "<leader>" })
end, { desc = "Show leader shortcuts" })

-- Core workflow
keymap("n", "<leader>ff", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

keymap("n", "<leader>fe", function()
  require("oil").open()
end, { desc = "Open file explorer" })

keymap("n", "<leader>ft", function()
  require("telescope.builtin").find_files()
end, { desc = "Find files" })

keymap("n", "<leader>fg", function()
  require("telescope.builtin").live_grep()
end, { desc = "Live grep" })

keymap("n", "<leader>fb", function()
  require("telescope.builtin").buffers()
end, { desc = "Buffers" })

keymap("n", "<leader>fd", function()
  require("telescope.builtin").diagnostics()
end, { desc = "Diagnostics" })

keymap("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics list" })

-- Debugging
keymap("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle breakpoint" })

keymap("n", "<leader>dc", function()
  require("dap").continue()
end, { desc = "Start/continue debugging" })

keymap("n", "<leader>do", function()
  require("dap").step_over()
end, { desc = "Debug step over" })

keymap("n", "<leader>di", function()
  require("dap").step_into()
end, { desc = "Debug step into" })

keymap("n", "<leader>du", function()
  require("dapui").toggle()
end, { desc = "Toggle debug UI" })

-- CMake helpers
keymap("n", "<leader>cg", "<cmd>CMakeGenerate<cr>", { desc = "CMake generate" })
keymap("n", "<leader>cb", "<cmd>CMakeBuild<cr>", { desc = "CMake build" })
keymap("n", "<leader>cr", "<cmd>CMakeRun<cr>", { desc = "CMake run" })
keymap("n", "<leader>ct", "<cmd>CMakeBuildType<cr>", { desc = "CMake build type" })

-- Generate documentation comment (Doxygen/JSDoc/etc)
keymap("n", "<leader>d", function()
  require("neogen").generate()
end, { desc = "Generate documentation comment" })

keymap("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "Show all code actions" })

