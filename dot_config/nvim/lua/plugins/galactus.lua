-- Eviline config for lualine
-- Author: luhann
-- Credit: glepnir
local lualine = require('lualine')

-- Hide Neovim's default mode text (e.g. -- INSERT --) when using a statusline.
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.shortmess:append('q')

-- Palette and lualine theme come from the generated patroclus module, so the
-- bar cannot drift from the editor. Change design.yaml, regenerate, apply.
local patroclus = require("patroclus")
local colors = patroclus.colors

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  -- globalstatus: the statusline spans the whole screen, not the current window
  hide_in_width = function()
    return vim.o.columns > 80
  end,
}

-- Config
local config = {
  options = {
    disabled_filetypes = { 'snacks_layout_box', 'snacks_picker_list', 'snacks_picker_input', 'Lazy' },
    globalstatus = true,
    always_divide_middle = true,
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    -- lualine_c and lualine_x act as the left and right sections; both are
    -- highlighted by the theme's `c` entry.
    theme = patroclus.lualine,
    refresh = {
      -- lualine's defaults plus LspProgress. lualine pushes a precomputed
      -- string into 'statusline' rather than an expression, so :redrawstatus
      -- cannot re-run the LSP component -- only a refresh can.
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
        'LspProgress',
      },
    },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  -- No inactive_sections: globalstatus draws one bar, always for the focused
  -- window, so lualine never consults them.
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
  function()
    return '☰'
  end,
  color = { fg = colors.blue }, -- Primary accent color
  padding = { left = 0, right = 1 },
}

ins_left {
  -- mode component
  function()
    return ''
  end,
  color = function()
    -- auto change color according to neovims mode, from the patroclus palette
    local mode_color = {
      n = colors.blue,    -- Normal: blue accent
      i = colors.green,   -- Insert: green
      v = colors.magenta, -- Visual: pink
      [string.char(22)] = colors.magenta, -- Visual block
      V = colors.magenta,
      c = colors.yellow, -- Command: yellow
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [string.char(19)] = colors.orange, -- Select block
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.teal, -- Terminal: teal
    }
    return { fg = mode_color[vim.fn.mode()] or colors.fg }
  end,
  padding = { right = 1 },
}

ins_left {
  -- filesize component
  'filesize',
  cond = conditions.buffer_not_empty,
  color = { fg = colors.subtext },
}

ins_left {
  'filename',
  cond = conditions.buffer_not_empty,
  path = 1,
  shorting_target = 40,
  symbols = {
    modified = ' [+]',
    readonly = ' [RO]',
    unnamed = '[No Name]',
    newfile = ' [New]',
  },
  color = { fg = colors.cyan, gui = 'bold' }, -- Sky blue for filename
}

ins_left {
  'location',
  color = { fg = colors.subtext }
}

ins_left {
  'progress',
  color = { fg = colors.fg, gui = 'bold' }
}

ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  update_in_insert = false,
  symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
  diagnostics_color = {
    error = { fg = colors.red },
    warn = { fg = colors.yellow },
    info = { fg = colors.cyan },
    hint = { fg = colors.teal },
  },
}

-- Insert mid section
ins_left {
  function()
    return '%='
  end,
}

ins_left {
  -- Lsp server names, or their progress while they're busy (e.g. rust-analyzer indexing)
  function()
    local progress = vim.lsp.status()
    if progress ~= '' then
      -- by character, not byte: progress messages can carry non-ASCII paths
      return vim.fn.strcharpart(progress, 0, 60)
    end
    local clients = vim.lsp.get_clients { bufnr = 0 }
    if next(clients) == nil then
      return 'No Active Lsp'
    end
    local names, seen = {}, {}
    for _, client in ipairs(clients) do
      if not seen[client.name] then
        seen[client.name] = true
        table.insert(names, client.name)
      end
    end
    table.sort(names)
    return table.concat(names, ', ')
  end,
  icon = ' LSP:',
  color = { fg = colors.teal, gui = 'bold' }, -- Teal for LSP info
}

-- Add components to right sections
ins_right {
  'searchcount',
  maxcount = 999,
  timeout = 500,
  cond = conditions.hide_in_width,
  color = { fg = colors.subtext },
}

ins_right {
  'filetype',
  colored = true,
  cond = conditions.buffer_not_empty,
}

-- Encoding/format act as anomaly flags: only shown when not the usual utf-8/unix
ins_right {
  'encoding',
  fmt = string.upper,
  cond = function()
    local fenc = vim.bo.fileencoding
    return fenc ~= '' and fenc ~= 'utf-8'
  end,
  color = { fg = colors.orange, gui = 'bold' },
}

ins_right {
  'fileformat',
  fmt = string.upper,
  icons_enabled = false,
  cond = function()
    return vim.bo.fileformat ~= 'unix'
  end,
  color = { fg = colors.orange, gui = 'bold' },
}

ins_right {
  function()
    return 'REC @' .. vim.fn.reg_recording()
  end,
  cond = function()
    return vim.fn.reg_recording() ~= ''
  end,
  color = { fg = colors.red, gui = 'bold' },
}

ins_right {
  -- no cond: the component watches .git/HEAD itself and renders '' outside a repo
  'branch',
  color = { fg = colors.violet, gui = 'bold' },
}

ins_right {
  'diff',
  symbols = { added = '+', modified = 'm', removed = '-' },
  -- gitsigns already tracks hunk counts per buffer; without a source lualine
  -- spawns `git diff --shortstat` jobs of its own to recompute them
  source = function()
    local gs = vim.b.gitsigns_status_dict
    if gs then
      return { added = gs.added, modified = gs.changed, removed = gs.removed }
    end
  end,
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

-- ▊
ins_right {
  function()
    return '☰'
  end,
  color = { fg = colors.blue },
  padding = { left = 1 },
}

-- Now don't forget to initialize lualine
lualine.setup(config)
