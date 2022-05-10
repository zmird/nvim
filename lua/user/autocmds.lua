-- Return to the closed position when reopening
vim.cmd [[ au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]]

-- Filetypes
vim.cmd [[autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4]]
vim.cmd [[autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4]]
