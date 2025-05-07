return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Python LSP
      lspconfig.pylsp.setup {
        capabilities = capabilities,
        settings = {
          pylsp = {
            plugins = {
              pyflakes = { enabled = true },
              pycodestyle = { enabled = true },
              pylsp_mypy = { enabled = false },
              pyls_isort = { enabled = true },
              rope = { enabled = true },
            }
          }
        }
      }
    end,
  },
}

