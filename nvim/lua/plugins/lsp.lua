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
    "jdtls",
    "kotlin_language_server",
    "sumneko_lua",
    "tsserver",
    "eslint",
    "jsonls",
    "marksman",
    "terraformls",
    "tflint",
    "yamlls",
  },
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', 'gcq', vim.diagnostic.setloclist, opts)

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
  {border = 'rounded'}
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {border = 'rounded'}
)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("Format", { clear = true }),
      buffer = bufnr,
      callback = function() vim.lsp.buf.format() end
    })
  end

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
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require("mason-lspconfig").setup_handlers {
  function (server_name)
    local options = {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      },
    }

    if server_name == 'jdtls' or server_name == 'kotlin_language_server' then
      options.root_dir = root_pattern(".git")
    end

    if server_name == 'tsserver' then
      options.filetypes = { "typescript", "typescriptreact", "typescript.tsx" }
      options.cmd       = { "typescript-language-server", "--stdio" }
    end

    require("lspconfig")[server_name].setup(options)
  end,
}
