local gps_status_ok, gps = pcall(require, "nvim-gps")
if not gps_status_ok then
  return
end

local treesitter_status_ok, _ = pcall(require, "nvim-treesitter.query")
if not treesitter_status_ok then
  return
end

local icons_status_ok, icons = pcall(require, "user.icons")
if not icons_status_ok then
  return
end

gps.setup({
	icons = {
		["class-name"] = icons.treeDiagram .. ' ',    -- Classes and class-like objects
		["function-name"] = icons.f .. ' ',   				-- Functions
		["method-name"] = icons.container .. ' '      -- Methods (functions inside class-like objects)
	},
	-- Disable any languages individually over here
	-- Any language not disabled here is enabled by default
	languages = {
		["html"] = false,
	},
	separator = ' > ',
})
