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

function M.close_buffer()
  local current_buf = vim.api.nvim_get_current_buf()
  -- Go to next buffer
  vim.cmd [[BufferLineCycleNext]]
  -- Close previouse buffer
  vim.cmd("bd " .. current_buf)
end

return M
