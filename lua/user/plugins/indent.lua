local indent_status_ok, indent = pcall(require, "indent_blankline")
if not indent_status_ok then
  return
end

vim.opt.listchars = {
  space = "⋅",
  eol = "↴",
}

indent.setup {
  char = "|",
  buftype_exclude = {"terminal", "telescope"},
  filetype_exclude = {"help", "dashboard", "packer", "NvimTree", "Trouble"},
  space_char_blankline = " ",
  show_current_context = true,
  show_end_of_line = true,
  use_treesitter = true,
}
