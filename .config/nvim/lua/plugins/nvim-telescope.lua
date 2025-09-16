return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim'},
  config = function ()
    require('telescope').setup({
      defaults = {
        mappings = {
          i = {
            -- Insert mode mappings
            ["<C-s>"] = "select_vertical",
            ["<C-x>"] = "select_horizontal",
            ["<C-t>"] = "select_tab",
            ["<C-d>"] = require('telescope.actions').delete_buffer
          },
          n = {
           -- Insert mode mappings
            ["<C-s>"] = "select_vertical",
            ["<C-x>"] = "select_horizontal",
            ["<C-t>"] = "select_tab",
            ["<C-d>"] = require('telescope.actions').delete_buffer
          },
        }
      }
    })
  end
}
