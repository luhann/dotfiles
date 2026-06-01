-- More efficient keybindings
local map = vim.keymap.set
local builtin = require("telescope.builtin")

-- Better defaults
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
map("n", "n", "nzzzv", { desc = "Next result (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev result (centered)" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Quick save" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map({ "n", "v", "x" }, "<leader>y", '"+y', { desc = "System copy" })
map({ "n", "v", "x" }, "<leader>d", '"+d', { desc = "System delete" })
map({ "n", "v", "x" }, "<leader>p", '"+p', { desc = "System paste" })
map({ "n", "v", "x" }, "<leader>o", function()
  if vim.bo.buftype == "" then vim.cmd("set wrap!") end
end, { desc = "Toggle line wrap" })
-- remap normal mode command to semi-colon
map("n", ";", ":")

-- F11 toggles spellcheck
map({ "n", "i" }, "<F11>", function() vim.o.spell = not vim.o.spell end, { desc = "Toggle spellcheck" })

-- NvimTree
map("n", "<localleader>e", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

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

-- Inlay hints toggle
map("n", "<leader>ih", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
  { desc = "Toggle inlay hints" })

-- Standard LSP keybinds
map("n", "gd", builtin.lsp_definitions, { desc = "Go to definition" })
map("n", "gt", builtin.lsp_type_definitions, { desc = "Go to type definition" })
map("n", "gr", builtin.lsp_references, { desc = "Show references" })
map("n", "gi", builtin.lsp_implementations, { desc = "Go to implementation" })
map("n", "K", vim.lsp.buf.hover, { desc = "Show hover info" })
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
map({ "n", "v" }, "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map({ "n", "v" }, "<leader>lf", vim.lsp.buf.format, { desc = "Format code" })
map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Previous diagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next diagnostic" })
map("n", "[e", function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end, { desc = "Previous error" })
map("n", "]e", function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end, { desc = "Next error" })
map("n", "<leader>xl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

-- Telescope keybinds
map("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
map("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
map("n", "<leader>sd", builtin.lsp_document_symbols, { desc = "Document Symbols" })
map("n", "<leader>sw", builtin.lsp_dynamic_workspace_symbols, { desc = "Workspace Symbols" })
map("n", "<leader>xd", function() builtin.diagnostics({ bufnr = 0, sort_by = "severity" })end, { desc = "Buffer diagnostics" })
map("n", "<leader>xw", function() builtin.diagnostics({sort_by = "severity" })end, { desc = "Workspace diagnostics" })
