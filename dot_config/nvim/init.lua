-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
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
  {"rebelot/kanagawa.nvim"},
  "nvim-lualine/lualine.nvim",
  "nvim-tree/nvim-web-devicons",

   -- Editor enhancements
  {"folke/which-key.nvim",
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
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "r", "markdown", "markdown_inline", "rnoweb", "python", "c", "lua", "yaml", "latex"},
          sync_install = false,
          auto_install = true,
          highlight = { enable = true},
          indent = { enable = true },
        })
    end
  },
  {"R-nvim/R.nvim", lazy = false},

  -- LSP/Completion
  {"neovim/nvim-lspconfig", lazy = false},
  {
    "hrsh7th/nvim-cmp",
    -- load cmp on InsertEnter
    event = "InsertEnter",
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
  }
})

local cmp = require'cmp'

cmp.setup {
  sources = {
    { name = 'nvim_lsp' }
  },
  mapping = cmp.mapping.preset.insert(),
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig").air.setup({
    on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format()
            end,
        })
    end,
})

require'lspconfig'.r_language_server.setup{
  capabilities = capabilities,
  on_attach = function(client, _)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
}

require'lspconfig'.texlab.setup{
  capabilities = capabilities,
  filetypes = { "rnoweb", "tex", "plaintex", "bib" },
  settings = {
    texlab = {
      latexFormatter = "latexindent",
    },
  },
}

vim.diagnostic.config({
  virtual_text = true,
})

vim.g.R_app = "radian"
vim.g.R_cmd = "R"

vim.opt.showmatch = true
vim.opt.number = true
vim.opt.relativenumber = true
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
