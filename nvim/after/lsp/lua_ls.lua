return {
	cmd = {
		"lua-language-server",
	},
	filetypes = {
		"lua",
	},
	root_markers = {
		".git",
		".luacheckrc",
		".luarc.json",
		".luarc.jsonc",
		".stylua.toml",
		"selene.toml",
		"selene.yml",
		"stylua.toml",
	},
  --       settings = {
  --         Lua = {
  --           diagnostics = {
  --             globals = { 'vim' },
	--             --     disable = { "missing-parameters", "missing-fields" },
  --           },
  --           workspace = {
  --             library = {
  --               [vim.fn.expand('$VIMRUNTIME/lua')] = true,
  --               [vim.fn.stdpath('config') .. '/lua'] = true,
  --             },
  --           },
  --         },
  --       }
	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
}
