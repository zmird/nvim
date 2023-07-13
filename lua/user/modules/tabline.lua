---------------------------------------------------------- require ------------------------------------------------------------

local icons_ok, icons = pcall(require, "user.icons")
if not icons_ok then
  print("Error in loading tabline: could not load icons")
  return
end

local devicons_ok, devicons = pcall(require, "nvim-web-devicons")
if not devicons_ok then
  print("Error in loading tabline: could not load devicons")
  return
end

---------------------------------------------------------- global aliases ------------------------------------------------------------

local api = vim.api
local fn = vim.fn

-- store listed buffers in tab local var
vim.t.bufs = vim.api.nvim_list_bufs()

local listed_bufs = {}

for _, val in ipairs(vim.t.bufs) do
  if vim.bo[val].buflisted then
    table.insert(listed_bufs, val)
  end
end

vim.t.bufs = listed_bufs

---------------------------------------------------------- draw module ------------------------------------------------------------

local D = {}

D.isBufValid = function(bufnr)
  return vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted
end

D.new_hl = function(group1, group2)
  local fg = fn.synIDattr(fn.synIDtrans(fn.hlID(group1)), "fg#")
  local bg = fn.synIDattr(fn.synIDtrans(fn.hlID(group2)), "bg#")
  api.nvim_set_hl(0, "Tabline" .. group1 .. group2, { fg = fg, bg = bg })
  return "%#" .. "Tabline" .. group1 .. group2 .. "#"
end

D.get_neotree_width =  function()
  for _, win in pairs(api.nvim_tabpage_list_wins(0)) do
    if vim.bo[api.nvim_win_get_buf(win)].ft == "neo-tree" then
      return api.nvim_win_get_width(win) + 1
    end
  end
  return 0
end

D.get_buttons_width = function() -- close, theme toggle btn etc
  local width = 6
  if fn.tabpagenr "$" ~= 1 then
    width = width + ((3 * fn.tabpagenr "$") + 2) + 10
    -- width = not vim.g.TablineTabsToggled and 8 or width
  end
  return width
end

