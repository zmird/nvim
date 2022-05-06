local utils = require("user.utils")
local colors = require("user.colors")

local fg = utils.fg
local bg = utils.bg
local fg_bg = utils.fg_bg

-- Telescope

fg_bg("TelescopeBorder", colors.bg2, colors.bg2)
fg_bg("TelescopePromptBorder", colors.bg_highlight, colors.bg_highlight)


bg("TelescopeNormal", colors.bg2)
fg_bg("TelescopePromptNormal", colors.fg, colors.bg_highlight)
fg_bg("TelescopeResultsNormal", colors.fg, colors.bg2)
fg_bg("TelescopePreviewNormal", colors.fg, colors.bg2)

fg_bg("TelescopePromptTitle", colors.bg_highlight, colors.blue)
fg_bg("TelescopePreviewTitle", colors.bg, colors.dark_red)
fg_bg("TelescopeResultsTitle", colors.bg2, colors.bg2)

fg_bg("TelescopePromptPrefix", colors.blue, colors.bg_highlight)
fg_bg("TelescopePromptCounter", colors.fg_dark, colors.bg_highlight)

bg("TelescopeSelection", colors.bg_visual_selection)
