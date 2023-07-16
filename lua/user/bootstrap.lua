----- Options -----

require("user.options")

----- Auto commands -----

require("user.autocmds")

----- Mappings -----

vim.cmd [[noremap! <C-BS> <C-w>]]            -- mapping for ctrl backspace
vim.cmd [[noremap! <C-h> <C-w>]]             -- mapping for ctrl backspace
vim.cmd [[tnoremap <Esc> <C-\><C-n>]]
vim.cmd [[tnoremap <C-v><Esc> <Esc>]]

require("user.utils").load_mappings()

----- Commands -----

vim.api.nvim_create_user_command("Dashboard", function()
  require("user.dashboard").open()
end, {})

vim.api.nvim_create_user_command("EditConfig", function()
  require("user.utils").edit_config()
end, {})

vim.api.nvim_create_user_command("SetAnsibleFiletype", function()
  require("user.utils").set_ansible_filetype()
end, {})

----- Plugins -----

require("user.lazy")

----- Modules -----

require('user.modules')

----- Colorscheme -----

local colorscheme = "catppuccin"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
  print("Could not load colorscheme " .. colorscheme)
end
