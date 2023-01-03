local lsp_installer = require("nvim-lsp-installer")
local lspconfig     = require("lspconfig")
local root_pattern  = lspconfig.util.root_pattern

-- 1. Set up nvim-lsp-installer first!
lsp_installer.setup({
  ensure_installed = { "clangd", "rust_analyzer", "jdtls", "kotlin_language_server", "sumneko_lua", "tsserver", "solargraph", },
})

-- 2. (optional) Override the default configuration to be applied to all servers.
lspconfig.util.default_config = vim.tbl_extend(
    "force",
    lspconfig.util.default_config,
    {
        on_attach = on_attach
    }
)

vim.diagnostic.config({
  virtual_text     = false,
  signs            = true,
  underline        = true,
  update_in_insert = false,
  severity_sort    = false,

  float = {
    focusable = false,
    style     = "minimal",
    border    = "rounded",
    source    = "if_many",
    header    = "",
    prefix    = "",
  },
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', 'gcq', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gsh', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', 'gcr', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', 'gca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gcf', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- 3. Loop through all of the installed servers and set it up via lspconfig
for _, server in ipairs(lsp_installer.get_installed_servers()) do
  local config = {
    on_attach    = on_attach,
    capabilities = capabilities,
    flags        = lsp_flags,
  }

  -- Java Java Javaa .. Java Java Javaa
  if server.name == 'jdtls'
  then
    config["root_dir"] = root_pattern(".git")
  end

  if server.name == 'kotlin_language_server'
  then
    config["root_dir"] = root_pattern(".git")
  end

  lspconfig[server.name].setup(config)
end
