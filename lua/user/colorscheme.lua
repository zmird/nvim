-- Tokyonight
vim.g.tokyonight_style = "dark"
vim.g.tokyonight_hide_inactive_statusline = true
vim.g.tokyonight_dark_sidebar = true
vim.g.tokyonight_lualine_bold = true

-- Onedark
vim.g.onedark_style = 'deep'

local colorscheme = "github_dark_default"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
  -- vim.notify("colorscheme " .. colorscheme .. " not found", vim.scheme.warning)
  return
end
