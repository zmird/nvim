local icons_status_ok, icons = pcall(require, "user.icons")
if not icons_status_ok then
  return
end

local outline_status_ok, outline = pcall(require, "outline")
if not outline_status_ok then
	return
end

outline.setup({
    guides = {
    enabled = true
  },
  keymaps = {
    close = { "<esc>", "q" },
    code_actions = "a",
    fold = "h",
    fold_all = "w",
    fold_reset = "r",
    goto_location = "<cr>",
    hover_symbol = "<c-space>",
    peek_location = "o",
    rename_symbol = "r",
    toggle_preview = "k",
    unfold = "l",
    unfold_all = "e"
  },
  outline_items = {
    highlight_hovered_item = true,
    show_symbol_details = true
  },
  outline_window = {
    auto_close = false,
    position = "right",
    relative_width = true,
    show_numbers = false,
    show_relative_numbers = false,
    width = 25,
    wrap = false
  },
  preview_window = {
    auto_preview = false,
    winhl = "normal:pmenu"
  },
  provider = {
    lsp = {
      blacklist_clients = {}
    }
  },
  symbol_folding = {
    auto_unfold_hover = true,
    markers = { "", "" }
  },
  symbols = {
    filter = {
      exclude = true
    },
    icons = {
      array = {
        hl = "@constant",
        icon = icons.code.array
      },
      boolean = {
        hl = "@boolean",
        icon = icons.code.boolean
      },
      class = {
        hl = "@type",
        icon = icons.code.class
      },
      component = {
        hl = "@function",
        icon = icons.code.component
      },
      constant = {
        hl = "@constant",
        icon = icons.code.constant
      },
      constructor = {
        hl = "@constructor",
        icon = icons.code.constructor
      },
      enum = {
        hl = "@type",
        icon = icons.code.enum
      },
      EnumMember = {
        hl = "@field",
        icon = icons.code.enum
      },
      Event = {
        hl = "@type",
        icon = icons.code.event
      },
      Field = {
        hl = "@field",
        icon = icons.code.field
      },
      File = {
        hl = "@text.uri",
        icon = icons.code.file
      },
      Fragment = {
        hl = "@constant",
        icon = icons.code.fragment
      },
      Function = {
        hl = "@function",
        icon = icons.code.func
      },
      Interface = {
        hl = "@type",
        icon = icons.code.interface
      },
      Key = {
        hl = "@type",
        icon = icons.code.key
      },
      Method = {
        hl = "@method",
        icon = icons.code.method
      },
      Module = {
        hl = "@namespace",
        icon = icons.code.module
      },
      Namespace = {
        hl = "@namespace",
        icon = icons.code.namespace
      },
      Null = {
        hl = "@type",
        icon = icons.code.null
      },
      Number = {
        hl = "@number",
        icon = icons.code.number
      },
      Object = {
        hl = "@type",
        icon = icons.code.object
      },
      Operator = {
        hl = "@operator",
        icon = icons.code.operators
      },
      Package = {
        hl = "@namespace",
        icon = icons.code.package
      },
      Property = {
        hl = "@method",
        icon = icons.code.property
      },
      String = {
        hl = "@string",
        icon = icons.code.string
      },
      Struct = {
        hl = "@type",
        icon = icons.code.struct
      },
      TypeParameter = {
        hl = "@parameter",
        icon = icons.code.TypeParameter
      },
      Variable = {
        hl = "@constant",
        icon = icons.code.variable
      }
    }
  }
})
