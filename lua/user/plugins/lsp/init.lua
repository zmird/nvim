local icons_status_ok, icons = pcall(require, "user.icons")
if not icons_status_ok then
  return
end

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = false,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    severity_sort = true,
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "if_many",
    header = "",
    prefix = "",
  },
  signs = {
    active = true,
    text = {
      [vim.diagnostic.severity.ERROR] = icons.error,
      [vim.diagnostic.severity.WARN]  = icons.warningTriangle,
      [vim.diagnostic.severity.INFO]  = icons.info,
      [vim.diagnostic.severity.HINT]  = icons.lightbulb
    },
    texthl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint"
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN]  = "",
      [vim.diagnostic.severity.INFO]  = "",
      [vim.diagnostic.severity.HINT]  = ""
    }
  },
})

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
