local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

require("user.plugins.lsp.handlers").setup()


local servers = {
  "lua_ls",
  "gopls",
  "golangci_lint_ls",
  "clangd",
  "pyright",
  "ansiblels",
  "bashls"
}

local opts = {
  on_attach = require("user.plugins.lsp.handlers").on_attach,
  capabilities = require("user.plugins.lsp.handlers").capabilities,
}

for _, server in pairs(servers) do
	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "user.plugins.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end


require("user.plugins.lsp.mason")
require("user.plugins.lsp.trouble")
