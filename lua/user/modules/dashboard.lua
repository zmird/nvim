local icons_status_ok, icons = pcall(require, "user.icons")
if not icons_status_ok then
  return
end

local lazy_status_ok, lazy = pcall(require, "lazy")

local M = {}
local api = vim.api
local fn = vim.fn

local config = {
  load_on_startup = true,
  empty_line = "                          ",

  -- header = {
  --   "                                 ",
  --   "                                 ",
  --   "           ▄ ▄                   ",
  --   "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
  --   "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
  --   "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
  --   "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
  --   "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
  --   "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
  --   "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
  --   "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
  --   "                                 ",
  --   "                                 ",
  -- },
  header = {},

  buttons = {
    { icons.folderOpen  .. "  Projects", "p", "Telescope projects" },
    { icons.textFile    .. "  New Buffer", "e", "enew" },
    { icons.cog         .. "  Config", "c", "EditConfig" },
    { icons.container   .. "  Lazy", "l", "Lazy" },
    { icons.quit        .. "  Quit", "q", "qa" },
  },
}

local headerAscii = config.header
local empty_line = config.empty_line

-- local dashboardWidth = #empty_line > 0 and #empty_line[1] + 3 or 3
local dashboardWidth = #empty_line + 3

local max_height = #headerAscii + 4 + (2 * #config.buttons) -- 4  = extra spaces i.e top/bottom
local get_win_height = api.nvim_win_get_height

M.open = function()
  local buf = vim.api.nvim_create_buf(false, true)
  local win = api.nvim_get_current_win()

  -- switch to larger win if cur win is small
  if dashboardWidth + 6 > api.nvim_win_get_width(0) then
    vim.api.nvim_set_current_win(api.nvim_list_wins()[2])
    win = api.nvim_get_current_win()
  end

  api.nvim_win_set_buf(win, buf)

  vim.opt_local.filetype = "dashboard"
  -- vim.g.nvdash_displayed = true

  local header = headerAscii
  local buttons = config.buttons

  local function addSpacing_toBtns(txt1, txt2)
    local btn_len = fn.strwidth(txt1) + fn.strwidth(txt2)
    local spacing = fn.strwidth(empty_line) - btn_len
    return txt1 .. string.rep(" ", spacing - 1) .. txt2 .. " "
  end

  local function addPadding_toHeader(str)
    local pad = (api.nvim_win_get_width(win) - fn.strwidth(str)) / 2
    return string.rep(" ", math.floor(pad)) .. str .. " "
  end

  local function addPadding_toString(str)
    local spacing = fn.strwidth(empty_line) - fn.strwidth(str) - 2
    local padding = string.rep(" ", math.floor(spacing/2))
    return padding .. str .. padding .. "  "
  end

  local dashboard = {}

  for _, val in ipairs(header) do
    table.insert(dashboard, val .. " ")
  end

  for _, val in ipairs(buttons) do
    table.insert(dashboard, addSpacing_toBtns(val[1], val[2]) .. " ")
    table.insert(dashboard, empty_line .. " ")
  end

  if lazy_status_ok then
    local plugins_message = "Loaded " .. lazy.stats().count .. " plugins"

    table.insert(dashboard, empty_line .. " ")
    table.insert(dashboard, empty_line .. " ")
    table.insert(dashboard, addPadding_toString(plugins_message))
    table.insert(dashboard, empty_line .. " ")
  end

  local result = {}

  -- make all lines available
  for i = 1, math.max(get_win_height(win), max_height) do
    result[i] = ""
  end

  local headerStart_Index = math.abs(math.floor((get_win_height(win) / 2) - (#dashboard / 2))) + 1 -- 1 = To handle zero case
  local abc = math.abs(math.floor((get_win_height(win) / 2) - (#dashboard / 2))) + 1 -- 1 = To handle zero case

  -- set ascii
  for _, val in ipairs(dashboard) do
    result[headerStart_Index] = addPadding_toHeader(val)
    headerStart_Index = headerStart_Index + 1
  end

  api.nvim_buf_set_lines(buf, 0, -1, false, result)

  -- Highlighting
  local namespace = api.nvim_create_namespace "dashboard"
  local horiz_pad_index = math.floor((api.nvim_win_get_width(win) / 2) - (dashboardWidth / 2)) - 2

  for i = abc, abc + #header do
    api.nvim_buf_add_highlight(buf, namespace, "DashboardAscii", i, horiz_pad_index, -1)
  end

  for i = abc + #header - 2, abc + #dashboard - 3 do
    api.nvim_buf_add_highlight(buf, namespace, "DashboardButtons", i, horiz_pad_index, -1)
  end

  for i = abc + #dashboard - 3, abc + #dashboard do
    api.nvim_buf_add_highlight(buf, namespace, "DashboardMessage", i, horiz_pad_index, -1)
  end

  api.nvim_win_set_cursor(win, { abc + #header, math.floor(vim.o.columns / 2) - 13 })

  local first_btn_line = abc + #header + 2
  local keybind_lineNrs = {}

  for _, _ in ipairs(config.buttons) do
    table.insert(keybind_lineNrs, first_btn_line - 2)
    first_btn_line = first_btn_line + 2
  end

  -- set keymaps
  for _, button in ipairs(buttons) do
    local key = button[2]
    vim.keymap.set("n", key, function()
      local action = button[3]

      if type(action) == "string" then
        vim.cmd(action)
      elseif type(action) == "function" then
        action()
      end
    end, { buffer = 0 })
  end

  -- Hide cursor with highlighting
  api.nvim_buf_add_highlight(buf, namespace, "Cursor", 0, 0, 0)

  -- move cursor out of the way
  vim.cmd("normal! G")

  -- buf only options
  vim.opt_local.buflisted = false
  vim.opt_local.modifiable = false
  vim.opt_local.number = false
  vim.opt_local.list = false
  vim.opt_local.relativenumber = false
  vim.opt_local.wrap = false
  vim.opt_local.cul = false
  vim.opt_local.cursorline = false
  vim.opt_local.cursorcolumn = false
end

return M
