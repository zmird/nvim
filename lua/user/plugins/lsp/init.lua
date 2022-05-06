
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("user.plugins.lsp.install")
require("user.plugins.lsp.handlers").setup()
require("user.plugins.lsp.null_ls")
-- require("user.plugins.lsp.saga")
require("user.plugins.lsp.trouble")