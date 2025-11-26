return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim",
    {
      "echasnovski/mini.diff",
      config = function()
        require("mini.diff").setup({
          source = require("mini.diff").gen_source.none(),
        })
      end,
    },
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "copilot",
        },
        inline = {
          adapter = "copilot",
        },
        agent = {
          adapter = "copilot",
        },
      },

      display = {
        chat = {
          window = {
            layout = "vertical",
            width = 0.45,
            border = "rounded",
          },
        },
      },

      -- Prompt library for quick actions
      prompt_library = {
        ["Refactor Code"] = {
          strategy = "inline",
          description = "Refactor selected code",
          prompts = {
            {
              role = "system",
              content = "Refactor the code to improve readability, performance, and maintainability. Keep the same functionality.",
            },
          },
        },
        ["Fix Bug"] = {
          strategy = "chat",
          description = "Analyze and fix a bug",
          prompts = {
            {
              role = "system",
              content = "Analyze the code and error. Explain the bug, then provide a fix with explanation.",
            },
          },
        },
        ["Add Tests"] = {
          strategy = "inline",
          description = "Generate tests for code",
          prompts = {
            {
              role = "system",
              content = "Generate comprehensive unit tests for this code. Include edge cases and error scenarios.",
            },
          },
        },
        ["Explain Code"] = {
          strategy = "chat",
          description = "Explain selected code",
          prompts = {
            {
              role = "system",
              content = "Explain this code clearly. Include what it does, how it works, and any important considerations.",
            },
          },
        },
        ["Optimize"] = {
          strategy = "inline",
          description = "Optimize code performance",
          prompts = {
            {
              role = "system",
              content = "Optimize this code for better performance. Explain the improvements made.",
            },
          },
        },
        -- DevOps specific prompts
        ["Terraform Docs"] = {
          strategy = "chat",
          description = "Document Terraform module",
          prompts = {
            {
              role = "system",
              content = "Generate comprehensive documentation for this Terraform module including inputs, outputs, and usage examples.",
            },
          },
        },
        ["K8s Debug"] = {
          strategy = "chat",
          description = "Debug Kubernetes issues",
          prompts = {
            {
              role = "system",
              content = "Analyze this Kubernetes configuration or error. Explain the issue and provide a fix.",
            },
          },
        },
      },

      -- Slash commands with telescope integration
      slash_commands = {
        ["file"] = {
          opts = {
            provider = "telescope",
            max_lines = 1000,
          },
        },
        ["symbols"] = {
          opts = {
            provider = "telescope",
          },
        },
      },
    })

    -- Keymaps
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Core actions (like your original config)
    map({ "n", "v" }, "<Leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", opts)
    map({ "n", "v" }, "<Leader>ae", "<cmd>CodeCompanionActions<cr>", opts)
    map("v", "ga", "<cmd>CodeCompanionChat Add<cr>", opts)

    -- Inline edit (Cursor's Cmd+K equivalent)
    map({ "n", "v" }, "<Leader>ai", "<cmd>CodeCompanion<cr>", opts)

    -- Quick prompts for common tasks
    map("v", "<Leader>ar", function()
      require("codecompanion").prompt("Refactor Code")
    end, opts)

    map("v", "<Leader>af", function()
      require("codecompanion").prompt("Fix Bug")
    end, opts)

    map("v", "<Leader>at", function()
      require("codecompanion").prompt("Add Tests")
    end, opts)

    map("n", "<Leader>ax", function()
      require("codecompanion").prompt("Explain Code")
    end, opts)

    map("v", "<Leader>ao", function()
      require("codecompanion").prompt("Optimize")
    end, opts)

    -- Command abbreviations
    vim.cmd([[cab cc CodeCompanion]])
    vim.cmd([[cab cca CodeCompanionChat]])
  end,
}
