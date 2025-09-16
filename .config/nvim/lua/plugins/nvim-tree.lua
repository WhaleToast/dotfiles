return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    on_attach = function(bufnr)
      local api = require("nvim-tree.api")
      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      api.config.mappings.default_on_attach(bufnr)
      vim.keymap.set("n", "s", api.node.open.vertical, opts("Open Vertical Split"))
      vim.keymap.set("n", "i", api.node.open.horizontal, opts("Open Horizontal Split"))
      vim.keymap.set("n", "t", api.node.open.tab, opts("Open in New Tab"))
    end,
    sort = {
      sorter = "case_sensitive",
    },
    view = {
      width = 30,
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = false,
      git_ignored = false,
    },
    update_focused_file = {
      enable = true,
      update_root = true,
    },
    git = {
      enable = true,
      ignore = false,
    },
  },
}

