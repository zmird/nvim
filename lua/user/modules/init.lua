require "user.modules.tabline"

vim.opt.statusline = "%!v:lua.require('user.modules.statusline').run()"

vim.defer_fn(function()
  if #vim.fn.argv() == 0 then
    require("user.modules.dashboard").open()
  end
end, 0)

vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    if vim.bo.filetype == "dashboard" then
      vim.opt_local.modifiable = true
      vim.api.nvim_buf_set_lines(0, 0, -1, false, { "" })
      require("user.modules.dashboard").open()
    elseif vim.bo.filetype == "cheatsheet" then
      vim.opt_local.modifiable = true
      vim.api.nvim_buf_set_lines(0, 0, -1, false, { "" })
      require("user.modules.cheatsheet")()
    end
  end,
})

vim.api.nvim_create_user_command("Cheatsheet", function()
  if vim.g.nvcheatsheet_displayed then
    vim.cmd "bd"
  else
    require("user.modules.cheatsheet")()
  end
end, {})
