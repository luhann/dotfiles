-- chezmoi templates keep the base extension's filetype: dot_gitconfig.tmpl
-- stays `template`, but .chezmoi.yaml.tmpl becomes `yaml`.
--
-- Resolved during detection rather than patched afterwards in a FileType
-- autocmd, which had to reassign 'filetype' mid-event (re-triggering FileType,
-- and looping outright on a name like foo.template.tmpl). Patterns with
-- non-negative priority are matched ahead of the `tmpl = 'template'` extension
-- rule, and returning nil here falls back to it.
vim.filetype.add({
  pattern = {
    ['.*/dotfiles/.*%.tmpl'] = function(path)
      return path:match('%.([^%./]+)%.tmpl$')
    end,
  },
})

-- Auto-set compiler for specific languages
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function() vim.opt_local.makeprg = "make" end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "haskell",
  callback = function() vim.opt_local.makeprg = "cabal build" end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function() vim.opt_local.makeprg = "python3 %" end, -- Runs current file
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function() vim.opt_local.makeprg = "cargo build" end,
})

