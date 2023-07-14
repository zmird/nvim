local catppuccin_ok, catppuccin = pcall(require, "catppuccin")
if not catppuccin_ok then
  return
end

catppuccin.setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = "latte",
    dark = "mocha",
  },
  transparent_background = false, -- disables setting the background color.
  show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
  term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
  dim_inactive = {
    enabled = false, -- dims the background color of inactive window
    shade = "dark",
    percentage = 0.15, -- percentage of the shade to apply to the inactive window
  },
  no_italic = false, -- Force no italic
  no_bold = false, -- Force no bold
  no_underline = false, -- Force no underline
  styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
    comments = { "italic" }, -- Change the style of comments
    conditionals = {},
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  color_overrides = {},
  custom_highlights = function(c)
    -- colors
    c.orange = c.peach
    c.cyan = c.sky
    c.purple = c.mauve

    -- git colors
    c.git = {
      add = c.green,
      delete = c.red,
      ignore = c.lavender,
      change = c.peach
    }

    -- foreground and background
    c.fg = c.text
    c.fg_dimmed = c.overlay0
    c.bg = c.base
    c.bg_dark = c.mantle
    c.bg_highlight = c.surface0

    c.error = c.red
    c.warning = c.orange
    c.hint = c.green
    c.info = c.sky

    c.comment = c.lavender

    return {
      -- Neotree
      NeoTreeGitAdded     = { fg = c.git.add },
      NeoTreeGitConflict  = { fg = c.orange },
      NeoTreeGitDeleted   = { fg = c.git.delete },
      NeoTreeGitIgnored   = { fg = c.git.ignore },
      NeoTreeGitModified  = { fg = c.git.change },
      NeoTreeGitUntracked = { fg = c.warning },
      NeoTreeWinSeparator = { fg = c.bg_dark, bg = c.bg_dark },

      -- Dashboard
      DashboardMessage    = { fg = c.comment, bg = c.bg },
      DashboardAscii      = { fg = c.bg_dark, bg = c.purple },
      DashboardButtons    = { fg = c.fg, bg = c.bg },

      -- Tabline
      -- Tabline             = { fg = c.blue, bg = c.red },
      TabLineFill             = { bg = c.bg_dark },
      TablineBufOn            = { fg = c.fg, bg = c.bg },
      TablineBufOff           = { fg = c.fg_dimmed, bg = c.bg_dark },
      TablineTabOn            = { fg = c.fg, bg = c.bg },
      TablineTabOff           = { fg = c.fg_dimmed, bg = c.bg_dark },
      TablineBufOnClose       = { fg = c.fg, bg = c.bg },
      TablineBufOffClose      = { fg = c.fg_dimmed, bg = c.bg_dark },
      TablineBufOnModified    = { fg = c.fg, bg = c.bg },
      TablineBufOffModified   = { fg = c.fg_dimmed, bg = c.bg_dark },
      TablineThemeToggleBtn   = { fg = c.fg, bg = c.bg_highlight },
      TablineCloseAllBufsBtn  = { fg = c.bg, bg = c.red },

      -- StatusLine
      St_NormalMode           = { fg = c.cyan },
      St_VisualMode           = { fg = c.purple },
      St_InsertMode           = { fg = c.green },
      St_ReplaceMode          = { fg = c.red },
      St_CommandMode          = { fg = c.yellow },
      St_ConfirmMode          = { fg = c.blue },
      St_TerminalMode         = { fg = c.orange },
      St_NTerminalMode        = { fg = c.orange },
      St_Text                 = { fg = c.fg, },
      St_Filename             = { fg = c.fg, bg = c.bg_highlight, bold = true },
      St_GitAdd               = { fg = c.git.add, },
      St_GitChange            = { fg = c.orange, },
      St_GitRemove            = { fg = c.git.delete, },
      St_lspError             = { fg = c.error },
      St_lspWarning           = { fg = c.warning },
      St_lspHints             = { fg = c.hint },
      St_lspInfo              = { fg = c.info },
      St_lspStatus            = { fg = c.fg, bold = true },
      St_PositionSeparator    = { fg = c.green },
      St_PositionIcon         = { fg = c.bg_dark, bg = c.green },
      St_PositionText         = { fg = c.green },
      St_DirectorySeparator   = { fg = c.red },
      St_DirectoryIcon        = { fg = c.bg_dark, bg = c.red },
      St_DirectoryText        = { fg = c.red },

      -- Cheatsheet
      CheatsheetHeaderRed     = { fg = c.bg, bg = c.red },
      CheatsheetHeaderBlue    = { fg = c.bg, bg = c.blue },
      CheatsheetHeaderYellow  = { fg = c.bg, bg = c.yellow },
      CheatsheetHeaderGreen   = { fg = c.bg, bg = c.green },
      CheatsheetHeaderOrange  = { fg = c.bg, bg = c.orange },
      CheatsheetHeaderMagenta = { fg = c.bg, bg = c.magenta },
      CheatsheetHeaderCyan    = { fg = c.bg, bg = c.cyan },
      CheatsheetHeaderPurple  = { fg = c.bg, bg = c.purple },
      CheatsheetSection       = { fg = c.fg, bg = c.bg_highlight },

      -- Telescope
      TelescopeBorder         = { fg = c.bg_dark, bg = c.bg_dark, },
      TelescopePromptBorder   = { fg = c.bg_highlight, bg = c.bg_highlight, },
      TelescopeNormal         = { fg = c.bg_dark, bg = c.bg_dark, },
      TelescopePromptNormal   = { fg = c.fg, bg = c.bg_highlight, },
      TelescopeResultsNormal  = { fg = c.fg, bg = c.bg_dark, },
      TelescopePreviewNormal  = { fg = c.fg, bg = c.bg_dark, },
      TelescopePromptTitle    = { fg = c.fg, bg = c.bg_dark, },
      TelescopePreviewTitle   = { fg = c.bg, bg = c.purple, },
      TelescopeResultsTitle   = { bg = c.bg_dark, fg = c.bg_dark, },

      -- Cmp Hightlights
      CmpItemKindText           = { fg = c.orange },
      CmpItemKindMethod         = { fg = c.blue },
      CmpItemKindFunction       = { fg = c.blue },
      CmpItemKindConstructor    = { fg = c.yellow },
      CmpItemKindField          = { fg = c.blue },
      CmpItemKindClass          = { fg = c.yellow },
      CmpItemKindInterface      = { fg = c.orange },
      CmpItemKindModule         = { fg = c.orange },
      CmpItemKindProperty       = { fg = c.orange },
      CmpItemKindValue          = { fg = c.orange },
      CmpItemKindEnum           = { fg = c.orange },
      CmpItemKindKeyword        = { fg = c.orange },
      CmpItemKindSnippet        = { fg = c.orange },
      CmpItemKindFile           = { fg = c.orange },
      CmpItemKindEnumMember     = { fg = c.orange },
      CmpItemKindConstant       = { fg = c.orange },
      CmpItemKindStruct         = { fg = c.orange },
      CmpItemKindTypeParameter  = { fg = c.orange }
    }
  end ,
  integrations = {
    cmp = true,
    gitsigns = true,
    lsp_trouble = true,
    neotree = true,
    noice = true,
    mason = true,
    symbols_outline = true,
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
      inlay_hints = {
        background = true,
      },
    },
    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
})