D.add_file_info = function(name, bufnr)
  local icon, icon_hl = devicons.get_icon(name, string.match(name, "%a+$"))

  if not icon then
    icon = icons.textFile
    icon_hl = "DevIconDefault"
  end

  icon = (
    api.nvim_get_current_buf() == bufnr and D.new_hl(icon_hl, "TablineBufOn") .. " " .. icon
    or D.new_hl(icon_hl, "TablineBufOff") .. " " .. icon
  )

  -- check for same buffer names under different dirs
  for _, value in ipairs(vim.t.bufs) do
    if D.isBufValid(value) then
      if name == fn.fnamemodify(api.nvim_buf_get_name(value), ":t") and value ~= bufnr then
        local other = {}
        for match in (vim.fs.normalize(api.nvim_buf_get_name(value)) .. "/"):gmatch("(.-)" .. "/") do
          table.insert(other, match)
        end

        local current = {}
        for match in (vim.fs.normalize(api.nvim_buf_get_name(bufnr)) .. "/"):gmatch("(.-)" .. "/") do
          table.insert(current, match)
        end

        name = current[#current]

        for i = #current - 1, 1, -1 do
          local value_current = current[i]
          local other_current = other[i]

          if value_current ~= other_current then
            if (#current - i) < 2 then
              name = value_current .. "/" .. name
            else
              name = value_current .. "/../" .. name
            end
            break
          end
        end
        break
      end
    end
  end

  -- padding around bufname; 24 = bufame length (icon + filename)
  local padding = (24 - #name - 5) / 2
  local maxname_len = 16

  name = (#name > maxname_len and string.sub(name, 1, 14) .. "..") or name
  name = (api.nvim_get_current_buf() == bufnr and "%#TablineBufOn# " .. name) or ("%#TablineBufOff# " .. name)

  return string.rep(" ", padding) .. icon .. name .. string.rep(" ", padding)
end

D.style_tabs = function(nr)
  local close_btn = "%" .. nr .. "@TablineKillBuf@ " .. icons.cross .. " %X"
  local name = (#api.nvim_buf_get_name(nr) ~= 0) and fn.fnamemodify(api.nvim_buf_get_name(nr), ":t") or " No Name "
  name = "%" .. nr .. "@TablineGoToBuf@" .. D.add_file_info(name, nr) .. "%X"

  -- color close btn for focused / hidden  buffers
  if nr == api.nvim_get_current_buf() then
    close_btn = (vim.bo[0].modified and "%" .. nr .. "@TablineKillBuf@%#TablineBufOnModified# " .. icons.dot .. " ")
      or ("%#TablineBufOnClose#" .. close_btn)
    name = "%#TablineBufOn#" .. name .. close_btn
  else
    close_btn = (vim.bo[nr].modified and "%" .. nr .. "@TablineKillBuf@%#TablineBufOffModified# " .. icons.dot .. " ")
      or ("%#TablineBufOffClose#" .. close_btn)
    name = "%#TablineBufOff#" .. name .. close_btn
  end

  return name
end

D.draw_neotree_padding = function()
  return "%#NeoTreeNormal#" .. (vim.g.nvimtree_side == "right" and "" or string.rep(" ", D.get_neotree_width()))
end

D.draw_bufferlist = function()
  local buffers = {} -- buffersults
  local available_space = vim.o.columns - D.get_neotree_width() - D.get_buttons_width()
  local current_buf = api.nvim_get_current_buf()
  local has_current = false -- have we seen current buffer yet?

  for _, bufnr in ipairs(vim.t.bufs) do
    if D.isBufValid(bufnr) then
      if ((#buffers + 1) * 21) > available_space then
        if has_current then
          break
        end

        table.remove(buffers, 1)
      end

      has_current = (bufnr == current_buf and true) or has_current
      table.insert(buffers, D.style_tabs(bufnr))
    end
  end

  vim.g.visibuffers = buffers -- used?
  return table.concat(buffers) .. "%#TabLineFill#" .. "%=" -- buffers + empty space
end

D.draw_buttons = function()
  local toggleIcon = (vim.g.dark_theme and icons.toggleBigSelected) or icons.toggleBig
  local toggle_themeBtn = "%@TablineToggleTheme@%#TablineThemeToggleBtn# " .. toggleIcon .. "  " .. "%X"
  local CloseAllBufsBtn = "%@TablineCloseAllBufs@%#TablineCloseAllBufsBtn# " .. icons.cross .. " %X"
  return toggle_themeBtn .. CloseAllBufsBtn
end

---------------------------------------------------------- Auto commands ------------------------------------------------------------

vim.api.nvim_create_autocmd({ "BufAdd", "BufEnter", "tabnew" }, {
  callback = function(args)
    local bufs = vim.t.bufs

    if vim.t.bufs == nil then
      vim.t.bufs = vim.api.nvim_get_current_buf() == args.buf and {} or { args.buf }
    else
      -- check for duplicates
      if
        not vim.tbl_contains(bufs, args.buf)
        and (args.event == "BufEnter" or vim.bo[args.buf].buflisted or args.buf ~= vim.api.nvim_get_current_buf())
        and vim.api.nvim_buf_is_valid(args.buf)
        and vim.bo[args.buf].buflisted
      then
        table.insert(bufs, args.buf)

        -- remove unnamed buffer which isnt current buf & modified
        for index, bufnr in ipairs(bufs) do
          if
            #vim.api.nvim_buf_get_name(bufnr) == 0
            and (vim.api.nvim_get_current_buf() ~= bufnr or bufs[index + 1])
            and not vim.api.nvim_buf_get_option(bufnr, "modified")
          then
            table.remove(bufs, index)
          end
        end

        vim.t.bufs = bufs
      end
    end
  end,
})

vim.api.nvim_create_autocmd("BufDelete", {
  callback = function(args)
    for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
      local bufs = vim.t[tab].bufs
      if bufs then
        for i, bufnr in ipairs(bufs) do
          if bufnr == args.buf then
            table.remove(bufs, i)
            vim.t[tab].bufs = bufs
            break
          end
        end
      end
    end
  end,
})

-- lazy load
vim.api.nvim_create_autocmd({ "BufNew", "BufNewFile", "BufRead", "TabEnter", "TermOpen" }, {
  pattern = "*",
  group = vim.api.nvim_create_augroup("TabuflineLazyLoad", {}),
  callback = function()
    if #vim.fn.getbufinfo { buflisted = 1 } >= 2 or #vim.api.nvim_list_tabpages() >= 2 then
      vim.opt.showtabline = 2
      vim.opt.tabline = "%!v:lua.require('user.modules.tabline').run()"
      vim.api.nvim_del_augroup_by_name "TabuflineLazyLoad"
    end
  end,
})

---------------------------------------------------------- onclick functions ----------------------------------------------

vim.cmd "function! TablineGoToBuf(bufnr,b,c,d) \n execute 'b'..a:bufnr \n endfunction"

vim.cmd [[
   function! TablineKillBuf(bufnr,b,c,d) 
        call luaeval('require("user.modules.tabline").close_buffer(_A)', a:bufnr)
  endfunction]]

vim.cmd "function! TablineNewTab(a,b,c,d) \n tabnew \n endfunction"
vim.cmd "function! TablineGotoTab(tabnr,b,c,d) \n execute a:tabnr ..'tabnext' \n endfunction"
vim.cmd "function! TablineTabClose(a,b,c,d) \n lua require('user.modules.tabline').closeAllBufs('closeTab') \n endfunction"
vim.cmd "function! TablineCloseAllBufs(a,b,c,d) \n lua require('user.modules.tabline').closeAllBufs() \n endfunction"
vim.cmd "function! TablineToggleTheme(a,b,c,d) \n lua require('user.utils').toggle_theme() \n endfunction"
vim.cmd "function! TablineToggleTabs(a,b,c,d) \n let g:TablineTabsToggled = !g:TablineTabsToggled | redrawtabline \n endfunction"


---------------------------------------------------------- main module ------------------------------------------------------------

local M = {}

M.bufilter = function()
  local bufs = vim.t.bufs or nil

  if not bufs then
    return {}
  end

  for i = #bufs, 1, -1 do
    if not vim.api.nvim_buf_is_valid(bufs[i]) and vim.bo[bufs[i]].buflisted then
      table.remove(bufs, i)
    end
  end

  return bufs
end

M.get_buf_index = function(bufnr)
  for i, value in ipairs(vim.t.bufs) do
    if value == bufnr then
      return i
    end
  end
end

M.next = function()
  local bufs = M.bufilter() or {}
  local curbufIndex = M.get_buf_index(api.nvim_get_current_buf())

  if not curbufIndex then
    vim.cmd("b" .. vim.t.bufs[1])
    return
  end

  vim.cmd(curbufIndex == #bufs and "b" .. bufs[1] or "b" .. bufs[curbufIndex + 1])
end

M.prev = function()
  local bufs = M.bufilter() or {}
  local curbufIndex = M.get_buf_index(api.nvim_get_current_buf())

  if not curbufIndex then
    vim.cmd("b" .. vim.t.bufs[1])
    return
  end

  vim.cmd(curbufIndex == 1 and "b" .. bufs[#bufs] or "b" .. bufs[curbufIndex - 1])
end

M.close_buffer = function(bufnr)
  if vim.bo.buftype == "terminal" then
    vim.cmd(vim.bo.buflisted and "set nobl | enew" or "hide")
  else
    bufnr = bufnr or api.nvim_get_current_buf()
    local curBufIndex = M.get_buf_index(bufnr)
    local bufhidden = vim.bo.bufhidden

    -- force close floating wins
    if bufhidden == "wipe" then
      vim.cmd "bw"
      return

      -- handle listed bufs
    elseif curBufIndex and #vim.t.bufs > 1 then
      local newBufIndex = curBufIndex == #vim.t.bufs and -1 or 1
      vim.cmd("b" .. vim.t.bufs[curBufIndex + newBufIndex])

    -- handle unlisted
    elseif not vim.bo.buflisted then
      vim.cmd("b" .. vim.t.bufs[1] .. " | bw" .. bufnr)
      return
    else
      vim.cmd "enew"
    end

    if not (bufhidden == "delete") then
      vim.cmd("confirm bd" .. bufnr)
    end
  end

  vim.cmd "redrawtabline"
end

-- closes tab + all of its buffers
M.closeAllBufs = function(action)
  local bufs = vim.t.bufs

  if action == "closeTab" then
    vim.cmd "tabclose"
  end

  for _, buf in ipairs(bufs) do
    M.close_buffer(buf)
  end

  if action ~= "closeTab" then
    vim.cmd "enew"
  end
end

-- closes all bufs except current one
M.closeOtherBufs = function()
  for _, buf in ipairs(vim.t.bufs) do
    if buf ~= api.nvim_get_current_buf() then
      vim.api.nvim_buf_delete(buf, {})
    end
  end

  vim.cmd "redrawtabline"
end

-- closes all other buffers right or left
M.closeBufs_at_direction = function(x)
  local bufindex = M.get_buf_index(api.nvim_get_current_buf())

  for i, bufnr in ipairs(vim.t.bufs) do
    if (x == "left" and i < bufindex) or (x == "right" and i > bufindex) then
      M.close_buffer(bufnr)
    end
  end
end

M.move_buf = function(n)
  local bufs = vim.t.bufs

  for i, bufnr in ipairs(bufs) do
    if bufnr == vim.api.nvim_get_current_buf() then
      if n < 0 and i == 1 or n > 0 and i == #bufs then
        bufs[1], bufs[#bufs] = bufs[#bufs], bufs[1]
      else
        bufs[i], bufs[i + n] = bufs[i + n], bufs[i]
      end

      break
    end
  end

  vim.t.bufs = bufs
  vim.cmd "redrawtabline"
end

M.run = function()
  -- local result = modules.bufferlist() .. (modules.tablist() or "") .. modules.buttons()
  local result = D.draw_bufferlist() .. D.draw_buttons()
  return D.draw_neotree_padding() .. result
end

return M
