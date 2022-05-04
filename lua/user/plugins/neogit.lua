local neogit_status_ok, neogit = pcall(require, "neogit")
if not neogit_status_ok then
  return
end

neogit.setup({
	integrations = {
		diffview = true
	}
})

vim.api.nvim_set_keymap('n', '<leader>hn', '<CMD>Neogit<CR>', {})