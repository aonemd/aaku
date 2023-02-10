local require_safe = require("utils").require_safe

local null_ls = require_safe("null-ls")

local augroup = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event   = "BufWritePre" -- or "BufWritePost"
local async   = event == "BufWritePost"

null_ls.setup {
  sources = {
    null_ls.builtins.completion.spell,
    null_ls.builtins.formatting.prettierd.with({
      filetypes = {
        'html',
        'json',
        'javascript',
        'typescript',
        'javascriptreact',
        'typescriptreact',
        'scss',
        'css',
      },
    }),
    null_ls.builtins.diagnostics.eslint_d.with({
      diagnostics_format = '#{m}'
    }),
  },
  on_attach = function(client, bufnr)
    -- if client.supports_method("textDocument/formatting") then
    --   vim.keymap.set("n", "<Leader>f", function()
    --     vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
    -- end, { buffer = bufnr, desc = "[lsp] format" })

    if client.supports_method 'textDocument/formatting' then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd(event, {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = async })
        end,
        desc = "[LSP] auto format",
      })
    end

    if client.supports_method("textDocument/rangeFormatting") then
      vim.keymap.set("x", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[LSP] format" })
    end
  end,
}
