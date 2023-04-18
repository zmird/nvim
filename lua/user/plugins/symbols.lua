local icons_status_ok, icons = pcall(require, "user.icons")
if not icons_status_ok then
  return
end

local symbols_outline_status_ok, symbols_outline = pcall(require, "symbols-outline")
if not symbols_outline_status_ok then
	return
end

symbols_outline.setup({
  highlight_hovered_item = true,
  show_guides = true,
  auto_preview = false,
  position = 'right',
  relative_width = true,
  width = 25,
  auto_close = false,
  show_numbers = false,
  show_relative_numbers = false,
  show_symbol_details = true,
  preview_bg_highlight = 'Pmenu',
  autofold_depth = nil,
  auto_unfold_hover = true,
  fold_markers = { '', '' },
  wrap = false,
  keymaps = { -- These keymaps can be a string or a table for multiple keys
    close = {"<Esc>", "q"},
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "<C-space>",
    toggle_preview = "K",
    rename_symbol = "r",
    code_actions = "a",
    fold = "h",
    unfold = "l",
    fold_all = "W",
    unfold_all = "E",
    fold_reset = "R",
  },
  lsp_blacklist = {},
  symbol_blacklist = {},
  symbols = {
    Array         = { icon = icons.code.array,         hl = "@constant" },
    Boolean       = { icon = icons.code.boolean,       hl = "@boolean" },
    Class         = { icon = icons.code.class,         hl = "@type" },
    Component     = { icon = icons.code.component,     hl = "@function" },
    Constant      = { icon = icons.code.constant,      hl = "@constant" },
    Constructor   = { icon = icons.code.constructor,   hl = "@constructor" },
    Enum          = { icon = icons.code.enum,          hl = "@type" },
    EnumMember    = { icon = icons.code.enum,          hl = "@field" },
    Event         = { icon = icons.code.event,         hl = "@type" },
    Field         = { icon = icons.code.field,         hl = "@field" },
    File          = { icon = icons.code.file,          hl = "@text.uri" },
    Fragment      = { icon = icons.code.fragment,      hl = "@constant" },
    Function      = { icon = icons.code.func,      hl = "@function" },
    Interface     = { icon = icons.code.interface,     hl = "@type" },
    Key           = { icon = icons.code.key,           hl = "@type" },
    Method        = { icon = icons.code.method,        hl = "@method" },
    Module        = { icon = icons.code.module,        hl = "@namespace" },
    Namespace     = { icon = icons.code.namespace,     hl = "@namespace" },
    Null          = { icon = icons.code.null,          hl = "@type" },
    Number        = { icon = icons.code.number,        hl = "@number" },
    Object        = { icon = icons.code.object,        hl = "@type" },
    Operator      = { icon = icons.code.operators,     hl = "@operator" },
    Package       = { icon = icons.code.package,       hl = "@namespace" },
    Property      = { icon = icons.code.property,      hl = "@method" },
    String        = { icon = icons.code.string,        hl = "@string" },
    Struct        = { icon = icons.code.struct,        hl = "@type" },
    TypeParameter = { icon = icons.code.TypeParameter, hl = "@parameter" },
    Variable      = { icon = icons.code.variable,      hl = "@constant" },
  },
})
