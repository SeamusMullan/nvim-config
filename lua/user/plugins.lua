-- ~/.config/nvim/lua/user/plugins.lua
-- Modern Neovim plugin setup using lazy.nvim

-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({

  ---------------------------------------------------------------------------
  -- UI & appearance
  ---------------------------------------------------------------------------
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 }, -- Colorscheme
  { "nvim-lualine/lualine.nvim" }, -- Statusline
  { "nvim-tree/nvim-web-devicons" }, -- Icons

  ---------------------------------------------------------------------------
  -- Core dependencies
  ---------------------------------------------------------------------------
  { "nvim-lua/plenary.nvim" }, -- Needed by many plugins (and none-ls/lazydocs)

  ---------------------------------------------------------------------------
  -- Syntax highlighting & parsing
  ---------------------------------------------------------------------------
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  ---------------------------------------------------------------------------
  -- Documentation comment generator (Doxygen, JSDoc, etc.)
  ---------------------------------------------------------------------------
  {
    "danymat/neogen",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("neogen").setup({
        enabled = true,
        languages = {
          c = { template = { annotation_convention = "doxygen" } },
          cpp = { template = { annotation_convention = "doxygen" } },
          python = { template = { annotation_convention = "google_docstrings" } },
        },
      })
    end,
  },

  ---------------------------------------------------------------------------
  -- LSP, Mason & Autocompletion
  ---------------------------------------------------------------------------
  { "neovim/nvim-lspconfig" },        -- Core LSP configs
  { "williamboman/mason.nvim" },      -- Installer for LSP/linters
  { "williamboman/mason-lspconfig.nvim" }, -- Mason ↔ LSP bridge

  {
    "hrsh7th/nvim-cmp", -- Autocompletion
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
    },
  },

})

-------------------------------------------------------------------------------
-- Post-plugin setup
-------------------------------------------------------------------------------

-- Colorscheme
vim.cmd.colorscheme("catppuccin")

-- Lualine
require("lualine").setup({
  options = {
    theme = "catppuccin",
    section_separators = "",
    component_separators = "",
  },
})

-- Mason
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd",   -- C / C++
    "pyright",  -- Python
    "lua_ls",   -- Lua
  },
})

-- nvim-cmp (completion)
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
})

-------------------------------------------------------------------------------
-- Treesitter setup
-------------------------------------------------------------------------------
require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "cpp", "python", "lua", "vim", "vimdoc" },
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
})

-------------------------------------------------------------------------------
-- LSP setup (using new vim.lsp.config API for Neovim 0.11+)
-------------------------------------------------------------------------------
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Setup LSP keymaps when LSP attaches to buffer
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})

-- Configure language servers using new API
vim.lsp.config("*", {
  capabilities = capabilities,
})

-- clangd (C/C++)
vim.lsp.enable("clangd")

-- pyright (Python)
vim.lsp.enable("pyright")

-- lua_ls (Lua) with custom settings
vim.lsp.config.lua_ls = {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }, -- Recognize 'vim' global
      },
    },
  },
}
vim.lsp.enable("lua_ls")

