local M = {}

local github_theme_status_ok, github_theme = pcall(require, "github-theme.palette.dark_default")
if not github_theme_status_ok then
  return M
end

local github_colors = github_theme()

M.loaded                = true

M.bg                    = github_colors.bg
M.bg2                   = github_colors.bg2

-- foreground colors
M.fg                    = github_colors.fg
M.fg_dark               = github_colors.fg_dark
M.fg_dark               = github_colors.fg_dark
M.fg_gutter             = github_colors.fg_gutter
M.fg_light              = github_colors.fg_light
M.fg_term               = github_colors.fg_term

-- Background Highlights Color
M.bg_highlight          = github_colors.bg_highlight
M.bg_search             = github_colors.bg_search
M.bg_visual             = github_colors.bg_visual
M.bg_visual_selection   = github_colors.bg_visual_selection
M.border                = github_colors.border

-- Cursor & LineNumber Color
M.cursor                = github_colors.cursor
M.cursor_line_nr        = github_colors.cursor_line_nr
M.line_nr               = github_colors.line_nr

-- LSP & Diagnostic Color
M.error                 = github_colors.error
M.warning               = github_colors.warning
M.info                  = github_colors.info
M.hint                  = github_colors.hint

-- Git colors
M.git = {
  add                   = github_colors.git.add,
  change                = github_colors.git.change,
  delete                = github_colors.git.delete,
  conflict              = github_colors.git.conflict,
  ignore                = github_colors.git.ignore
}

-- Generic Colors
M.black                 = github_colors.black
M.bright_black          = github_colors.bright_black
M.white                 = github_colors.white
M.bright_white          = github_colors.bright_white
M.red                   = github_colors.red
M.bright_red            = github_colors.bright_red
M.dark_red              = github_colors.git.delete
M.green                 = github_colors.green
M.bright_green          = github_colors.bright_green
M.yellow                = github_colors.yellow
M.bright_yellow         = github_colors.bright_yellow
M.blue                  = github_colors.blue
M.bright_blue           = github_colors.bright_blue
M.magenta               = github_colors.magenta
M.bright_magenta        = github_colors.bright_magenta
M.cyan                  = github_colors.cyan
M.bright_cyan           = github_colors.bright_cyan

return M

-- bg_highlight = '#161b22',
-- bg_search = '#2c2b1c',
-- bg_visual = '#b3b1ad',
-- bg_visual_selection = '#163356',
-- border = '#b3b1ad',


--     bg = '#0d1117',
-- bg2 = '#090c10',

-- -- foreground colors
-- -- fg = '#c9d1d9',
-- fg_dark = '#4d5566',
-- fg_gutter = '#c5c5c5',
-- fg_light = '#b3b1ad',
-- fg_term = '#b3b1ad',

--     black = '#484f58',
-- bright_black = '#6e7681',
-- white = '#b1bac4',
-- bright_white = '#f0f6fc',
-- red = '#ff7b72',
-- bright_red = '#ffa198',
-- green = '#3fb950',
-- bright_green = '#56d364',
-- yellow = '#d29922',
-- bright_yellow = '#e3b341',
-- blue = '#58a6ff',
-- bright_blue = '#79c0ff',
-- magenta = '#bc8cff',
-- bright_magenta = '#d2a8ff',
-- cyan = '#39c5cf',
-- bright_cyan = '#56d4dd',

-- -- Plugin Colors
-- git_signs = { add = '#196c2e', change = '#9e6a03', delete = '#b62324' },

--     pmenu = { bg = '#161b22', sbar = '#31373d' },

-- -- Git & Diff Colors
-- git = {
--   add = '#56d364',
--   change = '#ac8934',
--   delete = '#f85149',
--   conflict = '#e3b341',
--   ignore = '#484f58',
--   -- renamed = '#73c991',
-- },