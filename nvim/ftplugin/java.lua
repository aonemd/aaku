vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.makeprg = 'javac % && java %'
vim.opt.errorformat = '%E%f:%l: %m,%-Z%p^,%-C%.%#,%-G%.%#'

local config = {
  -- cmd = { vim.fn.expand('$HOME/.local/share/nvim/mason/bin/jdtls') },
  cmd = { vim.fn.expand('/opt/homebrew/bin/jdtls') },
  root_dir = vim.fs.dirname(
    vim.fs.find(
      { '.git', '.gradle', '.gradlew', '.gitignore', 'mvnw', 'build.gradle.kts' },
      { upward = true }
    )[1]
  ),
}
require('jdtls').start_or_attach(config)
