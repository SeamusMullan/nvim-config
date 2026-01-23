-- Load core configs
require("user.options")
require("user.keymaps")
require("user.plugins")

-- Try to load wal colorscheme, fallback if it doesn't exist
local wal_colors = vim.fn.expand('~/.config/nvim/colors/wal.vim')
if vim.fn.filereadable(wal_colors) == 1 then
  vim.cmd('colorscheme wal')
  
  -- Force reload on focus
  vim.api.nvim_create_autocmd("FocusGained", {
    callback = function()
      vim.cmd('source ' .. wal_colors)
      print("Colorscheme reloaded!")
    end
  })
else
  vim.cmd('colorscheme default')
end
