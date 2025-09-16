
-- Plugin loader
require("config.lazy")
-- load others
require("config/keymap")

-- Keymap options
local vim = vim
local keymap = vim.keymap.set


-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 15



-- NvimTreeOpen to open specific directory
keymap("n", "<leader>d", function()
  local input = vim.fn.input("Directory: ", "", "dir")
  if input ~= "" then
    require("nvim-tree.api").tree.open({ path = input })
  end
end)


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


