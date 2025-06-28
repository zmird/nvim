local utils_status_ok, utils = pcall(require, "user.utils")
if not utils_status_ok then
  return
end

local icons_status_ok, icons = pcall(require, "user.icons")
if not icons_status_ok then
  return
end

local fn = vim.fn
local M = {}

M.modes = {
  ["n"] = { "normal", "St_NormalMode" },
  ["no"] = { "normal (no)", "St_NormalMode" },
  ["nov"] = { "normal (nov)", "St_NormalMode" },
  ["noV"] = { "normal (noV)", "St_NormalMode" },
  ["noCTRL-V"] = { "normal", "St_NormalMode" },
  ["niI"] = { "normal i", "St_NormalMode" },
  ["niR"] = { "normal r", "St_NormalMode" },
  ["niV"] = { "normal v", "St_NormalMode" },
  ["nt"] = { "NTERMINAL", "St_NTerminalMode" },
  ["ntT"] = { "NTERMINAL (ntT)", "St_NTerminalMode" },

  ["v"] = { "VISUAL", "St_VisualMode" },
  ["vs"] = { "V-CHAR (Ctrl O)", "St_VisualMode" },
  ["V"] = { "V-LINE", "St_VisualMode" },
  ["Vs"] = { "V-LINE", "St_VisualMode" },
  [""] = { "V-BLOCK", "St_VisualMode" },

  ["i"] = { "INSERT", "St_InsertMode" },
  ["ic"] = { "INSERT (completion)", "St_InsertMode" },
  ["ix"] = { "INSERT completion", "St_InsertMode" },

  ["t"] = { "TERMINAL", "St_TerminalMode" },

  ["R"] = { "REPLACE", "St_ReplaceMode" },
  ["Rc"] = { "REPLACE (Rc)", "St_ReplaceMode" },
  ["Rx"] = { "REPLACEa (Rx)", "St_ReplaceMode" },
  ["Rv"] = { "V-REPLACE", "St_ReplaceMode" },
  ["Rvc"] = { "V-REPLACE (Rvc)", "St_ReplaceMode" },
  ["Rvx"] = { "V-REPLACE (Rvx)", "St_ReplaceMode" },

  ["s"] = { "SELECT", "St_SelectMode" },
  ["S"] = { "S-LINE", "St_SelectMode" },
  [""] = { "S-BLOCK", "St_SelectMode" },
  ["c"] = { "COMMAND", "St_CommandMode" },
  ["cv"] = { "COMMAND", "St_CommandMode" },
  ["ce"] = { "COMMAND", "St_CommandMode" },
  ["r"] = { "PROMPT", "St_ConfirmMode" },
  ["rm"] = { "MORE", "St_ConfirmMode" },
  ["r?"] = { "CONFIRM", "St_ConfirmMode" },
  ["x"] = { "CONFIRM", "St_ConfirmMode" },
  ["!"] = { "SHELL", "St_TerminalMode" },
}

M.mode = function()
  return "%#" .. M.modes[vim.fn.mode()][2] .. "#▊"
end

M.fileInfo = function()
  if vim.bo.ft == "neo-tree" then
    return ""
  end

  return (utils.get_relative_fname() ~= "") and ("%#St_Filename# " .. utils.get_relative_fname() .. " %#St_Text#") or ""
end

M.gitbranch = function()
  if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
    return ""
  end

  return "%#St_Text# " .. icons.git .. " " .. vim.b.gitsigns_status_dict.head .. "  "
end

M.gitchanges = function()
  if not vim.b.gitsigns_head or vim.b.gitsigns_git_status or vim.o.columns < 120 then
    return ""
  end

  local git_status = vim.b.gitsigns_status_dict

  local added = (git_status.added and git_status.added ~= 0)
      and ("%#St_GitAdd# " .. icons.gitAdd .. " " .. git_status.added .. " ")
    or ""
  local changed = (git_status.changed and git_status.changed ~= 0)
      and ("%#St_GitChange# " .. icons.gitChange .. " " .. git_status.changed .. " ")
    or ""
  local removed = (git_status.removed and git_status.removed ~= 0)
      and ("%#St_GitRemove# " .. icons.gitRemove .. " " .. git_status.removed .. " ")
    or ""

  return (added .. changed .. removed)
end

M.LSP_Diagnostics = function()
  if not rawget(vim, "lsp") then
    return ""
  end

  local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
  local info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })

  local errs = (errors and errors > 0) and ("%#St_lspError# " .. icons.symbols.error .. " " .. errors .. " ") or ""
  local warns = (warnings and warnings > 0) and ("%#St_lspWarning# " .. icons.symbols.warning .. " " .. warnings .. " ") or ""
  local hins = (hints and hints > 0) and ("%#St_lspHints# " .. icons.symbols.hint .. " " .. hints .. " ") or ""
  local infs = (info and info > 0) and ("%#St_lspInfo# " .. icons.symbols.info .. " " .. info .. " ") or ""

  return vim.o.columns > 140 and errs .. warns .. hins .. infs or ""
end

M.filetype = function()
  return vim.bo.ft == "" and "%#St_ft# {} plain text  " or "%#St_ft#{} " .. vim.bo.ft .. " "
end

M.LSP_status = function()
  if rawget(vim, "lsp") then
    for _, client in ipairs(vim.lsp.get_clients()) do
      if client.attached_buffers[vim.api.nvim_get_current_buf()] then
        return (vim.o.columns > 100 and "%#St_lspStatus#  " .. icons.gears .. " " .. client.name .. "  ") or ""
      end
    end
  end
end

M.cursor_position = function()
  if vim.bo.ft == "dashboard" then
    return ""
  end

  local left_sep = "%#St_PositionSeparator#" .. "█" .. "%#St_PositionIcon#" .. icons.textFileNoBg .. " "

  local current_line = fn.line "."
  local total_line = fn.line "$"
  local text = math.modf((current_line / total_line) * 100) .. tostring "%%"
  text = string.format("%4s", text)

  text = (current_line == 1 and "Top") or text
  text = (current_line == total_line and "Bot") or text

  return left_sep .. "%#St_PositionText#" .. " " .. text .. " "
end

M.file_encoding = function()
  return string.upper(vim.bo.fileencoding) == "" and "" or "%#St_encode#" .. string.upper(vim.bo.fileencoding) .. "  "
end

M.working_directory = function ()
  local left_sep = "%#St_DirectorySeparator#" .. "█" .. "%#St_DirectoryIcon#" .. icons.folderOpenOutline .. " "
  local cwd = utils.basename(vim.loop.cwd())
  return left_sep .. "%#St_DirectoryText#" .. " " .. cwd .. " "
end

M.run = function()
  return table.concat {
    M.mode(),
    M.fileInfo(),
    M.gitbranch(),
    M.gitchanges(),

    "%=",
    -- M.LSP_progress(),
    "%=",

    M.LSP_Diagnostics(),
    M.LSP_status() or "",
    M.working_directory(),
    M.cursor_position(),
  }
end

return M
