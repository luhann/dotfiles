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
  { "rose-pine/neovim", name = "rose-pine" },
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
  "lervag/vimtex",
  "glepnir/galaxyline.nvim",
  "nvim-tree/nvim-web-devicons",
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "r", "markdown", "markdown_inline", "rnoweb", "python", "c", "lua", "yaml"},
          sync_install = false,
          auto_install = true,
          highlight = { enable = true, disable = {"latex"} },
          indent = { enable = true },
        })
    end
 },
{
    "R-nvim/R.nvim",
    lazy = false
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
  },
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

require'lspconfig'.r_language_server.setup{capabilities = capabilities}

-- options for vimtex compilation and viewing
vim.g.vimtex_compiler_progname = "nvr"
vim.g.vimtex_view_method = "zathura"
vim.g.tex_conceal = "abdmg"

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

vim.api.nvim_command("hi StatusLine guibg=#202328")
vim.api.nvim_command("hi Normal ctermbg=none guibg=none")
vim.api.nvim_command("colorscheme rose-pine")

-- set keybindings
-- remap normal mode command to semi-colon
vim.keymap.set("n", ";", ":")
-- F11 toggles spellcheck
vim.keymap.set("n", "<F11>", function() vim.o.spell = not vim.o.spell end)
vim.keymap.set("i", "<F11>", function() vim.o.spell = not vim.o.spell end)


-- Toggle relative numbering on buffer events
local linenumber = vim.api.nvim_create_augroup("linenumber", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
  group = linenumber,
  callback = function(args)
    if (vim.bo.buftype ~= "terminal") then
      vim.opt_local.relativenumber = true
      vim.opt_local.number = true
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
  group = linenumber,
  callback = function(args)
    if (vim.bo.buftype ~= "terminal") then
      vim.opt_local.relativenumber = false
      vim.opt_local.number = true
    end
  end,
})

-- make sure line numbers never appear in terminal
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  callback = function(args)
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
  end,
})

-- galaxyline theme
require("galactus")
