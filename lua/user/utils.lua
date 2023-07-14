-- Close buffer without closing the window
local M = {}

-- Load Mappings
M.load_mappings = function()
  vim.schedule(function()
    local function set_section_map(section_values)
      section_values.color = nil

      for mode, mode_values in pairs(section_values) do
        local default_opts = vim.tbl_deep_extend("force", { mode = mode }, { noremap = true, silent = true })
        for keybind, mapping_info in pairs(mode_values) do
          -- merge default + user opts
          local opts = vim.tbl_deep_extend("force", default_opts, mapping_info.opts or {})

          mapping_info.opts, opts.mode = nil, nil
          opts.desc = mapping_info[2]

          vim.keymap.set(mode, keybind, mapping_info[1], opts)
        end
      end
    end

    local mappings = require("user.mappings")

    for _, sect in pairs(mappings) do
      set_section_map(sect)
    end
  end)
end

-- Edit Configuration
M.edit_config = function()
  vim.api.nvim_set_current_dir("~/.config/nvim")
  vim.cmd("e ~/.config/nvim/lua/user/lazy.lua")
  vim.cmd("NeoTreeShowToggle")
end

-- M.load_modules = function(modules)
--   for _, module in ipairs(modules) do
--     local ok, err = pcall(require, module)
--     if not ok then
--       error("Error loading " .. module .. "\n\n" .. err)
--     end
--   end
-- end

-- Copy a table into another
-- @param source Source Table
-- @param dest Destination Table
M.copy_table = function(source, dest)
  for k, v in pairs(source) do
    dest[k] = v
  end
end

M.file_exists = function(path)
  local f = io.open(path, "r")
  if f ~= nil then io.close(f) return true else return false end
end

M.get_relative_fname = function()
  local fpath = vim.fn.expand('%')
  local dpath = vim.fn.getcwd() .. '/'
  local dpath_pattern = dpath:gsub("(%W)", "%%%1")

  return fpath:gsub(dpath_pattern, '')
end

M.get_neo_tree_width = function()
  for _, win in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    print(vim.bo[vim.api.nvim_win_get_buf(win)].ft)
    if vim.bo[vim.api.nvim_win_get_buf(win)].ft == "neo-tree" then
      return vim.api.nvim_win_get_width(win) + 1
    end
  end
  return 0
end

M.toggle_theme = function()
  if vim.g.dark_theme then
    vim.o.background = "light"
    vim.g.dark_theme = false
  else
    vim.o.background = "dark"
    vim.g.dark_theme = true
  end
end

M.sleep = function(n)
  os.execute("sleep " .. tonumber(n))
end

M.splitpath = function(path)
  return string.match(path,"^(.-)[\\/]?([^\\/]*)$")
end

M.basename = function(path)
  local _, s2 = M.splitpath(path)
  return s2
end

M.dirname = function(path)
  local s1, _ = M.splitpath(path)
  return s1
end

M.hide_cursor = function ()
  local hl = vim.api.nvim_get_hl_by_name('Cursor', true)
  hl.blend = 100
  vim.api.nvim_set_hl(0, 'Cursor', hl)
  vim.opt.guicursor:append('a:Cursor/lCursor')
end

M.show_cursor = function ()
  local hl = vim.api.nvim_get_hl_by_name('Cursor', true)
  hl.blend = 0
  vim.api.nvim_set_hl(0, 'Cursor', hl)
  vim.opt.guicursor:remove('a:Cursor/lCursor')
end

-- Close current buffer
M.close_buffer = function ()
  local current_buf = vim.api.nvim_get_current_buf()
  require("user.modules.tabline").close_buffer(current_buf)
end

-- Define bg color
-- @param group Group
-- @param color Color
M.bg = function(group, col)
  vim.cmd("hi " .. group .. " guibg=" .. col)
end

-- Define fg color
-- @param group Group
-- @param color Color
M.fg = function(group, col)
  vim.cmd("hi " .. group .. " guifg=" .. col)
end

-- Define bg and fg color
-- @param group Group
-- @param fgcol Fg Color
-- @param bgcol Bg Color
M.fg_bg = function(group, fgcol, bgcol)
  vim.cmd("hi " .. group .. " guifg=" .. fgcol .. " guibg=" .. bgcol)
end

M.contains = function(tbl, x)
  for _, v in pairs(tbl) do
    if v == x then
      return true
    end
  end
  return false
end

-- Print Table
-- @param tbl Table
-- @param indent Indent
M.tprint = function(tbl, indent)
  if not indent then indent = 0 end
  for k, v in pairs(tbl) do
    formatting = string.rep("  ", indent) .. k .. ": "
    if type(v) == "table" then
      print(formatting)
      M.tprint(v, indent+1)
    elseif type(v) == 'boolean' then
      print(formatting .. tostring(v))
    else
      print(formatting .. v)
    end
  end
end


return M
