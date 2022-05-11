-- Close buffer without closing the window
local M = {}

M.load_modules = function(modules)
  for _, module in ipairs(modules) do
    local ok, err = pcall(require, module)
    if not ok then
      error("Error loading " .. module .. "\n\n" .. err)
    end
  end
end

M.file_exists = function(path)
  local f = io.open(path, "r")
  if f ~= nil then io.close(f) return true else return false end
end

M.get_relative_fname = function()
  local fname = vim.fn.expand('%:p')
  return fname:gsub(vim.fn.getcwd() .. '/', '')
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

-- Close current buffer
function M.close_buffer()
  local current_buf = vim.api.nvim_get_current_buf()
  -- Go to next buffer
  vim.cmd [[BufferLineCycleNext]]
  -- Close previouse buffer
  vim.cmd("bd " .. current_buf)
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

return M
