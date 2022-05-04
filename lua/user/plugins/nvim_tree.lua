local tree_status_ok, tree = pcall(require, "nvim-tree")
if not tree_status_ok then
  return
end

local tree_cb = require("nvim-tree.config").nvim_tree_callback
local g = vim.g

g.nvim_tree_respect_buf_cwd = 1
g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
g.nvim_tree_git_hl = 0
g.nvim_tree_highlight_opened_files = 0
-- g.nvim_tree_root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" }
g.nvim_tree_icon_padding = ' '
g.nvim_tree_show_icons = {
  git           = 1,
  folders       = 1,
  files         = 1,
  folder_arrows = 0,
}
g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
      unstaged  = "",
      staged    = "✓",
      unmerged  = "",
      renamed   = "➜",
      untracked = "",
      deleted   = "",
      ignored   = "◌"
  },
  folder = {
    -- disable indent_markers option to get arrows working 
    -- or if you want both arrows and indent then just add 
    -- the arrow icons in front of the default and opened folders below!
    default       = "",
    empty         = "",
    empty_open    = "",
    open          = "",
    symlink       = "",
    symlink_open  = "",
  },
}

tree.setup {
  -- ignore                  = {".git", "node_modules", ".cache", ".vagrant"},
  -- gitignore               = true,
  -- auto_open               = false,
  -- follow                  = true,
  -- hide_dotfiles           = true,
  -- tab_open                = false,
  -- allow_resize            = true,

  auto_reload_on_write = true,
  disable_netrw = true,
  hijack_cursor = false,
  hijack_netrw = false,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup = false,
  open_on_setup = false,
  open_on_setup_file = false,
  open_on_tab = true,
  sort_by = "name",
  update_cwd = true,
  view = {
    width = 25,
    height = 30,
    hide_root_folder = true,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = {
        {key = "?", cb = tree_cb("toggle_help")},
      },
    },
  },
  renderer = {
    indent_markers = {
      enable = true,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
    }
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = false,
    update_cwd = false,
    ignore_list = {},
  },
  ignore_ft_on_setup = {},
  system_open = {
    cmd = "",
    args = {},
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  filters = {
    dotfiles = true,
    custom = { ".git", "__pycache__" },
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    open_file = {
      quit_on_open = false,
      window_picker = {
        enable = true,
        exclude = {
          filetype = { "notify", "packer", "qf", "dashboard" },
          buftype = { "terminal" },
        }
      }
    }
  },
}

vim.cmd[[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]]

vim.api.nvim_set_keymap('n', '<C-g>', "<cmd>lua require'nvim-tree'.toggle()<CR>", { noremap = true, silent = true})

-- Highlight
vim.cmd[[hi NvimTreeRootFolder guifg=bg guibg=bg]]

vim.cmd[[hi NvimTreeFolderIcon guifg=#61AFEF]]
vim.cmd[[highlight NvimTreeFolderName guifg=#61AFEF]]