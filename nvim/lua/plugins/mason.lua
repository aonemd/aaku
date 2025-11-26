return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        'clangd',
        'rust_analyzer',
        'gopls',
        'kotlin_language_server',
        'jsonls',
        'marksman',
        'terraformls',
        'tflint',
        'yamlls',
        'marksman',

        "graphql",
        "ts_ls",
        "html",
        "cssls",
        "tailwindcss",
        "lua_ls",
        "emmet_ls",
        "eslint",
      },
    },
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        },
      },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- "eslint-lsp", -- not LSP
        -- "prettierd", -- not LSP
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "eslint_d",
      },
    },
    dependencies = {
      "williamboman/mason.nvim",
    },
  },
}
