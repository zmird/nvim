local lualine_status_ok, lualine = pcall(require, "lualine")
if not lualine_status_ok then
  return
end

local gps_status_ok, gps = pcall(require, "nvim-gps")
if not gps_status_ok then
  return
end

local colors = require("user.colors")

lualine.setup {
	options = {
		theme = "github_dark_default",
		component_separators = "",
		section_separators = "",
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {
			{
				'filename',
				color = {
					bg = nil,
					--fg = colors.white
				}
			},
		},
		lualine_c = {
			{
				gps.get_location,
				cond = gps.is_available
			},
			{
				'diagnostics',
				sources = {'nvim_diagnostic'},
				sections = {
					'error',
					'warn',
					'info',
					'hint',
				},
				symbols = {
					error = ' ',
					warn = ' ',
					info = ' ',
					hint = ' '
				},
				colored = true,
			},
		},
		lualine_x = {
			{
				'diff',
				color_added = colors.git.add,
				color_modified = colors.git.change,
				color_removed = colors.git.delete,
				symbols = {
					added = ' ',
					modified = '柳',
					removed = ' '
				}
			},
			{
				'branch',
				icon = '',
			}
		},
		lualine_y = {
			{
				'filetype',
				colored = true,
			},
		},
		lualine_z = {
			{
			  'progress',
				icon = "",
				color = {
					bg = colors.black,
					fg = colors.white
				}
			}
		},
	},
	extensions = {'nvim-tree', 'neo-tree'}
}
