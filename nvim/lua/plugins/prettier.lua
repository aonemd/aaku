 -- npm install -g @fsouza/prettierd
 -- npm i -g eslint_d

local require_safe = require("utils").require_safe

local prettier = require_safe("prettier")

prettier.setup {
  bin = 'prettierd',
  filetypes = {
    "css",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "json",
    "scss",
    "less"
  }
}
