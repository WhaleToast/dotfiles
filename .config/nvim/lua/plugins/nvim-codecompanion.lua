return {
  {
    "olimorris/codecompanion.nvim",
    event = { "BufRead", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim", 
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          http = {
            ollama = function()
              return require("codecompanion.adapters").extend("ollama", {
                schema = {
                  model = {
                    default = "qwen3-coder:30b"
                  },
                },
                parameters = {
                  stream = true,
                  temperature = 0.2,
                  num_predict = 2048,
                  num_ctx = 4096,
                  -- top_p = 0.9,
                  -- top_k = 40,
                },
              })
            end,
          },
        },
        strategies = {
          chat = { 
            adapter = "ollama",
          },
          inline = {
            adapter = "ollama",
            opts = {
              placement = "cursor", -- Force inline placement
              auto_submit = true,
            },
          },
        },
        -- Custom prompts for better control
        prompts = {
          ["Inline Code"] = {
            strategy = "inline",
            description = "Generate code at cursor position",
            opts = {
              index = 1,
              short_name = "code",
              auto_submit = true,
              placement = "cursor",
            },
            prompts = {
              {
                role = "system",
                content = "You are a code generator. Generate clean, functional code that should be inserted at the current cursor position. Do not create new files or provide explanations. Return only the code to insert.",
                opts = { visible = false },
              },
              {
                role = "user", 
                content = function(context)
                  return "Generate code: " .. context.input
                end,
              },
            },
          },
          ["Fix Code"] = {
            strategy = "inline",
            description = "Fix selected code",
            opts = {
              index = 2,
              short_name = "fix",
              auto_submit = true,
              placement = "replace",
              modes = { "v" }, -- Only in visual mode
            },
            prompts = {
              {
                role = "system",
                content = "Fix the provided code. Return only the corrected code without explanations.",
                opts = { visible = false },
              },
              {
                role = "user",
                content = function(context)
                  local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                  return "Fix this code:\n\n```" .. context.filetype .. "\n" .. code .. "\n```"
                end,
              },
            },
          },
          ["Implement Comment"] = {
            strategy = "inline",
            description = "Implement selected comment as code",
            opts = {
              index = 3,
              short_name = "implement",
              auto_submit = true,
              placement = "replace",
              modes = { "v" },
            },
            prompts = {
              {
                role = "system",
                content = "Convert the provided comment or description into working code. Replace the comment with functional code. Return only the code implementation.",
                opts = { visible = false },
              },
              {
                role = "user",
                content = function(context)
                  local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                  return "Implement this comment as code:\n\n" .. code
                end,
              },
            },
          },
        },
        opts = {
          system_prompt = "You are a code generator. Provide only code without explanations, comments, or descriptions. Be concise and direct.",
        }
      })
      
      -- Enhanced keybindings with auto-escape from visual mode
      vim.keymap.set({"n", "v"}, "<leader>cc", "<cmd>CodeCompanionChat<cr>", { desc = "AI Chat" })
      vim.keymap.set({"n", "v"}, "<leader>ca", "<cmd>CodeCompanionActions<cr>", { desc = "AI Actions" })
      vim.keymap.set({"n", "v"}, "<leader>ct", "<cmd>CodeCompanionToggle<cr>", { desc = "AI Toggle" })
      
      -- Inline code generation (guaranteed inline)
      vim.keymap.set("n", "<leader>ci", "<cmd>CodeCompanion /code<cr>", { desc = "Generate Code Inline" })
      
      -- Quick fix for selected code (auto-escape visual mode)
      vim.keymap.set("v", "<leader>cf", function()
        vim.cmd("CodeCompanion /fix")
        -- Return to normal mode after command
        vim.defer_fn(function()
          vim.cmd("normal! <Esc>")
        end, 50)
      end, { desc = "Fix Selected Code" })
      
      -- Implement selected comment (auto-escape visual mode)
      vim.keymap.set("v", "<leader>cI", function()
        vim.cmd("CodeCompanion /implement")
        -- Return to normal mode after command
        vim.defer_fn(function()
          vim.cmd("normal! <Esc>")
        end, 50)
      end, { desc = "Implement Selected Comment" })
      
      -- Direct inline prompt (with input)
      vim.keymap.set("n", "<leader>cp", function()
        vim.ui.input({ prompt = "Generate code: " }, function(input)
          if input then
            vim.cmd("CodeCompanion /code " .. input)
          end
        end)
      end, { desc = "Prompt for Inline Code" })
      
      -- Context-aware inline generation (improved visual mode handling)
      vim.keymap.set({"n", "v"}, "<leader>cg", function()
        local mode = vim.fn.mode()
        if mode == "v" or mode == "V" then
          vim.cmd("CodeCompanion implement the selected comment or improve this code")
          -- Return to normal mode after visual mode command
          vim.defer_fn(function()
            vim.cmd("normal! <Esc>")
          end, 50)
        else
          vim.cmd("CodeCompanion add appropriate code at cursor position")
        end
      end, { desc = "Context-aware Code Generation" })
    end,
  }
}
