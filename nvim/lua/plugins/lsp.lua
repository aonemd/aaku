local require_safe = require("utils").require_safe

local mason           = require_safe("mason")
local mason_lspconfig = require_safe("mason-lspconfig")
local lspconfig       = require_safe("lspconfig")
local root_pattern    = lspconfig.util.root_pattern

mason.setup()
mason_lspconfig.setup({
  ensure_installed = {
    "clangd",
    "rust_analyzer",
    "gopls",
    "kotlin_language_server",
    "jsonls",
    "marksman",
    "terraformls",
    "tflint",
    "yamlls",
    "marksman",
    -- "eslint-lsp", -- not LSP
    -- "prettierd", -- not LSP
  },
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', 'gcq', vim.diagnostic.setloclist, opts)

local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end
sign({ name = 'DiagnosticSignError', text = '✘' })
sign({ name = 'DiagnosticSignWarn', text = '▲' })
sign({ name = 'DiagnosticSignHint', text = '⚑' })
sign({ name = 'DiagnosticSignInfo', text = '' })

vim.diagnostic.config({
  virtual_text     = false,
  signs            = true,
  underline        = true,
  update_in_insert = false,
  severity_sort    = true,

  float = {
    focusable = false,
    style     = "minimal",
    border    = 'rounded',
    source    = 'always',
    header    = '',
    prefix    = '',
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = 'rounded' }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = 'rounded' }
)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufmap = function(mode, lhs, rhs)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set(mode, lhs, rhs, bufopts)
  end
  bufmap('n', 'gD', vim.lsp.buf.declaration)
  bufmap('n', 'gd', vim.lsp.buf.definition)
  bufmap('n', 'K', vim.lsp.buf.hover)
  bufmap('n', 'gi', vim.lsp.buf.implementation)
  bufmap('n', 'gr', vim.lsp.buf.references)
  bufmap('n', 'gtd', vim.lsp.buf.type_definition)
  bufmap('n', 'gsh', vim.lsp.buf.signature_help)
  bufmap('n', 'gcr', vim.lsp.buf.rename)
  bufmap('n', 'gca', vim.lsp.buf.code_action)
  bufmap('n', 'gcf', function() vim.lsp.buf.format { async = true } end)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig.util.default_config.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

require("mason-lspconfig").setup_handlers {
  function(server_name)
    local options = {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      },
    }

    require("lspconfig")[server_name].setup(options)
  end,
}

require("typescript-tools").setup({
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  settings = {
    -- spawn additional tsserver instance to calculate diagnostics on it
    separate_diagnostic_server = true,
    -- "change"|"insert_leave" determine when the client asks the server about diagnostic
    publish_diagnostic_on = "insert_leave",
    -- array of strings("fix_all"|"add_missing_imports"|"remove_unused")
    -- specify commands exposed as code_actions
    expose_as_code_action = { "fix_all","add_missing_imports","remove_unused" },
    -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
    -- not exists then standard path resolution strategy is applied
    tsserver_path = nil,
    -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
    -- (see 💅 `styled-components` support section)
    tsserver_plugins = {},
    -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
    -- memory limit in megabytes or "auto"(basically no limit)
    tsserver_max_memory = "auto",
    -- described below
    tsserver_format_options = {},
    tsserver_file_preferences = {},
  },
})
