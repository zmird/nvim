local indent_status_ok, indent = pcall(require, "ibl")
if not indent_status_ok then
  return
end

vim.opt.list = false
vim.opt.listchars = {
  space = "⋅",
  eol = "↴",
}

indent.setup {
  scope = {
    enabled = false,
    highlight = {
        "CursorColumn",
        "Whitespace",
    },
  },
  indent = {
    char = "|",
    -- highlight = {
    --     "CursorColumn",
    --     "Whitespace",
    -- },
  },
  whitespace = {
    highlight = {
        -- "CursorColumn",
        "Whitespace",
    },
  },
  -- space_char_blankline = " ",
  -- show_current_context = true,
  -- show_end_of_line = true,
  -- use_treesitter = true,
  exclude = {
    buftypes = {
      "nofile",
      "terminal",
      "TelescopePrompt"
    },
    filetypes = {
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
  },
}
