local trouble_status_ok, trouble = pcall(require, "trouble")
if not trouble_status_ok then
  return
end

local icons_status_ok, icons = pcall(require, "user.icons")
if not icons_status_ok then
  return
end

trouble.setup{
	position = "bottom", -- position of the list can be: bottom, top, left, right
	height = 10, -- height of the trouble list when position is top or bottom
	width = 50, -- width of the list when position is left or right
	icons = {}, -- use devicons for filenames
	mode = "workspace_diagnostics", -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
	fold_open = "", -- icon used for open folds
	fold_closed = "", -- icon used for closed folds
	action_keys = { -- key mappings for actions in the trouble list
			-- map to {} to remove a mapping, for example:
			-- close = {},
			close = "q", -- close the list
			cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
			refresh = "r", -- manually refresh
			jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
			open_split = { "<c-x>" }, -- open buffer in new split
			open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
			open_tab = { "<c-t>" }, -- open buffer in new tab
			jump_close = {"o"}, -- jump to the diagnostic and close the list
			toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
			toggle_preview = "P", -- toggle auto_preview
			hover = "K", -- opens a small poup with the full multiline message
			preview = "p", -- preview the diagnostic location
			close_folds = {"zM", "zm"}, -- close all folds
			open_folds = {"zR", "zr"}, -- open all folds
			toggle_fold = {"zA", "za"}, -- toggle fold of current file
			previous = "k", -- preview item
			next = "j" -- next item
	},
	indent_lines = true, -- add an indent guide below the fold icons
	auto_open = false, -- automatically open the list when you have diagnostics
	auto_close = false, -- automatically close the list when you have no diagnostics
	auto_preview = true, -- automatyically preview the location of the diagnostic. <esc> to close preview and go back to last window
	auto_fold = false, -- automatically fold a file trouble list at creation
	signs = {
			-- icons / text used for a diagnostic
			error = icons.symbols.error,
			warning = icons.symbols.warning,
			hint = icons.symbols.hint,
			information = icons.symbols.info,
			other = icons.symbols.check
	},
	use_diagnostic_signs = true -- enabling this will use the signs defined in your lsp client
}

-- Key mapping
vim.api.nvim_set_keymap('n', '<Leader>lw', ':TroubleToggle lsp_workspace_diagnostics<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>ll', ':TroubleToggle lsp_references<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>lq', ':TroubleToggle quickfix<CR>', {})
