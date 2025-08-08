
-- Toggle relative numbering on buffer events
local linenumber = vim.api.nvim_create_augroup("linenumber", { clear = true })

-- Helper function to check if the buffer should be ignored
local function should_ignore_buffer()
  local excluded_buftypes = {
    terminal = true, -- For built-in terminals
    nofile = true,   -- For buffers without a file, like help pages or plugin UIs
    prompt = true,   -- For prompt buffers
  }
  -- Return true if the buffer type is in our exclusion list
  return excluded_buftypes[vim.bo.buftype]
end

-- Turns ON relative numbers when you enter a normal buffer
vim.api.nvim_create_autocmd("BufEnter", {
  group = linenumber,
  callback = function()
    if not should_ignore_buffer() then
      vim.opt_local.relativenumber = true
      vim.opt_local.number = true
    end
  end,
})

-- Turns OFF relative numbers when leaving a buffer or entering insert mode
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
  group = linenumber,
  callback = function()
    if not should_ignore_buffer() then
      vim.opt_local.relativenumber = false
      -- vim.opt_local.number remains true
    end
  end,
})

-- Define a group to manage the autocommand and prevent duplication
local nolinenumber = vim.api.nvim_create_augroup("nolinenumber", { clear = true })

-- Single autocommand to disable line numbers in specific buffer types
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = nolinenumber,
  pattern = "*",
  callback = function()
    -- Check if the current buffer's type is in our ignore list
    if should_ignore_buffer() then
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
    end
  end,
})