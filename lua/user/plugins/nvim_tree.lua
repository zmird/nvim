local tree_status_ok, tree = pcall(require, "nvim-tree")
if not tree_status_ok then
  return
end

local tree_cb = require("nvim-tree.config").nvim_tree_callback
local g = vim.g

g.nvim_tree_git_hl = 1                    -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
g.nvim_tree_highlight_opened_files = 0    -- 0 by default, will enable folder and file icon highlight for opened files/directories.
g.nvim_tree_root_folder_modifier = ':~'   -- This is the default. See :help filename-modifiers for more options
g.nvim_tree_add_trailing = 0              -- 0 by default, append a trailing slash to folder names
g.nvim_tree_group_empty = 1               -- 0 by default, compact folders that only contain a single folder into one node in the file tree
g.nvim_tree_icon_padding = ' '            -- one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
g.nvim_tree_symlink_arrow = ' >> '        -- defaults to ' ➛ '. used as a separator between symlinks' source and target.
g.nvim_tree_respect_buf_cwd = 0           -- 0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
g.nvim_tree_create_in_closed_folder = 1   -- 0 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
-- g.nvim_tree_root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" }
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
      staged    = "S",
      unmerged  = "",
      renamed   = "➜",
      untracked = "U",
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
    preserve_window_proportions = true,
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
          filetype = { "notify", "packer", "qf", "dashboard", "alpha" },
          buftype = { "terminal" },
        }
      }
    }
  },
}

vim.cmd[[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]]
