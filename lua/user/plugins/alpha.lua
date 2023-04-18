local alpha_status_ok, alpha = pcall(require, "alpha")
if not alpha_status_ok then
  return
end

local icons_status_ok, icons = pcall(require, "user.icons")
if not icons_status_ok then
  return
end

local lazy_status_ok, lazy = pcall(require, "lazy")


local plugins = "N/A"

if lazy_status_ok then
  plugins = lazy.stats().count
end

local pluginCount = {
  type = "text",
  val = "Loaded " .. plugins .. " plugins",
  opts = {
    position = "center",
    hl = "String",
  },
}
local function button(sc, txt, keybind)
  local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

  local opts = {
    position = "center",
    text = txt,
    shortcut = sc,
    cursor = 6,
    width = 19,
    align_shortcut = "right",
    hl_shortcut = "Number",
    hl = "Function",
  }
  if keybind then
    opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
  end

  return {
    type = "button",
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
      vim.api.nvim_feedkeys(key, "normal", false)
    end,
    opts = opts,
  }
end

local buttons = {
  type = "group",
  val = {
    button("p", icons.folderOpen      .. "   Projects", ":Telescope projects<CR>"),
    button("c", icons.cog             .. "   Config", ":cd ~/.config/nvim<CR>:e ~/.config/nvim/lua/user/lazy.lua<CR><cmd>NeoTreeShowToggle<cr>"),
    button("l", icons.container       .. "   Lazy", ":Lazy<CR>"),
    button("q", icons.quit            .. "   Quit", ":qa!<CR>"),
  },
  opts = {
    position = "center",
    spacing = 1,
  },
}

local section = {
  buttons = buttons,
  pluginCount = pluginCount,
}

local opts = {
  layout = {
    { type = "padding", val = 9 },
    section.buttons,
    { type = "padding", val = 2 },
    section.pluginCount,
  },
  opts = {
    margin = 44,
  },
}

alpha.setup(opts)
