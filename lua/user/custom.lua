local Menu = require("nui.menu")
local event = require("nui.utils.autocmd").event
local utils = require("user.utils")

local popup_options = {
  relative = "editor",
  -- position = {
  --   row = 1,
  --   col = 0,
  -- },
  position = "50%",
  -- zindex = "50%",
  border = {
    padding = {
      top     = 1,
      bottom  = 1,
      left    = 2,
      right   = 2,
    },
    style = "rounded",
    text = {
      top = "Obsidian",
      top_align = "center",
    },
  },
  buf_options = {
    modifiable = false,
    readonly = false,
  },
  enter = true,
  focusable = true,
  win_options = {
    winhighlight = "Normal:Normal",
  }
}


local menu = Menu(popup_options, {
  lines = {
    -- Menu.separator("Obsidian"),
    Menu.item("c  Create a new note"),
    Menu.item("l  List all notes"),
    Menu.item("s  Search notes"),
    -- Menu.separator("Group Two", {
    --   char = "-",
    --   text_align = "left",
    -- }),
    -- Menu.item("Item 3"),
    -- Menu.item("Item 4"),
  },
  max_width = 60,
  min_width = 30,
  keymap = {
    focus_next = { "j", "<Down>", "<Tab>" },
    focus_prev = { "k", "<Up>", "<S-Tab>" },
    close = { "<Esc>", "<C-c>" },
    submit = { "<CR>", "<Space>" },
  },
  on_close = function()
    print("CLOSED")
  end,
  on_submit = function(item)
    print("SUBMITTED", vim.inspect(item))
  end,
})

menu:on({ event.BufWinEnter }, function ()
  vim.schedule(function ()
    utils.hideCursor()
  end)
end, { once = false })

menu:on({ event.BufLeave }, function ()
  utils.showCursor()
end, { once = true})

menu:mount()
