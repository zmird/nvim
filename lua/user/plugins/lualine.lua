local lualine_status_ok, lualine = pcall(require, "lualine")
if not lualine_status_ok then
  return
end

local navic_status_ok, navic = pcall(require, "nvim-navic")
if not navic_status_ok then
  return
end

local colors_status_ok, colors = pcall(require, "user.colors")
if not colors_status_ok then
	return
end

local icons_status_ok, icons = pcall(require, "user.icons")
if not icons_status_ok then
	return
end

local conditions = {
	not_neotree = function ()
		return not vim.bo.filetype == "neo-tree"
	end,
	not_alpha = function ()
		return not vim.bo.filetype == "alpha"
	end,
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    globalstatus = false,
		theme = "github_dark",
    component_separators = '',
    section_separators = '',
    disabled_filetypes = {
      'neo-tree',
      'Outline',
    }
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
	extensions = {'neo-tree'}
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
  -- mode component
  function()
    return '▊'
  end,
  color = function()
		local mode = require("lualine.utils.mode").get_mode()
		local inactive_hi = { bg = colors.bg2, fg = colors.fg_dark }
		local mode_color = {
			normal = colors.blue,
			insert = colors.green,
			command = colors.magenta,
			visual = colors.yellow,
			replace = colors.red,
			terminal= colors.orange,
			inactive = {
				a = inactive_hi,
				b = inactive_hi,
				c = inactive_hi,
			}
		}
    return { fg = mode_color[string.lower(mode)] }
  end,
  padding = { left = 0, right = 1 }, -- We don't need space before this
}

ins_left {
  'filename',
  path = 1,
  cond = conditions.buffer_not_empty,
  color = { fg = colors.white, gui = 'bold' },
}


ins_left {
  -- Lsp server name .
  function()
    local msg = ''
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client.name ~= "null-ls" then
        return client.name
      end
    end
    return msg
  end,
  icon = '',
  color = { fg = colors.fg },
}

ins_left {
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
}

ins_left {
	navic.get_location,
	cond = navic.is_available
}

-- Right section

ins_right {
	'diff',
	color_added = colors.git.add,
	color_modified = colors.git.change,
	color_removed = colors.git.delete,
	symbols = {
		added = icons.gitAdd .. ' ',
		modified = icons.gitChange,
		removed = icons.gitRemove .. ' ',
	},
	padding = { right = 2 }
}

ins_right {
  'branch',
  icon = icons.branch,
  color = { fg = colors.git.add, gui = 'bold' },
}

ins_right {
	'location',
	padding = { left = 1 , right = 2},
	-- cond = conditions.not_alpha,
}

ins_right {
	'progress',
	-- icon = "",
	padding = { left = 0, right = 2 },
	-- cond = conditions.not_alpha,
}

ins_right {
	'filetype',
	colored = true,
	padding = { left = 1, right = 1 },
}

lualine.setup(config)
