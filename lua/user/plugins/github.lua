local github_theme_status_ok, github_theme = pcall(require, "github-theme")
if not github_theme_status_ok then
  return
end

github_theme.setup({
  theme_style = "dark_default",
  dark_float = true,
  dark_sidebar = true,
  function_style = "bold",
  -- keyword_style = "italic",
  -- variable_style = "bold",
  sidebars = {"qf", "vista_kind", "terminal", "packer"},

  -- Overwrite the highlight groups
  overrides = function(c)
    return {
      htmlTag = {fg = c.red, bg = "#282c34", sp = c.hint, style = "underline"},
      DiagnosticHint = {link = "LspDiagnosticsDefaultHint"},
      -- this will remove the highlight groups
      -- TSField = {},
      -- Keyword = { fg = c.blue },
      -- Operator = { fg = c.blue },
      Type = { fg = c.blue },
      Constant = { fg = c.bright_cyan },
      Number = { fg = c.bright_blue },
      -- String = { fg = c.green },
    }
  end,
})
