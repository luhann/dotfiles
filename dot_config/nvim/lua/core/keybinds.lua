-- More efficient keybindings
local map = vim.keymap.set

-- Better defaults
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
map("n", "n", "nzzzv", { desc = "Next result (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev result (centered)" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Quick save" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map({ "n", "x" }, "<leader>y", '"+y', { desc = "System copy" })
map({ "n", "x" }, "<leader>d", '"+d', { desc = "System delete" })
map("n", "<leader>p", '"+p', { desc = "System paste" })
map("x", "<leader>p", '"+P', { desc = "System paste (keep register)" })
map("n", "dd", function()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return '"_dd'
  else
    return "dd"
  end
end, { expr = true, desc = "Smart dd" })
map({ "n", "x" }, "<leader>o", function()
  -- window-local: `set wrap!` also flips the global value, which then leaks
  -- into every buffer opened afterwards
  if vim.bo.buftype == "" then vim.wo.wrap = not vim.wo.wrap end
end, { desc = "Toggle line wrap" })
-- remap normal mode command to semi-colon
map("n", ";", ":")
map("n", ",", ";", { desc = "Repeat last f/t jump" })

-- F11 toggles spellcheck
map({ "n", "i" }, "<F11>", function() vim.o.spell = not vim.o.spell end, { desc = "Toggle spellcheck" })

-- File explorer
map("n", "<leader>e", function() Snacks.explorer() end, { desc = "Toggle explorer" })

-- Stay in visual mode when indenting
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move lines up/down
map("n", "<A-Down>", "<cmd>move .+1<CR>==", { desc = "Move line down" })
map("n", "<A-Up>", "<cmd>move .-2<CR>==", { desc = "Move line up" })
map("v", "<A-Down>", ":move '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-Up>", ":move '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Centre view on half-page jumps
map("n", "<C-d>", "<C-d>zz", { desc = "Half-page down (centred)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half-page up (centred)" })

-- Better window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Terminal keybinds
map("n", "<leader>th", ":split | terminal<CR>", { desc = "Terminal Horizontal" })
map("n", "<leader>tv", ":vsplit | terminal<CR>", { desc = "Terminal Vertical" })
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit Terminal Mode" })

-- Replace submenu
map("n", "<leader>rs", ":%s/\\<<C-r><C-w>\\>/", { desc = "Search/Replace word under cursor" })
map("v", "<leader>r", [[:s/\%V]], { desc = "Search/Replace inside selection" })

-- Inlay hints toggle
map("n", "<leader>ih", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
  { desc = "Toggle inlay hints" })

-- Runs the 'makeprg' (default is 'make')
map("n", "<leader>bc", "<cmd>make<CR>", { desc = "Build project" })

-- Standard LSP keybinds
map("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Go to definition" })
map("n", "gt", function() Snacks.picker.lsp_type_definitions() end, { desc = "Go to type definition" })
map("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "Show references" })
map("n", "gi", function() Snacks.picker.lsp_implementations() end, { desc = "Go to implementation" })
-- K is left alone: nvim maps it to vim.lsp.buf.hover on attach, but only where
-- 'keywordprg' is still the default, so :help/man lookups survive elsewhere
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
map({ "n", "v" }, "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map({ "n", "v" }, "<leader>lf", vim.lsp.buf.format, { desc = "Format code" })
map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Previous diagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next diagnostic" })
map("n", "[e", function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end,
  { desc = "Previous error" })
map("n", "]e", function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end,
  { desc = "Next error" })
map("n", "<leader>xl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

-- Picker keybinds
map("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find files" })
map("n", "<leader>fg", function() Snacks.picker.grep() end, { desc = "Live grep" })
map("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>fh", function() Snacks.picker.help() end, { desc = "Help tags" })
map("n", "<leader>fr", function() Snacks.picker.resume() end, { desc = "Resume last search" })
map("n", "<leader>sd", function() Snacks.picker.lsp_symbols() end, { desc = "Document Symbols" })
map("n", "<leader>sw", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "Workspace Symbols" })
map("n", "<leader>xd", function() Snacks.picker.diagnostics_buffer() end,
  { desc = "Buffer diagnostics" })
map("n", "<leader>xw", function() Snacks.picker.diagnostics() end, { desc = "Workspace diagnostics" })
