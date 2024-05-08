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
  "itchyny/lightline.vim",
  "rebelot/kanagawa.nvim",
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "r", "python", "c", "lua", "vim", "vimdoc", "javascript", "html" },
          sync_install = false,
          auto_install = true,
          highlight = { enable = true },
          indent = { enable = true },
        })
    end
 }
})

-- Set colorscheme
vim.cmd.colorscheme("kanagawa-dragon")

vim.g.lightline = {
  colorscheme = "darcula"
}

-- options for vimtex compilation and viewing
vim.g.vimtex_compiler_progname = "nvr"
vim.g.vimtex_view_method = "zathura"

vim.opt.showmatch = true
vim.opt.relativenumber = true
vim.opt.spell = true
vim.opt.spelllang = "en_gb"
vim.opt.spellsuggest = "best"
vim.opt.pumheight = 10

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.autoread = true

vim.opt.syntax = "on"

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
      vim.opt_local.number = false
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