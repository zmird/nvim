local navic_status_ok, navic = pcall(require, "nvim-navic")
if not navic_status_ok then
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

navic.setup({
  icons = {
    File          = icons.code.file .. ' ',
    Module        = icons.code.module .. ' ',
    Namespace     = icons.code.namespace .. ' ',
    Package       = icons.code.package .. ' ',
    Class         = icons.code.class .. ' ',
    Method        = icons.code.method .. ' ',
    Property      = icons.code.property .. ' ',
    Field         = icons.code.field .. ' ',
    Constructor   = icons.code.constructor .. ' ',
    Enum          = icons.code.enum .. ' ',
    Interface     = icons.code.interface .. ' ',
    Function      = icons.code.func .. ' ',
    Variable      = icons.code.variable .. ' ',
    Constant      = icons.code.constant .. ' ',
    String        = icons.code.string .. ' ',
    Number        = icons.code.number .. ' ',
    Boolean       = icons.code.boolean .. ' ',
    Array         = icons.code.array .. ' ',
    Object        = icons.code.object .. ' ',
    Key           = icons.code.key .. ' ',
    Null          = icons.code.null .. ' ',
    EnumMember    = icons.code.enum .. ' ',
    Struct        = icons.code.struct .. ' ',
    Event         = icons.code.event .. ' ',
    Operator      = icons.code.operator .. ' ',
    TypeParameter = icons.code.typeParameter .. ' ',
  },
	-- icons = {
	-- 	["class-name"] = icons.treeDiagram .. ' ',    -- Classes and class-like objects
	-- 	["function-name"] = icons.f .. ' ',   				-- Functions
	-- 	["method-name"] = icons.container .. ' '      -- Methods (functions inside class-like objects)
	-- },
	-- Disable any languages individually over here
	-- Any language not disabled here is enabled by default
	languages = {
		["html"] = false,
	},
	separator = ' > ',
})
