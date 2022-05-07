-- Filetypes
vim.cmd [[autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4]]
vim.cmd [[autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4]]

-- Legendary
local legendary_status_ok, legendary = pcall(require, "legendary")
if not legendary_status_ok then
  return
else
  -- search keymaps, commands, and autocmds
  legendary.find()
  -- search keymaps
  legendary.find('keymaps')
  -- search commands
  legendary.find('commands')
  -- search autocmds
  legendary.find('autocmds')
end