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
  "nvim-lualine/lualine.nvim",
  "nvim-tree/nvim-web-devicons",

  -- Editor enhancements
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },
  {
    -- picker (replaces telescope) and explorer (replaces nvim-tree)
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = {
        -- mirrors snacks' own hook, minus the mini.* flags, plus spell:
        -- 'spell' is set globally and is pure overhead on a 7MB data file
        setup = function(ctx)
          if vim.fn.exists(":NoMatchParen") ~= 0 then
            vim.cmd([[NoMatchParen]])
          end
          Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0, spell = false })
          vim.b.completion = false
          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(ctx.buf) then
              vim.bo[ctx.buf].syntax = ctx.ft
            end
          end)
        end,
      },
      explorer = {},
      picker = {
        sources = {
          explorer = {
            -- the sidebar preset has a 40-column minimum; drop it so 15% applies
            layout = { layout = { width = 0.15, min_width = 20 } },
          },
        },
      },
    },
  },

  {
    -- sign column + hunk counts. The GitSigns* highlight groups are already
    -- defined by the patroclus colorscheme.
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  -- Language support
  {
    -- main branch only installs parsers; highlight/indent are started below
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")
      local languages = {
        -- prose and documents
        "markdown", "markdown_inline", "latex", "rnoweb", "typst", "vimdoc",
        -- languages
        "r", "python", "rust", "c", "lua", "haskell", "bash", "fish",
        -- web (zola templates, patroclus stylesheets)
        "html", "css", "scss",
        -- data and config
        "csv", "tsv", "json", "yaml", "toml", "xml", "ini",
        "hyprlang", "rasi", "ssh_config", "just", "make",
        -- version control. jjdescription for the colocated jj repos
        "diff", "gitcommit", "gitignore", "jjdescription",
        -- injected into string literals elsewhere
        "regex",
      }
      ts.install(languages)

      local declared = {}
      for _, lang in ipairs(languages) do
        declared[lang] = true
      end

      local function attach(buf, lang)
        if not (vim.api.nvim_buf_is_valid(buf) and pcall(vim.treesitter.start, buf, lang)) then
          return false
        end
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        return true
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(ev.match)
          -- only ever install what is declared above: installing anything
          -- merely *available* meant opening a stray filetype git-cloned and
          -- compiled a parser mid-session
          if not attach(ev.buf, lang) and lang and declared[lang] then
            ts.install(lang):await(vim.schedule_wrap(function() attach(ev.buf, lang) end))
          end
        end,
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
        bracketed_paste = true,
        min_editor_width = 72,
        rconsole_width = 78,
        objbr_mappings = {                                -- Object browser keymap
          c = 'class',                                    -- Call R functions
          ['<localleader>gg'] = 'head({object}, n = 15)', -- Use {object} notation to write arbitrary R code.
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
    -- Configures lua_ls with the Neovim runtime lazily, per module actually
    -- used, instead of indexing the whole runtime up front
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {},
  },
  {
    "saghen/blink.cmp",
    version = '1.*',
    opts = {
      keymap = { preset = 'super-tab' },
      fuzzy = {
        implementation = "rust",
      },
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority
            score_offset = 100,
          },
        },
      },
    },
  }
})

vim.lsp.inlay_hint.enable(true)
vim.lsp.enable("air")
vim.lsp.enable("jarl")
vim.lsp.enable("hls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("texlab")
vim.lsp.enable("tinymist")
vim.lsp.enable("ty")
vim.lsp.enable("ruff")

vim.lsp.config("jarl", {
  cmd = { 'jarl', 'server' },
  filetypes = { 'r', 'rmd', 'quarto' },
  on_attach = function(client, bufnr)
    -- Tell Neovim NOT to use Jarl for general file formatting
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      -- runtime/library setup is handled lazily by lazydev.nvim
      workspace = {
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

vim.lsp.config("rust_analyzer", {
  capabilities = {
    experimental = { serverStatusNotification = true },
  },
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
    exportPdf = "onSave",
    semanticTokens = "disable"
  }
})

vim.diagnostic.config({
  -- no `format`: supplying one deepcopies every diagnostic on each redraw,
  -- and the default already renders `message`
  virtual_text = { virt_text_pos = "eol_right_align" },
  underline = true,
  float = { border = "rounded", source = "if_many" },
})

-- Diagnostic virtual text is coloured by the patroclus colorscheme.

vim.opt.undofile = true

vim.opt.colorcolumn = "120"
vim.opt.showmatch = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.spell = true
vim.opt.spelllang = "en_gb"
vim.opt.spellsuggest = "best"
vim.opt.pumheight = 10

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, { command = "checktime" })

-- Briefly highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.hl.on_yank() end,
})

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = false

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = false
vim.opt.foldnestmax = 4

-- patroclus: generated from ~/dev/patroclus/design.yaml, so the editor,
-- the statusline and the terminal all read from one palette.
vim.cmd.colorscheme("patroclus")

-- core functionality
require("core.keybinds")
require("core.linenumbers")
require("core.filetypes")
-- galaxyline theme
require("plugins.galactus")
