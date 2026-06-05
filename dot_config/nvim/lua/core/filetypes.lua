-- Override template filetype for chezmoi files in dotfiles directory
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'template',
  callback = function()
    local filepath = vim.fn.expand('%:p')
    local filename = vim.fn.expand('%:t')

    -- Only override if it's in dotfiles directory and matches our pattern
    if filepath:match(vim.fn.expand('~') .. '/dotfiles/') and filename:match('%..*%.tmpl$') then
      local base_ext = filename:match('%.([^%.]+)%.tmpl$')
      if base_ext then
        vim.bo.filetype = base_ext
      end
    end
  end,
})

-- Auto-set compiler for specific languages
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function() vim.opt_local.makeprg = "cargo build" end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function() vim.opt_local.makeprg = "make" end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function() vim.opt_local.makeprg = "python3 %" end, -- Runs current file
})
