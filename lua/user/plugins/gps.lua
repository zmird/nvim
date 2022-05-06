local gps_status_ok, gps = pcall(require, "nvim-gps")
if not gps_status_ok then
  return
end

local treesitter_status_ok, _ = pcall(require, "nvim-treesitter.query")
if not treesitter_status_ok then
  return
end

gps.setup({
	icons = {
		["class-name"] = ' ',      -- Classes and class-like objects
		["function-name"] = ' ',   -- Functions
		["method-name"] = ' '      -- Methods (functions inside class-like objects)
	},
	-- Disable any languages individually over here
	-- Any language not disabled here is enabled by default
	languages = {
		["html"] = false,
	},
	separator = ' > ',
})
