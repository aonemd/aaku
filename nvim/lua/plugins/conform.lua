return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua             = { "stylua" },
        go              = { "goimports", "gofmt" },
        rust            = { "rustfmt", lsp_format = "fallback" },
        ruby            = { "rubocop" },
        javascript      = { "prettier" },
        typescript      = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
      },
      format_on_save = {
        lsp_format = "fallback",
        timeout_ms = 500,
        async = false,
      },
    })
  end,
}
