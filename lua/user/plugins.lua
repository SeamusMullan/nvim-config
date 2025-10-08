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
  -- Doxygen comment generator
  ---------------------------------------------------------------------------
  {
    "jla2000/lazydocs.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "L3MON4D3/LuaSnip",
      "nvimtools/none-ls.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("lazydocs").setup()
      -- Keymaps moved to keymaps.lua to avoid duplication
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
-- LSP setup
-------------------------------------------------------------------------------
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Keymaps for LSP actions
local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, opts)
end

-- Configure language servers
local lspconfig = require("lspconfig")

lspconfig.clangd.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }, -- Recognize 'vim' global
      },
    },
  },
})

