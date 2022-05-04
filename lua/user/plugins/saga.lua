local lspsaga_status_ok, lspsaga = pcall(require, "lspsaga")
if not lspsaga_status_ok then
  return
end

lspsaga.init_lsp_saga {
  code_action_icon = '💡',
  code_action_prompt = {
    enable        = true,
    sign          = true,
    sign_priority = 15,
    virtual_text  = false,
  },
  code_action_keys = { quit = {'q', '<ESC>'}, exec = '<CR>' },
  border_style     = "round",
}

local opts = {noremap = true, silent = true}
vim.api.nvim_set_keymap('n', '<Leader>lh', '<CMD>Lspsaga hover_doc<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>lr', '<CMD>Lspsaga rename<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>lc', '<CMD>Lspsaga code_action<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>ls', '<CMD>Lspsaga signature_help<CR>', opts)

vim.api.nvim_set_keymap('n', '<M-CR>', '<CMD>Lspsaga code_action<CR>', opts) -- Alt+Enter
vim.api.nvim_set_keymap('i', '<M-CR>', '<Esc><CMD>Lspsaga code_action<CR>i', opts) -- Alt+Enter

vim.cmd[[nnoremap <silent> <A-d> :Lspsaga open_floaterm<CR>]]
vim.cmd[[tnoremap <silent> <A-d> <C-\><C-n>:Lspsaga close_floaterm<CR>]]
