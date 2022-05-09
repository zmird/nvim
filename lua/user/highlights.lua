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

-- Cmp
-- fg("CmpItemKindText", colors.orange)
-- fg("CmpItemKindMethod", colors.blue)
-- fg("CmpItemKindFunction", colors.blue)
-- fg("CmpItemKindConstructor", colors.yellow)
-- fg("CmpItemKindField", colors.blue)
-- fg("CmpItemKindClass", colors.yellow)
-- fg("CmpItemKindInterface", colors.orange)
-- fg("CmpItemKindModule", colors.orange)
-- fg("CmpItemKindProperty", colors.orange)
-- fg("CmpItemKindValue", colors.orange)
-- fg("CmpItemKindEnum", colors.orange)
-- fg("CmpItemKindKeyword", colors.orange)
-- fg("CmpItemKindSnippet", colors.orange)
-- fg("CmpItemKindFile", colors.orange)
-- fg("CmpItemKindEnumMember", colors.orange)
-- fg("CmpItemKindConstant", colors.orange)
-- fg("CmpItemKindStruct", colors.orange)
-- fg("CmpItemKindTypeParameter", colors.orange)