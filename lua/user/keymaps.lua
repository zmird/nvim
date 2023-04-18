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

keymap("n", "<c-x>", "<cmd>lua require('user.utils').close_buffer()<cr>", opts)
keymap("n", "<C-s>", "<cmd>lua vim.api.nvim_command('write')<CR>", opts)          -- save file
keymap("i", "<C-s>", "<Esc><cmd>lua vim.api.nvim_command('write')<CR>i", opts)    -- save file in insert mode
-- keymap('t', '<Esc>', '<C-\\><C-n>', opts)    -- exit terminal mode

-- NeoTree
keymap('n', '<C-g>', "<cmd>NeoTreeFocusToggle<cr>", opts)

-- Telescope
keymap('n', '<Leader>fg', '<cmd>Telescope live_grep<cr>', opts)
keymap("n", '<leader>ff', "<cmd>Telescope find_files<cr>", opts)
keymap('n', '<Leader>fb', '<cmd>Telescope buffers<cr>', opts)
keymap('n', '<Leader>fs', '<cmd>Telescope git_status<cr>', opts)
keymap('n', '<Leader>fR', '<cmd>Telescope registers<cr>', opts)
keymap('n', '<Leader>fj', '<cmd>Telescope jump_list<cr>', opts)

keymap('n', '<Leader>fr', '<cmd>Telescope lsp_references<cr>', opts)
keymap('n', 'gu', '<cmd>Telescope lsp_references<cr>', opts)
keymap('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', opts)

-- keymap('n', '<Leader>fp', '<cmd>Telescope project<cr>', opts)
-- keymap('n', '<Leader>fc', '<cmd>Telescope lsp_code_actions<cr>', opts)

-- Comment
keymap("n", "<C-_>", "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>", opts)
keymap("x", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)

-- Ufo folding
keymap('n', 'zR', '<cmd>lua require("ufo").openAllFolds()<cr>', opts)
keymap('n', 'zM', '<cmd>lua require("ufo").closeAllFolds()<cr>', opts)

--- Bufferline
keymap("n", "<C-h>", ":BufferLineCyclePrev<CR>", opts)     -- buffer previous
keymap("n", "<C-l>", ":BufferLineCycleNext<CR>", opts)     -- buffer next

--- Symbols Outline
keymap("n", "gs", "<cmd>SymbolsOutline<cr>", opts)

-- Toggleterm
keymap("n", "<Leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<cr>", opts)

-- Orgmode
keymap("n", "<Leader>oa", "<cmd>lua require('user.functions').OpenAgenda()<cr>", opts)
keymap("n", "<Leader>oc", "<cmd>lua require('user.functions').OpenCapture()<cr>", opts)
