-- leader key
vim.g.mapleader = " "

-- keymap options
local opts = { noremap = true, silent = true}
local keymap = vim.keymap.set

-- save, quit, force quit
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>x", ":q!<CR>", opts)

-- yank to clipboard
keymap("n", "<leader>c", '"+y', opts)
keymap("v", "<leader>c", '"+y', opts)

-- Move to start/end of line
keymap("n", "H", "^", opts)
keymap("n", "L", "$", opts)

-- Select all
keymap("n", "<C-a>", "ggVG", opts)

-- Show lsp float 
keymap("n", "m", vim.diagnostic.open_float)
-- Clear search highlight
keymap("n", "<leader><space>", ":nohlsearch<CR>", opts)

-- Delete previous word in insert mode (Ctrl+Backspace)
keymap("i", "<C-H>", "<C-w>", opts)

-- Tab switching (fixed 'tabnet' → 'tabnext')
keymap("n", "<Tab>", ":tabnext<CR>", opts)
keymap("n", "<S-Tab>", ":tabprevious<CR>", opts)
keymap("n", "<leader>tn", ":tabnew<CR>", opts)
keymap("n", "<leader>tc", ":tabclose<CR>", opts)

-- Split navigation
keymap("n", "<A-Up>", "<Cmd>wincmd k<CR>", opts)
keymap("n", "<A-Down>", "<Cmd>wincmd j<CR>", opts)
keymap("n", "<A-Left>", "<Cmd>wincmd h<CR>", opts)
keymap("n", "<A-Right>", "<Cmd>wincmd l<CR>", opts)

-- open nvim-tree in the directory current file is in
vim.keymap.set("n", "<leader>f", function ()
  local api = require("nvim-tree.api")
  local path = vim.fn.expand("%:p:h")
  api.tree.open()
  api.tree.change_root(path)
  api.tree.find_file({ open = true, focus = true})
end)

-- Move Lines
-- Normal mode: move current line up or down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down", silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up", silent = true })

-- Visual mode: move selected lines up or down
vim.keymap.set("x", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
vim.keymap.set("x", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })

-- switch between splits
keymap("n", "<C-h>", "<Cmd>wincmd h<CR>", opts)
keymap("n", "<C-j>", "<Cmd>wincmd j<CR>", opts)
keymap("n", "<C-k>", "<Cmd>wincmd k<CR>", opts)
keymap("n", "<C-l>", "<Cmd>wincmd l<CR>", opts)

-- Move splits
vim.keymap.set("n", "<C-Left>", "<C-w>H", { desc = "Move window to left" })
vim.keymap.set("n", "<C-Down>", "<C-w>J", { desc = "Move window to bottom" })
vim.keymap.set("n", "<C-Up>", "<C-w>K", { desc = "Move window to top" })
vim.keymap.set("n", "<C-Right>", "<C-w>L", { desc = "Move window to right" })

-- telescope keybindings 
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- -- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

