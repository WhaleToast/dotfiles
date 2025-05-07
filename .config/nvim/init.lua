vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.cmd("Explore")
    end
  end
})

-- Plugin loader
require("config.lazy")

-- Leader key
vim.g.mapleader = " "

-- Clipboard
-- vim.opt.clipboard:append("unnamedplus")

-- Line numbers
vim.opt.number = true

-- Keymap options
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- Yank to clipboard
keymap("n", "<leader>c", '"+y', opts)
keymap("v", "<leader>c", '"+y', opts)

-- Save / Quit
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>x", ":wq<CR>", opts)

-- Move to start/end of line
keymap("n", "H", "^", opts)
keymap("n", "L", "$", opts)

-- Select all
keymap("n", "<C-a>", "ggVG", opts)

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

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>f", ":NvimTreeFindFile<CR>", opts)

-- Move Lines
-- Normal mode: move current line up or down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down", silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up", silent = true })

-- Visual mode: move selected lines up or down
vim.keymap.set("x", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
vim.keymap.set("x", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })


-- NvimTree split behavior
local function my_on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set("n", "s", api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set("n", "i", api.node.open.horizontal, opts("Open: Horizontal Split"))
  vim.keymap.set("n", "t", api.node.open.tab, opts("Open: Open in New Tab"))
end

require("nvim-tree").setup({
  on_attach = my_on_attach,
  view = {
    width = 30,
  },
})
keymap("n", "<C-h>", "<Cmd>wincmd h<CR>", opts)
keymap("n", "<C-j>", "<Cmd>wincmd j<CR>", opts)
keymap("n", "<C-k>", "<Cmd>wincmd k<CR>", opts)
keymap("n", "<C-l>", "<Cmd>wincmd l<CR>", opts)

-- Treesitter highlight overrides (Dracula-inspired, no italics)
local dracula_ts_colors = {
  ["@comment"]         = { fg = "#6272a4" },
  ["@keyword"]         = { fg = "#ff79c6" },
  ["@keyword.function"]= { fg = "#ff79c6" },
  ["@function"]        = { fg = "#50fa7b", bold = true },
  ["@function.builtin"]= { fg = "#8be9fd" },
  ["@variable"]        = { fg = "#f8f8f2" },
  ["@variable.builtin"]= { fg = "#bd93f9" },
  ["@parameter"]       = { fg = "#f8f8f2" },
  ["@field"]           = { fg = "#f1fa8c" },
  ["@property"]        = { fg = "#f1fa8c" },
  ["@type"]            = { fg = "#8be9fd", bold = true },
  ["@type.builtin"]    = { fg = "#ffb86c" },
  ["@number"]          = { fg = "#bd93f9" },
  ["@string"]          = { fg = "#f1fa8c" },
  ["@boolean"]         = { fg = "#ffb86c" },
  ["@operator"]        = { fg = "#ff79c6" },
  ["@punctuation"]     = { fg = "#f8f8f2" },
  ["@constructor"]     = { fg = "#ffb86c" },
}

for group, opts in pairs(dracula_ts_colors) do
  vim.api.nvim_set_hl(0, group, opts)
end

vim.opt.relativenumber = true
vim.opt.scrolloff = 10

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
