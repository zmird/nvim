local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup {
  debug = false,
  debounce = 150,
  sources = {
    -- Formatting
    formatting.prettier.with { extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } },
    formatting.black.with { extra_args = { "--fast" } },
    formatting.stylua,
    formatting.goimports,
    formatting.gofumpt,

    -- Diagnostics
    diagnostics.flake8,
    -- diagnostics.ansiblelint,
    -- diagnostics.golangci_lint,

    -- Code actions
    code_actions.gitsigns,
    code_actions.gitrebase,
    code_actions.gomodifytags,

  },
}
