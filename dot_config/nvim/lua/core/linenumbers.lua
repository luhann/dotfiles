-- Relative numbering in the focused window only.
--
-- 'number'/'relativenumber' are window-local, so these hang off window events.
-- BufEnter/BufLeave look equivalent but are not: neither fires when moving
-- between two windows showing the same buffer, which left the unfocused split
-- with relative numbers still on.
local linenumber = vim.api.nvim_create_augroup("linenumber", { clear = true })

-- Buffers that should carry no numbers at all: terminals, plugin UIs, prompts
local excluded_buftypes = {
  terminal = true,
  nofile = true,
  prompt = true,
}

local function apply(relative)
  if excluded_buftypes[vim.bo.buftype] then
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  else
    vim.opt_local.number = true
    vim.opt_local.relativenumber = relative
  end
end

vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter", "FocusGained", "InsertLeave" }, {
  group = linenumber,
  callback = function() apply(true) end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "FocusLost", "InsertEnter" }, {
  group = linenumber,
  callback = function() apply(false) end,
})
