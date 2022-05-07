local utils_status_ok, utils = pcall(require, "user.utils")
if not utils_status_ok then
  return
end

local colors_status_ok, colors = pcall(require, "user.colors")
if not colors_status_ok then
  return
end

if not colors.loaded then
  return
end

vim.cmd[[set termguicolors]]

local fg = utils.fg
local bg = utils.bg
local fg_bg = utils.fg_bg

-- NeoVim Tree
fg("NvimTreeFolderIcon", colors.blue)
-- vim.cmd[[hi NvimTreeRootFolder guifg=bg guibg=bg]]
-- vim.cmd[[hi NvimTreeFolderIcon guifg=#61AFEF]]
-- vim.cmd[[highlight NvimTreeFolderName guifg=#61AFEF]]

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

-- Dashboard

fg("DashboardHeader", colors.bright_black)
fg("DashboardCenter", colors.bright_black)
fg("DashboardShortcut", colors.bright_black)
-- fg("DashboardFooter" .. colors.bright_black)