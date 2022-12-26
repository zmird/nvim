local utils_status_ok, utils = pcall(require, "user.utils")
if not utils_status_ok then
  return
end

local opts = { noremap = true, silent = true }

vim.cmd [[noremap! <C-BS> <C-w>]]            -- mapping for ctrl backspace
vim.cmd [[noremap! <C-h> <C-w>]]             -- mapping for ctrl backspace
vim.cmd [[tnoremap <Esc> <C-\><C-n>]]
vim.cmd [[tnoremap <C-v><Esc> <Esc>]]

local keymap = vim.api.nvim_set_keymap

keymap('n', '<c-x>', '<cmd>lua require("user.utils").close_buffer()<cr>', opts)
-- keymap('n', '<C-h>', '<C-W>h', opts)         -- left split
-- keymap('n', '<C-l>', '<C-W>l', opts)         -- right split
keymap('n', '<C-s>', ':w<CR>', opts)         -- save file
keymap('i', '<C-s>', '<Esc>:w<CR>i', opts)   -- save file in insert mode
keymap('n', '<C-h>', ':noh<CR>', opts)       -- turn off highlighting
-- keymap('t', '<Esc>', '<C-\\><C-n>', opts)    -- exit terminal mode

-- NeoTree
keymap('n', '<C-g>', "<cmd>Neotree toggle<cr>", opts)

-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
keymap('n', '<Leader>fo', '<cmd>Telescope oldfiles<cr>', opts)
keymap('n', '<Leader>fm', '<cmd>Telescope marks<cr>', opts)
keymap('n', '<Leader>fp', '<cmd>Telescope project<cr>', opts)
keymap('n', '<Leader>fc', '<cmd>Telescope lsp_code_actions<cr>', opts)
keymap('n', '<Leader>fh', '<cmd>Telescope command_history<cr>', opts)

keymap('n', '<Leader>fb', '<cmd>Telescope buffers<cr>', opts)
keymap('n', '<Leader>fr', '<cmd>Telescope registers<cr>', opts)
keymap('n', '<Leader>fg', '<cmd>Telescope live_grep<cr>', opts)
keymap('n', '<Leader>fs', '<cmd>Telescope git_status<cr>', opts)
keymap('n', '<Leader>fq', '<cmd>Telescope git_stash<cr>', opts)

keymap('n', '<Leader>fj', '<cmd>Telescope jump_list<cr>', opts)
keymap('n', '<Leader>fz', '<cmd>Telescope current_buffer_fuzzy_find<cr>', opts)

-- Comment
keymap("n", "<C-_>", "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>", opts)
keymap("x", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)

--- Bufferline
keymap('n', '<C-h>', ':BufferLineCyclePrev<CR>', opts)     -- buffer previous
keymap('n', '<C-l>', ':BufferLineCycleNext<CR>', opts)     -- buffer next

-- Toggleterm
keymap("n", "<Leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<cr>", opts)

-- Packer
vim.cmd "silent! command PackerClean lua require 'plugins' require('packer').clean()"
vim.cmd "silent! command PackerCompile lua require 'plugins' require('packer').compile()"
vim.cmd "silent! command PackerInstall lua require 'plugins' require('packer').install()"
vim.cmd "silent! command PackerStatus lua require 'plugins' require('packer').status()"
vim.cmd "silent! command PackerSync lua require 'plugins' require('packer').sync()"
vim.cmd "silent! command PackerUpdate lua require 'plugins' require('packer').update()"
