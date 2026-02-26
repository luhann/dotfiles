-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- Example using a list of specs with the default options
vim.g.mapleader = " "       -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
  -- UI/Appearance
  { "rebelot/kanagawa.nvim" },
  "nvim-lualine/lualine.nvim",
  "nvim-tree/nvim-web-devicons",

  -- Editor enhancements
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        view = {
          width = "15%",
        }
      })
    end
  },

  -- Language support
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.config")

      configs.setup({
        ensure_installed = { "r", "markdown", "markdown_inline", "rnoweb", "python", "c", "lua", "yaml", "latex" },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },
  {
    "R-nvim/R.nvim",
    lazy = false,
    config = function()
      -- Create a table with the options to be passed to setup()
      ---@type RConfigUserOpts
      local opts = {
        hook = {
          on_filetype = function()
            vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
            vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
          end
        },
        R_args = { "--quiet", "--no-save" },
        R_app = "arf",
        R_cmd = "R",
        min_editor_width = 72,
        rconsole_width = 78,
        objbr_mappings = {                                      -- Object browser keymap
          c = 'class',                                          -- Call R functions
          ['<localleader>gg'] = 'head({object}, n = 15)',       -- Use {object} notation to write arbitrary R code.
          v = function()
            -- Run lua functions
            require('r.browser').toggle_view()
          end
        },
        disable_cmds = {
          "RClearConsole",
          "RCustomStart",
          "RSPlot",
          "RSaveClose",
        },
      }
      -- Check if the environment variable "R_AUTO_START" exists.
      -- If using fish shell, you could put in your config.fish:
      -- alias r "R_AUTO_START=true nvim"
      if vim.env.R_AUTO_START == "true" then
        opts.auto_start = "on startup"
        opts.objbr_auto_start = true
      end
      require("r").setup(opts)
    end,

  },

  -- LSP/Completion
  { "neovim/nvim-lspconfig", lazy = false },
  {
    "saghen/blink.cmp",
    version = '1.*',
    opts = {
      keymap = { preset = 'super-tab' },
      fuzzy = {
        implementation = "prefer_rust_with_warning" -- or "rust" if you strictly want the Rust implementation
      },
    },
  }
})

vim.lsp.enable("air")
vim.lsp.enable("jarl")
vim.lsp.enable("lua_ls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("texlab")
vim.lsp.enable("tinymist")

vim.lsp.config("jarl", {
  cmd = { 'jarl', 'server' },
  filetypes = { 'r', 'rmd'},
  -- root_markers = { '.git' },
  root_dir = function(bufnr, on_dir)
    on_dir(vim.fs.root(bufnr, '.git') or vim.uv.os_homedir())
  end,
})


vim.lsp.config("rust_analyzer", {
  on_attach = function(client, bufnr)
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end,
  capabilities = {
    experimental = { serverStatusNotification = true },
  },
  filetypes = { "rust", "toml.Cargo" },
  root_markers = { "Cargo.toml", "Cargo.lock", "build.rs" },
  -- See more: https://rust-analyzer.github.io/book/configuration.html
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      check = {
        command = "clippy",
        features = "all",
        allTargets = true,
        onSave = true,
      },
      diagnostics = {
        styleLints = { enable = true }
      },
      inlayHints = {
        enable = true,
      },
    }
  }
})

vim.lsp.config("texlab", {
  filetypes = { "rnoweb", "tex", "plaintex", "bib" },
})

vim.lsp.config("tinymist", {
  filetypes = { "typst" },
  settings = {
    formatterMode = "typstyle",
    exportPdf = "onType",
    semanticTokens = "disable"
  }
})

vim.diagnostic.config({
  virtual_text = true,
})

vim.opt.undofile = true

vim.opt.showmatch = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.spell = true
vim.opt.spelllang = "en_gb"
vim.opt.spellsuggest = "best"
vim.opt.pumheight = 10

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoread = true

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

vim.api.nvim_command("colorscheme kanagawa")

-- core functionality
require("core.keybinds")
require("core.linenumbers")
require("core.filetypes")
-- galaxyline theme
require("plugins.galactus")
