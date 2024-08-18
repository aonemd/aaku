return {
  'nvimdev/guard.nvim',
  dependencies = {
    'nvimdev/guard-collection',
  },
  config = function()
    local ft = require('guard.filetype')

    ft('typescript,javascript,javascriptreact,typescriptreact,vue'):fmt('prettier')
    -- :append({
    -- 	fn = function()
    -- 		vim.cmd("EslintFixAll")
    -- 	end,
    -- })
    ft('go'):fmt('gofmt')
    ft('rust'):fmt('rustfmt')
    ft('prisma'):fmt('lsp')
    ft('lua'):fmt('stylua')
    ft('fnl'):fmt('fnlfmt')

    require('guard').setup({
      fmt_on_save = true,

      -- Use lsp if no formatter was defined for this filetype
      lsp_as_default_formatter = true,
    })
  end,
}
