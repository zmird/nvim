local utils_status_ok, utils = pcall(require, "user.utils")
if not utils_status_ok then
  return
end

local tokyonight_theme_status_ok, tokyonight_theme = pcall(require, "tokyonight.colors")
if not tokyonight_theme_status_ok then
  return M
end

-- utils.tprint(tokyonight_theme)

local M = tokyonight_theme.default

M.bg_dark = tokyonight_theme.night.bg_dark

M.bg = tokyonight_theme.night.bg

-- M.git = M.default.git

return M
