local require_safe = require("utils").require_safe

local M = {}

M.setup = function()
  local config = {
    virtual_text = false,   -- disable text that appears beside code
    signs = false,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '[g', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', ']g', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', 'gcq', vim.diagnostic.setloclist, opts)
  vim.keymap.set('n', 'gcr', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', 'gca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gcf', vim.lsp.buf.formatting, bufopts)

  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format { async = true }' ]]
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
  end

  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp = require_safe("cmp_nvim_lsp")

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
