-- More efficient keybindings
local map = vim.keymap.set

-- Better defaults
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
map("n", "n", "nzzzv", { desc = "Next result (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev result (centered)" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Quick save" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map({"n", "v", "x"}, "<leader>y", '"+y<CR>', {desc = "System copy"})
map({"n", "v", "x"}, "<leader>d", '"+d<CR>', {desc = "System delete"})

-- remap normal mode command to semi-colon
map("n", ";", ":")

-- F11 toggles spellcheck
map({"n", "i"}, "<F11>", function() vim.o.spell = not vim.o.spell end , { desc = "Toggle spellcheck" })

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

-- Better window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Inlay hints toggle
map("n", "<leader>ih", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end , { desc = "Toggle inlay hints" })

-- Standard LSP keybinds
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Show references" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "K", vim.lsp.buf.hover, { desc = "Show hover info" })
map({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
map({"n", "v"}, "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map({"n", "v"}, "<leader>lf", vim.lsp.buf.format, { desc = "Format code" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
