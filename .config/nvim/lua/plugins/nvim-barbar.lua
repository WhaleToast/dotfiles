return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  init = function() 
    vim.g.barbar_auto_setup = false 
  end,
  opts = {
    icons = {
      -- Configure the base icons on the bufferline.
      -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
      buffer_index = false,
      buffer_number = false,
      button = '',
      -- Enables / disables diagnostic symbols
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = {enabled = true, icon = 'ﬀ'},
        [vim.diagnostic.severity.WARN] = {enabled = false},
        [vim.diagnostic.severity.INFO] = {enabled = false},
        [vim.diagnostic.severity.HINT] = {enabled = true},
      },
      gitsigns = {
        added = {enabled = true, icon = '+'},
        changed = {enabled = true, icon = '~'},
        deleted = {enabled = true, icon = '-'},
      },
      filetype = {
        -- Sets the icon's highlight group.
        -- If false, will use nvim-web-devicons colors
        custom_colors = false,
        -- Requires `nvim-web-devicons` if `true`
        enabled = true,
      },
      separator = {left = '>', right = '<'},
      separator_at_end = false,
    },
    minimum_padding = 1,
    maximum_padding = 1,
    auto_hide = 1,
    hightlight_visible = true,
  },
  version = '^1.0.0', -- optional: only update when a new 1.x version is released
}
