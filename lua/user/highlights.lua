-- local utils_status_ok, utils = pcall(require, "user.utils")
-- if not utils_status_ok then
--   return
-- end

local colors_status_ok, colors = pcall(require, "user.colors")
if not colors_status_ok then
  return
end

if not colors.loaded then
  return
end

vim.cmd[[set termguicolors]]

-- local fg = utils.fg
-- local bg = utils.bg
-- local fg_bg = utils.fg_bg
