local colorschemes = {
	ayu_dark = {
		black  = '#0f1419',
		white  = '#e6e1cf',
		grey   = '#3e4b59',
		blue   = '#36a3d9',
		red    = '#f07178',
		orange = '#ffb454',
		green  = '#b8cc52',
		yellow = '#ffee99',
		purple = '#a37acc',
	},
	onedark  = {
		black  = '#282c34',
		white  = '#abb2bf',
		gray   = '#5c6370',
		blue   = '#61afef',
		red    = '#e06c75',
		orange = '#d19a66',
		green  = '#98c379',
		yellow = '#e5c07b',
		purple = '#c678dd',
	},
	tokyonight = {
		black  = "#1f2335",
		white  = "#FFFFFF",
		gray   = "#565f89",
		blue   = "#7aa2f7",
		red    = "#f7768e",
		orange = "#ff9e64",
		green  = "#9ece6a",
		yellow = "#e0af68",
		purple = "#9d7cd8",
	}
}

local current_colorscheme = "onedark"
local colors = colorschemes[current_colorscheme]

local lualine_status_ok, lualine = pcall(require, "lualine")
if not lualine_status_ok then
  return
end

local gps_status_ok, gps = pcall(require, "nvim-gps")
if not gps_status_ok then
  return
end

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
				color_added = colors.green,
				color_modified = colors.orange,
				color_removed = colors.red,
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
	extensions = {'nvim-tree'}
}
