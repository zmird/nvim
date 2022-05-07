---------------
-- Settings  --
---------------
-- >:help options to know more about individual settings
local options = {
  autoindent     = true,                        -- Good auto indent
  autoread       = true,                        -- Sync external file changes
  background     = "dark",
  backspace      = "indent,eol,start",          -- Allow backspace to delete indentation and inserted text
  backup         = false,                       -- Creates a backup file
  clipboard      = "unnamedplus",               -- Allows neovim to access the system clipboard
  cmdheight      = 2,                           -- Give more space in the neovim comand line
  completeopt    = "menu,menuone,noinsert",     -- Better autocompletion
  copyindent     = true,                        -- Copy indent from the previous line
  cursorline     = true,                        -- Highlight current line
  conceallevel   = 0,                           -- Show `` in markdown files
  emoji          = false,                       -- Fix emoji display
  encoding       = "utf-8",                     -- Change how vim represents characters on the screen
  expandtab      = true,                        -- Use spaces instead of tabs
  fileencoding   = "utf-8",                     -- Encoding of created files
  foldlevelstart = 99,                          -- Expand all folds by default
  foldmethod     = "indent",
  foldnestmax    = 10,
  foldtext       = "CustomFold()",              -- Emit custom function for fold text
  hidden         = true,                        -- Enable hidden buffers
  history        = 1000,
  hlsearch       = true,                        -- Highlight all matches on previous search pattern
  ignorecase     = true,                        -- Ignore case when searching
  incsearch      = true,                        -- Search as characters are entered
  lazyredraw     = true,                        -- Makes macros faster & prevent errors in complicated mappings
  mouse          = "a",                         -- Enable mouse support
  number         = true,                        -- Show line numbers
  pumheight      = 10,                          -- Number of lines in the popup menu
  relativenumber = false,                       -- Show line numbers relative to current line
  scrolloff      = 8,                           -- Always keep space when scrolling to bottom/top edge
  sidescrolloff      = 8,                       -- Always keep space when scrolling to left/righ edge
  shiftwidth     = 2,                           -- Number of spaces to use when shifting
  showtabline    = 2,                           -- Always show tabs
  showmatch      = true,                        -- Highlight matching braces
  showmode       = false,                       -- Don't show mode in status bar
  signcolumn     = "yes",                       -- Add extra sign column next to line number
  smartcase      = true,                        -- Include only uppercasewords with uppercase search term
  smartindent    = true,                        -- Autoindent when starting a new line
  smarttab       = true,                        -- Smart tabbing recognizes tab sizes
  softtabstop    = 2,                           -- Number of spaces in tab when editing
  splitbelow     = true,                        -- Split windows below current window
  splitright     = true,                        -- Vertical splits always to thr right
  swapfile       = false,                       -- Create swapfile
  tabstop        = 2,                           -- Number of visual spaces per tab
  termguicolors  = true,                        -- Set term gui colors
  timeoutlen     = 200,                         -- Time to wait for a mapped sequence to complete
  undofile       = true,                        -- Persistant undo history
  updatetime     = 100,                         -- Faster completion
  visualbell     = true,                        -- Flash screen instead of beep sound
  viminfo        = "'1000",                     -- Keep 1000 lines of history
  wildmenu       = true,                        -- Autocomplete for command menu
  wildignore     = "*node_modules/**",          -- Don't search in node_modules
  wrap           = false,                       -- Don't wrap lines
  writebackup    = false,                       -- Don't write backup files
}

local globals = {
  mapleader                = " ",
  fillchars                = "fold:\\",
  loaded_matchparen        = 1,
  loaded_matchit           = 1,
  loaded_logiPat           = 1,
  loaded_rrhelper          = 1,
  loaded_tarPlugin         = 1,
  loaded_gzip              = 1,
  loaded_zipPlugin         = 1,
  loaded_2html_plugin      = 1,
  loaded_shada_plugin      = 1,
  loaded_spellfile_plugin  = 1,
  loaded_netrw             = 1,
  loaded_netrwPlugin       = 1,
  loaded_tutor_mode_plugin = 1,
  loaded_remote_plugins    = 1,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

for k, v in pairs(globals) do
  vim.g[k] = v
end

vim.opt.shortmess:append "c"
vim.opt.iskeyword:append "-"
vim.opt.formatoptions:remove "cro"

-- Set cursor as a bar in insert mode
vim.cmd [[let &t_SI = "\e[6 q"]]
vim.cmd [[let &t_EI = "\e[2 q"]]

-- Remove tildes at the end of buffer
vim.cmd [[let &fcs='eob: ']]

-- Return to the closed position when reopening
vim.cmd [[ au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]]

-- Hightlighting
vim.cmd [[hi Cursor gui=reverse guibg=NONE guifg=NONE]]
vim.cmd [[hi CursorLine term=bold cterm=bold guibg=grey]]
vim.cmd [[hi LineNr ctermfg=DarkGrey]]