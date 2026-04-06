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

local wal_colors = vim.fn.expand("~/.config/nvim/colors/wal.vim")
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"

-- Plugins
require("lazy").setup({
  ---------------------------------------------------------------------------
  -- UI & appearance
  ---------------------------------------------------------------------------
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "nvim-lualine/lualine.nvim", event = "VeryLazy" },
  { "nvim-tree/nvim-web-devicons", event = "VeryLazy" },
  {
    "andweeb/presence.nvim",
    event = "VeryLazy",
    config = function()
      require("presence").setup({
        auto_update = true,
        neovim_image_text = "The One True Text Editor",
        main_image = "neovim",
        log_level = nil,
        editing_text = "Editing %s",
        file_explorer_text = "Browsing %s",
        git_commit_text = "Committing changes",
        plugin_manager_text = "Managing plugins",
        reading_text = "Reading %s",
        workspace_text = "Working on %s",
        line_number_text = "Line %s out of %s",
      })
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    ft = { "markdown" },
    cmd = { "Markview", "MarkviewToggle" },
  },
  {
    "lervag/vimtex",
    ft = { "tex" },
    init = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_syntax_enabled = 1
    end,
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "tex",
        callback = function()
          vim.treesitter.stop()
        end,
      })
    end,
  },

  ---------------------------------------------------------------------------
  -- Navigation, project browsing, and git
  ---------------------------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signcolumn = true,
        current_line_blame = true,
        current_line_blame_opts = {
          delay = 400,
        },
      })
    end,
  },
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        view_options = {
          show_hidden = true,
        },
      })
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({
        focus = true,
      })
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      icons = {
        mappings = false,
      },
    },
  },


  ---------------------------------------------------------------------------
  -- Core dependencies
  ---------------------------------------------------------------------------
  { "nvim-lua/plenary.nvim", lazy = true },

  ---------------------------------------------------------------------------
  -- Editing helpers
  ---------------------------------------------------------------------------
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup({})
    end,
  },

  ---------------------------------------------------------------------------
  -- Syntax highlighting & parsing
  ---------------------------------------------------------------------------
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

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

  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "rafamadriz/friendly-snippets",
    event = "VeryLazy",
  },

  ---------------------------------------------------------------------------
  -- LSP, Mason & Autocompletion
  ---------------------------------------------------------------------------
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "WhoIsSethDaniel/mason-tool-installer.nvim" },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
    },
  },

  ---------------------------------------------------------------------------
  -- Formatting & linting
  ---------------------------------------------------------------------------
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
  },

  ---------------------------------------------------------------------------
  -- Debugging
  ---------------------------------------------------------------------------
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    event = "VeryLazy",
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = { "python" },
    dependencies = { "mfussenegger/nvim-dap" },
  },

  ---------------------------------------------------------------------------
  -- CMake workflow
  ---------------------------------------------------------------------------
  {
    "Civitasv/cmake-tools.nvim",
    ft = { "c", "cpp", "cmake" },
  },

})

-------------------------------------------------------------------------------
-- Post-plugin setup
-------------------------------------------------------------------------------

-- Colorscheme
if vim.fn.filereadable(wal_colors) == 1 then
  vim.cmd.colorscheme("wal")

  vim.api.nvim_create_autocmd("FocusGained", {
    callback = function()
      vim.cmd("source " .. wal_colors)
    end,
  })
else
  vim.cmd.colorscheme("catppuccin")
end

-- Lualine
require("lualine").setup({
  options = {
    section_separators = "",
    component_separators = "",
  },
})

-- Telescope
require("telescope").setup({
  defaults = {
    file_ignore_patterns = { "build/", ".git/" },
  },
})

-- WhichKey groups
require("which-key").add({
  { "<leader>c", group = "cmake" },
  { "<leader>d", group = "debug/doc" },
  { "<leader>f", group = "file/find" },
  { "<leader>x", group = "trouble" },
})

-- Mason
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd",
    "pyright",
    "lua_ls",
  },
})

require("mason-tool-installer").setup({
  ensure_installed = {
    "clang-format",
    "ruff",
    "black",
    "isort",
    "debugpy",
    "codelldb",
    "cmake-language-server",
    "cmakelang",
    "stylua",
  },
  auto_update = false,
  run_on_start = true,
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

-- Conform (formatting)
require("conform").setup({
  formatters_by_ft = {
    c = { "clang-format" },
    cpp = { "clang-format" },
    python = { "ruff_format" },
    lua = { "stylua" },
    cmake = { "cmake_format" },
  },
  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = true,
  },
})

-- Linting
require("lint").linters_by_ft = {
  c = { "clangtidy" },
  cpp = { "clangtidy" },
  python = { "ruff" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

-- DAP
local dap = require("dap")
local dapui = require("dapui")

dapui.setup()
require("nvim-dap-virtual-text").setup({})

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = mason_bin .. "/codelldb",
    args = { "--port", "${port}" },
  },
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}
dap.configurations.c = dap.configurations.cpp

require("dap-python").setup(mason_packages .. "/debugpy/venv/bin/python")
dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    pythonPath = function()
      return "python3"
    end,
  },
}

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- CMake tools
require("cmake-tools").setup({})

vim.api.nvim_create_user_command("CMakeBuildType", function()
  vim.cmd("CMakeSelectBuildType")
end, {
  desc = "Select the active CMake build type",
})

-------------------------------------------------------------------------------
-- Treesitter setup
-------------------------------------------------------------------------------
require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "cpp", "python", "lua", "vim", "vimdoc", "rust" },
  auto_install = true,

  highlight = {
    enable = true,
  },

  indent = {
    enable = true,
  },

  textobjects = {
    move = {
      enable = true,
      set_jumps = true,

      -- Functions (methods included)
      goto_next_start = {
        ["]]"] = "@function.outer",
        ["]c"] = "@class.outer",
      },

      goto_previous_start = {
        ["[["] = "@function.outer",
        ["[c"] = "@class.outer",
      },
    },
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
      require("conform").format({ async = true, lsp_fallback = true, bufnr = bufnr })
    end, opts)
  end,
})

-- Configure language servers using new API
vim.lsp.config("*", {
  capabilities = capabilities,
})

-- clangd (C/C++)
-- clangd (C/C++)
vim.lsp.config("clangd", {
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders=true",
    "--fallback-style=LLVM",
  },
})
vim.lsp.enable("clangd")

-- pyright (Python)
vim.lsp.config("pyright", {
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})
vim.lsp.enable("pyright")

-- lua_ls (Lua) with custom settings
vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }, -- Recognize 'vim' global
      },
    },
  },
})
vim.lsp.enable("lua_ls")

vim.lsp.config("qmlls", {
  cmd = { "qmlls6" },
})
vim.lsp.enable("qmlls")

-- for diagnostics and error messages

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 4,
    source = "always",
  },
  severity_sort = true,
})

