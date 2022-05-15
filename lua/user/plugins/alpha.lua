local alpha_status_ok, alpha = pcall(require, "alpha")
if not alpha_status_ok then
  return
end

local icons_status_ok, icons = pcall(require, "user.icons")
if not icons_status_ok then
  return
end

local plugins = ""
if vim.fn.has "linux" == 1 or vim.fn.has "mac" == 1 then
  local handle = io.popen 'find $HOME"/.config/local/share/nvim/site/pack/packer" -maxdepth 2 | grep pack | wc -l | tr -d "\n" '
  plugins = handle:read "*a"
  handle:close()

  plugins = plugins:gsub("^%s*(.-)%s*$", "%1")
else
  plugins = "N/A"
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
    button("s", icons.reload      .. "   Restore", '<cmd>lua require("persistence").load({ last = true })<cr>]'),
    button("f", icons.folderOpen  .. "   Projects", ":Telescope find_files<CR>"),
    button("u", icons.container   .. "   Update", ":PackerSync<CR>"),
    button("c", icons.cog         .. "   Config", ":e ~/.config/nvim/lua/user/packer.lua<CR>"),
    button("q", icons.quit        .. "   Quit", ":qa!<CR>"),
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
