local M = {}

local tokyonight_theme_status_ok, tokyonight_theme = pcall(require, "tokyonight.colors")
if not tokyonight_theme_status_ok then
  return M
end

M = tokyonight_theme

M.git = M.default.git

return M
