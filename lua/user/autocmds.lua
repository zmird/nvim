-- Filetypes
vim.cmd [[autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4]]
vim.cmd [[autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4]]

-- Neotree
vim.cmd [[autocmd BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "neo-tree" | set laststatus=0 | else | set laststatus=2 | endif]]