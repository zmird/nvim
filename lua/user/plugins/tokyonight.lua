local tokyonight_ok, tokyonight = pcall(require, "tokyonight")
if not tokyonight_ok then
  return
end

tokyonight.setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  light_style = "day", -- The theme is used when the background is set to light
  transparent = false, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false, -- dims inactive windows
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors)
    colors.fg_highlight = "#ffffff"
  end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights Highlights
  ---@param colors ColorScheme
  on_highlights = function(hl, c)
    -- Neotree
    hl.NeoTreeGitAdded = {
      fg = c.git.add,
    }
    hl.NeoTreeGitConflict = {
      fg = c.orange,
    }
    hl.NeoTreeGitDeleted = {
      fg = c.git.delete
    }
    hl.NeoTreeGitIgnored = {
      fg = c.git.ignore
    }
    hl.NeoTreeGitModified = {
      fg = c.git.change
    }
    hl.NeoTreeGitUntracked = {
      fg = c.warning
    }
    hl.NeoTreeWinSeparator = {
      fg = c.bg_dark,
      bg = c.bg_dark
    }

    -- Dashboard
    hl.DashboardMessage = {
      fg = c.comment,
      bg = c.bg,
    }
    hl.DashboardAscii = {
      fg = c.bg_dark,
      bg = c.purple,
    }
    hl.DashboardButtons = {
      fg = c.fg,
      bg = c.bg,
    }

    -- Tabline
    -- hl.Tabline = {
    --   fg = c.blue,
    --   bg = c.red
    -- }
    hl.TabLineFill = {
      bg = c.bg_dark
    }
    hl.TablineBufOn = {
      fg = c.fg,
      bg = c.bg,
    }
    hl.TablineBufOff = {
      fg = c.comment,
      bg = c.bg_dark
    }
    hl.TablineTabOn = {
      fg = c.fg,
      bg = c.bg
    }
    hl.TablineTabOff = {
      fg = c.comment,
      bg = c.bg_dark
    }
    hl.TablineBufOnClose = {
      fg = c.fg,
      bg = c.bg
    }
    hl.TablineBufOffClose = {
      fg = c.comment,
      bg = c.bg_dark
    }
    hl.TablineBufOnModified = {
      fg = c.fg,
      bg = c.bg
    }
    hl.TablineBufOffModified = {
      fg = c.comment,
      bg = c.bg_dark
    }
    hl.TablineThemeToggleBtn = {
      fg = c.fg,
      bg = c.bg_highlight
    }
    hl.TablineCloseAllBufsBtn = {
      fg = c.bg,
      bg = c.red
    }

    -- StatusLine
    hl.St_NormalMode = {
      fg = c.cyan
    }
    hl.St_VisualMode = {
      fg = c.purple
    }
    hl.St_InsertMode = {
      fg = c.green
    }
    hl.St_ReplaceMode = {
      fg = c.red
    }
    hl.St_CommandMode = {
      fg = c.yellow
    }
    hl.St_ConfirmMode = {
      fg = c.blue1
    }
    hl.St_TerminalMode = {
      fg = c.orange
    }
    hl.St_NTerminalMode = {
      fg = c.orange
    }
    hl.St_Text = {
      fg = c.fg,
    }
    hl.St_Filename = {
      fg = c.fg,
      bg = c.bg_highlight,
      bold = true
    }
    hl.St_GitAdd = {
      fg = c.git.add,
    }
    hl.St_GitChange = {
      fg = c.orange,
    }
    hl.St_GitRemove = {
      fg = c.git.delete,
    }
    hl.St_lspError = {
      fg = c.error
    }
    hl.St_lspWarning = {
      fg = c.warning
    }
    hl.St_lspHints = {
      fg = c.hint
    }
    hl.St_lspInfo = {
      fg = c.info
    }
    hl.St_lspStatus = {
      fg = c.fg,
      bold = true
    }
    hl.St_PositionSeparator = {
      fg = c.green
    }
    hl.St_PositionIcon = {
      fg = c.bg_dark,
      bg = c.green
    }
    hl.St_PositionText = {
      fg = c.green
    }
    hl.St_DirectorySeparator = {
      fg = c.red
    }
    hl.St_DirectoryIcon = {
      fg = c.bg_dark,
      bg = c.red
    }
    hl.St_DirectoryText = {
      fg = c.red
    }

    -- Cheatsheet
    hl.CheatsheetHeaderRed = {
      fg = c.bg,
      bg = c.red
    }
    hl.CheatsheetHeaderBlue = {
      fg = c.bg,
      bg = c.blue
    }
    hl.CheatsheetHeaderYellow = {
      fg = c.bg,
      bg = c.yellow
    }
    hl.CheatsheetHeaderGreen = {
      fg = c.bg,
      bg = c.green
    }
    hl.CheatsheetHeaderOrange = {
      fg = c.bg,
      bg = c.orange
    }
    hl.CheatsheetHeaderMagenta = {
      fg = c.bg,
      bg = c.magenta
    }
    hl.CheatsheetHeaderCyan = {
      fg = c.bg,
      bg = c.cyan
    }
    hl.CheatsheetHeaderPurple = {
      fg = c.bg,
      bg = c.purple
    }
    hl.CheatsheetSection = {
      fg = c.fg,
      bg = c.bg_highlight
    }

    -- Telescope
    hl.TelescopeBorder = {
      fg = c.bg_dark,
      bg = c.bg_dark,
    }
    hl.TelescopePromptBorder = {
      fg = c.bg_highlight,
      bg = c.bg_highlight,
    }

    hl.TelescopeNormal = {
      fg = c.bg_dark,
      bg = c.bg_dark,
    }
    hl.TelescopePromptNormal = {
      fg = c.fg,
      bg = c.bg_highlight,
    }
    hl.TelescopeResultsNormal = {
      fg = c.fg,
      bg = c.bg_dark,
    }
    hl.TelescopePreviewNormal = {
      fg = c.fg,
      bg = c.bg_dark,
    }

    hl.TelescopePromptTitle = {
      fg = c.fg,
      bg = c.bg_dark,
    }
    hl.TelescopePreviewTitle = {
      fg = c.bg,
      bg = c.purple,
    }
    hl.TelescopeResultsTitle = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }

    -- Cmp Hightlights
    hl.CmpItemKindText = {
      fg = c.orange
    }
    hl.CmpItemKindText = {
      fg = c.orange
    }
    hl.CmpItemKindMethod = {
      fg = c.blue
    }
    hl.CmpItemKindFunction = {
      fg = c.blue
    }
    hl.CmpItemKindConstructor = {
      fg = c.yellow
    }
    hl.CmpItemKindField = {
      fg = c.blue
    }
    hl.CmpItemKindClass = {
      fg = c.yellow
    }
    hl.CmpItemKindInterface = {
      fg = c.orange
    }
    hl.CmpItemKindModule = {
      fg = c.orange
    }
    hl.CmpItemKindProperty = {
      fg = c.orange
    }
    hl.CmpItemKindValue = {
      fg = c.orange
    }
    hl.CmpItemKindEnum = {
      fg = c.orange
    }
    hl.CmpItemKindKeyword = {
      fg = c.orange
    }
    hl.CmpItemKindSnippet = {
      fg = c.orange
    }
    hl.CmpItemKindFile = {
      fg = c.orange
    }
    hl.CmpItemKindEnumMember = {
      fg = c.orange
    }
    hl.CmpItemKindConstant = {
      fg = c.orange
    }
    hl.CmpItemKindStruct = {
      fg = c.orange
    }
    hl.CmpItemKindTypeParameter = {
      fg = c.orange
    }

    -- Git Signs Hightlights
    hl.GitSignsAdd = {
      fg = c.git.add,
      bold = true
    }
    hl.GitSignsChange = {
      fg = c.git.change,
      bold = true
    }
    hl.GitSignsDelete = {
      fg = c.git.delete,
      bold = true
    }
    hl.GitSignsTopdelete = {
      link = hl.GitSignsDelete
    }
    hl.GitSignsChangedelete = {
      link = hl.GitSignsChange
    }
  end,
})
