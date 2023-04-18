local indent_status_ok, indent = pcall(require, "indent_blankline")
if not indent_status_ok then
  return
end

vim.opt.list = false
vim.opt.listchars = {
  space = "⋅",
  eol = "↴",
}

indent.setup {
  char = "|",
  buftype_exclude = {
    "nofile",
    "terminal",
    "TelescopePrompt"
  },
  filetype_exclude = {
    "noice",
    "help",
    "alpha",
    "neo-tree",
    "neo-tree-popup",
    "packer",
    "lsp-installer",
    "NvimTree",
    "Trouble",
    "TelescopePrompt",
    "LspsagaCodeAction",
    "LspsagaDiagnostics",
    "LspsagaFinder",
    "LspsagaFloaterm",
    "LspsagaHover",
    "LspsagaRename",
    "LspsagaSignatureHelp",
  },
  space_char_blankline = " ",
  show_current_context = true,
  show_end_of_line = true,
  use_treesitter = true,
}
