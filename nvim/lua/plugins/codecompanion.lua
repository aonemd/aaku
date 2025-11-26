return {
  "olimorris/codecompanion.nvim",
  opts = {
    strategies = {
      chat = {
        name = "copilot",
        model = "gpt-4.1",
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "echasnovski/mini.diff",
      config = function()
        local diff = require("mini.diff")
        diff.setup({
          -- Disabled by default
          source = diff.gen_source.none(),
        })
      end,
    },
  },
  config = function ()
    require("codecompanion").setup()

    vim.keymap.set({ "n", "v" }, "<Leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
    vim.keymap.set({ "n", "v" }, "<Leader>ae", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
    vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd([[cab cc CodeCompanion]])
  end
}
