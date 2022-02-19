local require_safe = require("utils").require_safe

require_safe("lspconfig")

-- LSP-Installer
--
local lsp_installer = require_safe("nvim-lsp-installer")

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("plugins.lsp-handler").on_attach,
		capabilities = require("plugins.lsp-handler").capabilities,
	}

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)


-- handler
--
require("plugins.lsp-handler").setup()
