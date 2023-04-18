-- Return to the closed position when reopening
vim.cmd [[au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]]

-- Filetypes
vim.cmd [[au Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4]]
vim.cmd [[au Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4]]

-- Detect ansible type
vim.cmd [[au BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible]]
vim.cmd [[au BufRead,BufNewFile */tasks/*.yml set filetype=yaml.ansible]]
-- vim.cmd [[au BufRead,BufNewFile */tasks/**/*.yml set filetype=yaml.ansible]]

-- Remove sign column
vim.cmd [[au FileType Outline setlocal signcolumn=no ]]
