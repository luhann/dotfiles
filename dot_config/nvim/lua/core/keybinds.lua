-- More efficient keybindings
local map = vim.keymap.set

-- Better defaults
map("n", "<Esc>", "<cmd>nohlsearch<CR>")  -- Clear search highlights
map("n", "<leader>w", "<cmd>w<CR>")       -- Quick save
map("n", "<leader>q", "<cmd>q<CR>")

-- remap normal mode command to semi-colon
map("n", ";", ":")

-- F11 toggles spellcheck
map("n", "<F11>", function() vim.o.spell = not vim.o.spell end)
map("i", "<F11>", function() vim.o.spell = not vim.o.spell end)

-- NvimTree
map("n", "<localleader>e", ":NvimTreeToggle<CR>")

-- Better window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")