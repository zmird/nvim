local which_key_status_ok, which_key = pcall(require, "which-key")
if not which_key_status_ok then
  return
end

which_key.register({}, {
	prefix = "<Leader>",
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    spelling = {
      enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
})

local options = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local mappings = {
	["1"] = {"Buffer 1"},
	["2"] = {"Buffer 2"},
	["3"] = {"Buffer 3"},
	["4"] = {"Buffer 4"},
	["5"] = {"Buffer 5"},
	["6"] = {"Buffer 6"},
	["7"] = {"Buffer 7"},
	["8"] = {"Buffer 8"},
	["9"] = {"Buffer 9"},

  -- single
  ["+"] = { '<cmd>vertical resize +2<CR>',               'resize +2' },
  ["-"] = { '<cmd>vertical resize -2<CR>',               'resize +2' },
  ["="] = { '<C-W>=',                                    'balance windows' },
  ["v"] = { '<C-W>v',                                    'split right' },
  ["V"] = { '<C-W>s',                                    'split below' },

  -- Bufferline
	b = {
		name = "Bufferline",
		n    = {"Next"},
		p    = {"Previous"},
		b    = {"Pick"},
		c    = {"Pick close"},
		x    = {"Close"},
		r    = {"Close right"},
		l    = {"Close left"},
	},
  
  -- Telescope
	f = {
		name = "Telescope",
		o = {"Recent files"},
		m = {"Marks"},
		p = {"Projects"},
		f = {"Find file"},
		c = {"Code actions"},
		h = {"Command history"},
		b = {"Buffers"},
		r = {"Registers"},
		g = {"Live grep"},
		s = {"Git status"},
		q = {"Git stash"},
		j = {"Jump list"},
		x = {"Fuzzy find"},
	},
  
  -- Toggleterm
	t = {
		name = "Terminal",
		n = {"New"},
		t = {"Open all"},
		c = {"Close all"},
  },
  
  -- LSP
	l = {
		name = "Lsp",
		h = {"Hover docs"},
		r = {"Rename"},
		c = {"Code actions"},
		s = {"Signature help"},
		f = {"Format document"},
		w = {"Workspace diagnostics"},
		l = {"Lsp references"},
		q = {"Quickfix"},
	},
	d = {
		name = "Diagnostics",
		n = {"Next"},
		p = {"Previous"}
	},
  
  -- Session
	s = {
		name = "Session",
		l = {"Load"},
		s = {"Save"}
	}
}

local wk = require"which-key"
wk.register(mappings, options)

-- vim.api.nvim_set_keymap("n", "<leader>", "<cmd>WhichKey ' '<cr>", {noremap = true})