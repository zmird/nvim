
local github_theme_status_ok, github_theme = pcall(require, "github-theme.palette.dark_default")
if not github_theme_status_ok then
  return
end

local colors = github_theme()

local M = {}

M.bg                    = colors.bg
M.bg2                   = colors.bg2

-- foreground colors
M.fg                    = colors.fg
M.fg_dark               = colors.fg_dark
M.fg_dark               = colors.fg_dark
M.fg_gutter             = colors.fg_gutter
M.fg_light              = colors.fg_light
M.fg_term               = colors.fg_term

-- Background Highlights Color
M.bg_highlight          = colors.bg_highlight
M.bg_search             = colors.bg_search
M.bg_visual             = colors.bg_visual
M.bg_visual_selection   = colors.bg_visual_selection
M.border                = colors.border

-- Cursor & LineNumber Color
M.cursor                = colors.cursor
M.cursor_line_nr        = colors.cursor_line_nr
M.line_nr               = colors.line_nr

-- LSP & Diagnostic Color
M.error                 = colors.error
M.warning               = colors.warning
M.info                  = colors.info
M.hint                  = colors.hint

M.git = {
  add                   = colors.git.add,
  change                = colors.git.change,
  delete                = colors.git.delete,
  conflict              = colors.git.conflict,
  ignore                = colors.git.ignore
}

-- Generic Colors
M.black                 = colors.black
M.bright_black          = colors.bright_black
M.white                 = colors.white
M.bright_white          = colors.bright_white
M.red                   = colors.red
M.bright_red            = colors.bright_red
M.dark_red              = colors.git.delete
M.green                 = colors.green
M.bright_green          = colors.bright_green
M.yellow                = colors.yellow
M.bright_yellow         = colors.bright_yellow
M.blue                  = colors.blue
M.bright_blue           = colors.bright_blue
M.magenta               = colors.magenta
M.bright_magenta        = colors.bright_magenta
M.cyan                  = colors.cyan
M.bright_cyan           = colors.bright_cyan

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