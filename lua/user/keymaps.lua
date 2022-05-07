local opts = { noremap = true, silent = true }

vim.cmd [[noremap! <C-BS> <C-w>]] -- mapping for ctrl backspace
vim.cmd [[noremap! <C-h> <C-w>]] -- mapping for ctrl backspace

local keymap = vim.api.nvim_set_keymap

keymap('n', '<C-j>', ':bprev<CR>', opts)     -- buffer previous
keymap('n', '<C-k>', ':bnext<CR>', opts)     -- buffer next
keymap('n', '<C-h>', '<C-W>h', opts)         -- left split
keymap('n', '<C-l>', '<C-W>l', opts)         -- right split
keymap('n', '<C-s>', ':w<CR>', opts)         -- save file
keymap('i', '<C-s>', '<Esc>:w<CR>i', opts)   -- save file in insert mode
keymap('n', '<C-h>', ':noh<CR>', opts)       -- turn off highlighting
keymap('t', '<Esc>', '<C-\\><C-n>', opts)    -- exit terminal mode

-- NeoVim Tree
-- keymap('n', '<C-g>', "<cmd>lua require'nvim-tree'.toggle()<CR>", opts)

-- NeoTree
keymap('n', '<C-g>', "<cmd>Neotree toggle<cr>", opts)

-- Telescope
keymap("n", "<leader>ff", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
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

-- Dashboard
keymap('n', '<Leader>ss', ':<C-u>SessionSave<CR>', opts)
keymap('n', '<Leader>sl', ':<C-u>SessionLoad<CR>', opts)
keymap('n', '<Leader>fc', ':e ~/.config/nvim/init.lua<CR>', opts) -- edit conf

-- Neogit
keymap('n', '<leader>hn', '<CMD>Neogit<CR>', opts)

-- Packer
vim.cmd "silent! command PackerClean lua require 'plugins' require('packer').clean()"
vim.cmd "silent! command PackerCompile lua require 'plugins' require('packer').compile()"
vim.cmd "silent! command PackerInstall lua require 'plugins' require('packer').install()"
vim.cmd "silent! command PackerStatus lua require 'plugins' require('packer').status()"
vim.cmd "silent! command PackerSync lua require 'plugins' require('packer').sync()"
vim.cmd "silent! command PackerUpdate lua require 'plugins' require('packer').update()"