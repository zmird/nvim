local tree_status_ok, tree = pcall(require, "neo-tree")
if not tree_status_ok then
  return
end

local icons_status_ok, icons = pcall(require, "user.icons")
if not icons_status_ok then
  return
end

local utils_status_ok, utils = pcall(require, "user.utils")
if not utils_status_ok then
  return
end


vim.g.neo_tree_remove_legacy_commands = 1

-- NOTE: this is changed from v1.x, which used the old style of highlight groups
-- in the form "LspDiagnosticsSignWarning"

tree.setup(
  {
  close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
  -- close_floats_on_escape_key = true,
  default_source = "filesystem",
  enable_diagnostics = true,
  enable_git_status = true,
  enable_modified_markers = true, -- Show markers for files with unsaved changes.
  enable_refresh_on_write = true, -- Refresh the tree when a file is written. Only used if `use_libuv_file_watcher` is false.
  git_status_async = true,
  -- These options are for people with VERY large git repos
  git_status_async_options = {
    batch_size = 1000, -- how many lines of git status results to process at a time
    batch_delay = 10,  -- delay in ms between batches. Spreads out the workload to let other processes run.
    max_lines = 10000, -- How many lines of git status results to process. Anything after this will be dropped.
                       -- Anything before this will be used. The last items to be processed are the untracked files.
  },
  log_level = "info", -- "trace", "debug", "info", "warn", "error", "fatal"
  log_to_file = false, -- true, false, "/path/to/file.log", use :NeoTreeLogs to show the file
  open_files_in_last_window = true, -- false = open files in top left window
  popup_border_style = "NC", -- "double", "none", "rounded", "shadow", "single" or "solid"
  resize_timer_interval = 500, -- in ms, needed for containers to redraw right aligned and faded content
                               -- set to -1 to disable the resize timer entirely
  --                           -- NOTE: this will speed up to 50 ms for 1 second following a resize
  sort_case_insensitive = false, -- used when sorting files and directories in the tree
  use_popups_for_input = true, -- If false, inputs will use vim.ui.input() instead of custom floats.
  use_default_mappings = true,
  default_component_configs = {
    container = {
      enable_character_fade = true
    },
    indent = {
      indent_size = 2,
      padding = 1,
      -- indent guides
      with_markers = false,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
      -- expander config, needed for nesting files
      with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      folder_closed = icons.folder,
      folder_open = icons.folderOpen,
      folder_empty = icons.folder,
      -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
      -- then these will never be used.
      default = icons.textFile,
      highlight = "NeoTreeFileIcon"
    },
    modified = {
      symbol = "[+]",
      highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = "NeoTreeFileName",
    },
    git_status = {
      symbols = {
        -- Change type
        added     = icons.plus, -- or "✚", but this is redundant info if you use git_status_colors on the name
        modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
        deleted   = icons.minus,-- this can only be used in the git_status source
        renamed   = icons.arrowRight,-- this can only be used in the git_status source
        -- Status type
        untracked = "? ",
        ignored   = icons.errorSlash,
        unstaged  = icons.dot .. " ",
        staged    = icons.check .. " ",
        conflict  = icons.merge,
      },
    },
    diagnostics = {
      symbols = {
        error = icons.error,
        warn = icons.warningTriangle,
        info = icons.info,
        hint = icons.lightbulb
      },
      highlights = {
        error = "DiagnosticSignError",
        warn = "DiagnosticSignWarn",
        info = "DiagnosticSignInfo",
        hint = "DiagnosticSignHint"
      }

    }
  },
  renderers = {
    directory = {
      { "indent" },
      { "icon" },
      { "current_filter" },
      {
        "container",
        width = "100%",
        right_padding = 1,
        content = {
          { "name", zindex = 10 },
          { "clipboard", zindex = 10 },
        },
      },
    },
    file = {
      { "indent" },
      { "icon" },
      {
        "container",
        width = "100%",
        right_padding = 1,
        content = {
          { "git_status", zindex = 20, align = "left" },
          {
            "name",
            use_git_status_colors = true,
            zindex = 10
          },
          { "diagnostics", errors_only = false, zindex = 20, align = "right" },
        },
      },
    },
    message = {
      { "indent", with_markers = false },
      { "name", highlight = "NeoTreeMessage" },
    },
    terminal = {
      { "indent" },
      { "icon" },
      { "name" },
      { "bufnr" }
    }
  },
  nesting_rules = {},
  window = { -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
             -- possible options. These can also be functions that return these options.
    position = "left", -- left, right, float, current
    width = 40, -- applies to left and right positions
    popup = { -- settings that apply to float position only
      size = {
        height = "80%",
        width = "50%",
      },
      position = "50%", -- 50% means center it
      -- you can also specify border here, if you want a different setting from
      -- the global popup_border_style.
    },
    -- Mappings for tree window. See `:h neo-tree-mappings` for a list of built-in commands.
    -- You can also create your own commands by providing a function instead of a string.
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ["<space>"] = {
          "toggle_node",
          nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
      },
      ["<2-LeftMouse>"] = "open",
      ["<cr>"] = "open",
      ["S"] = "open_split",
      -- ["S"] = "split_with_window_picker",
      ["s"] = "open_vsplit",
      -- ["s"] = "vsplit_with_window_picker",
      ["t"] = "open_tabnew",
      ["w"] = "open_with_window_picker",
      ["C"] = "close_node",
      ["z"] = "close_all_nodes",
      ["R"] = "refresh",
      ["a"] = {
        "add",
        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        config = {
          show_path = "none" -- "none", "relative", "absolute"
        }
      },
      ["A"] = "add_directory", -- also accepts the config.show_path option.
      ["d"] = "delete",
      ["r"] = "rename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["c"] = "copy", -- takes text input for destination
      ["m"] = "move", -- takes text input for destination
      ["q"] = "close_window",
      ["?"] = "show_help",
    },
  },
  filesystem = {
    window = {
      mappings = {
        ["H"] = "toggle_hidden",
        ["/"] = "fuzzy_finder",
        --["/"] = "filter_as_you_type", -- this was the default until v1.28
        ["f"] = "filter_on_submit",
        ["<C-x>"] = "clear_filter",
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        ["[g"] = "prev_git_modified",
        ["]g"] = "next_git_modified",
      }
    },
    async_directory_scan = "auto", -- "auto"   means refreshes are async, but it's synchronous when called from the Neotree commands.
                                   -- "always" means directory scans are always async.
                                   -- "never"  means directory scans are never async.
    bind_to_cwd = false, -- true creates a 2-way binding between vim's cwd and neo-tree's root
    components = {
      name = function(config, node, state)
        -- first call the default name component
        local cc = require("neo-tree.sources.common.components")
        local result = cc.name(config, node, state)
        -- if it is root, customize the name how you want
        if node:get_depth() == 1 then
          result.text = utils.basename(state.path)
        end
        return result
      end
    },
    -- The renderer section provides the renderers that will be used to render the tree.
    --   The first level is the node type.
    --   For each node type, you can specify a list of components to render.
    --       Components are rendered in the order they are specified.
    --         The first field in each component is the name of the function to call.
    --         The rest of the fields are passed to the function as the "config" argument.
    filtered_items = {
      visible = false, -- when true, they will just be displayed differently than normal items
      force_visible_in_empty_folder = false, -- when true, hidden files will be shown if the root folder is otherwise empty
      show_hidden_count = false, -- when true, the number of hidden items in each folder will be shown as the last entry
      hide_dotfiles = true,
      hide_gitignored = true,
      hide_hidden = true, -- only works on Windows for hidden files/directories
      hide_by_name = {
        ".DS_Store",
        "thumbs.db"
        --"node_modules",
      },
      hide_by_pattern = { -- uses glob style patterns
        --"*.meta"
      },
      never_show = { -- remains hidden even if visible is toggled to true
        --".DS_Store",
        --"thumbs.db"
      },
    },
    find_by_full_path_words = false,  -- `false` means it only searches the tail of a path.
                                      -- `true` will change the filter into a full path
                                      -- search with space as an implicit ".*", so
                                      -- `fi init`
                                      -- will match: `./sources/filesystem/init.lua
    group_empty_dirs = false, -- when true, empty folders will be grouped together
    search_limit = 50, -- max number of search results when using filters
    follow_current_file = { -- This will find and focus the file in the active buffer every time
                                 -- the current file is changed while the tree is open.
      enabled = true
    },
    hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                                            -- in whatever position is specified in window.position
                          -- "open_current",-- netrw disabled, opening a directory opens within the
                                            -- window like netrw would, regardless of window.position
                          -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
    use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
                                    -- instead of relying on nvim autocmd events.
  },
  buffers = {
    bind_to_cwd = true,
    follow_current_file = {  -- This will find and focus the file in the active buffer every time
      enabled = true
    },
                                -- the current file is changed while the tree is open.
    group_empty_dirs = true, -- when true, empty directories will be grouped together
    window = {
      mappings = {
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        ["bd"] = "buffer_delete",
      },
    },
  },
  git_status = {
    window = {
      mappings = {
        ["A"] = "git_add_all",
        ["gu"] = "git_unstage_file",
        ["ga"] = "git_add_file",
        ["gr"] = "git_revert_file",
        ["gc"] = "git_commit",
        ["gp"] = "git_push",
        ["gg"] = "git_commit_and_push",
      },
    },
  },
})
